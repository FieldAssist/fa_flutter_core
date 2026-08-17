# Activity Tracking

Tracks how long users spend in each part of the app, across **every FieldAssist
app sharing the process**, buffers it locally, and hands batches to the host app
to upload.

## Why it lives in core

FA One is a git dependency of GT and is mounted inside it, so both run in one
process. That means they already share:

- one `SharedPreferences` store (`SharedPreferences.getInstance()` is a
  process-wide singleton), and
- one Realm database — `fa_flutter_activity.realm`, holding the closed sessions
  waiting to be uploaded.

Putting the repository here gives them a **single instance over that shared
state**. That is what makes this work:

```dart
// in fa_flutter_one
await ActivityRepository.instance.track(
  name: 'Social Feed',
  moduleEnum: ActivityModule.faOne,
  subModuleEnum: ActivitySubModule.faOneSocialSession,
  source: ActivitySource.faOne,
);

// later, in fa_flutter_gt — closes the session FA One opened
await ActivityRepository.instance.endCurrentSession();
```

Neither app needs to know the other exists, and neither imports the other.

## Setup

Call once per process, as early as possible. It is **idempotent**, so every app
can call it defensively — whoever runs first creates the instance and the rest
receive it.

```dart
await ActivityRepository.initialise(
  appPrefs: locator<AppPrefs>(),
  // Only the app that owns syncing needs to pass this. A non-null uploader
  // always replaces the stored one, so ordering does not matter.
  uploader: (activities) async {
    if (!await networkInfo.isConnected) {
      throw const SocketException('Offline');   // throw => keep buffered
    }
    await apiHelper.post(
      endpoint: ApiEndpoints.addAppActivities(),
      // toApiJson(), not toJson() — the latter is the local storage format.
      body: jsonEncode(activities.map((a) => a.toApiJson()).toList()),
    );
  },
);
```

Core has no `ApiHelper` of its own — each app brings its own auth and base URL —
so uploading is a callback. **Return normally on success, throw on failure.** A
throw keeps the batch buffered for the next attempt.

## Usage

```dart
final activity = ActivityRepository.instance;

// Open or continue a session. Same screen => keeps accumulating.
await activity.track(
  name: 'Order Booking',
  moduleEnum: ActivityModule.generalTrade,
);

// Rename the open session without splitting it (e.g. a sub-tab switch)
await activity.updateCurrentSession(name: 'Order Summary');

// Force a fresh guid even on the same screen
await activity.startSession(
  name: 'Order Booking',
  moduleEnum: ActivityModule.generalTrade,
);

// Close and buffer — works regardless of which app opened it
await activity.endCurrentSession();

// App lifecycle: close but remember, then reopen as a new session
await activity.pauseCurrentSession();   // on background
await activity.resumeLastSession();     // on foreground

// Upload; also closes and reopens the open session so long visits report
await activity.sync(includeCurrentSession: true);
```

Tracking is deliberately **manual** — there is no route observer here, and none
is expected. Call `track()` from the screens you care about.

### Background / foreground

`pauseCurrentSession()` closes the open session *and stashes what it was*;
`resumeLastSession()` reopens it as a new session (fresh guid, `startTime` of
now) and clears the stash. Time spent backgrounded is therefore not counted, but
the user does not have to re-navigate for tracking to continue.

`resumeLastSession()` no-ops if a session is already open — whatever opened it
is more current than the stash.

In fire-and-forget paths (route observers, lifecycle handlers) prefer
`ActivityRepository.instanceOrNull?.…` so tracking silently no-ops before
startup finishes rather than throwing.

## Flow

```
track(name, moduleEnum, subModuleEnum, source)
      │
      ├─ same screen?  → leave open session running (duration accumulates)
      │
      └─ different?    → stamp endTime on the open session
                         └─ move it to Realm
                         └─ open a new session in SharedPreferences
      │
      ▼
sync()  → uploader(batch) → on success remove those guids
                          → on throw  keep for next attempt
```

## Files

| File | Role |
| --- | --- |
| `src/activity_repository.dart` | Contract + `initialise` / `instance` |
| `src/activity_repository_impl.dart` | Prefs (open session) + DAO (closed) |
| `src/dao/activity_dao.dart` / `_impl` | Realm buffer, capped at 2000 |
| `src/db/activity_realm_db.dart` / `_impl` | Opens / closes the Realm file |
| `src/models/activity_session.dart` | Domain model + `ActivitySource` / `ActivityModule` / `ActivitySubModule` + `toApiJson()` |
| `src/models/activity_session_entity.dart` | The Realm row + mappers to and from the domain model |

## Wire format

`toApiJson()` produces the backend's `FaOneUserActivityModel`:

| JSON key | Source |
| --- | --- |
| `guid` | `guid` |
| `activityDescription` | `name` |
| `moduleName` | `moduleEnum.label` |
| `moduleEnum` | `moduleEnum.id` — **never null**, see below |
| `subModuleName` | `subModuleEnum?.label`, or null |
| `subModuleEnum` | `subModuleEnum?.id`, or null (`int?` server side) |
| `startTime` / `endTime` | local ISO-8601, second precision, no offset |

**The enums are the identity.** There is no free-text module or submodule
anywhere — not on the wire, not in the model, not in the API. Each `*Name` is
the `label` of the same enum value that produced the `*Enum` beside it, so the
pair cannot drift, and `isSameScreenAs` compares the enums rather than strings
two call sites might spell differently.

`name` (`activityDescription`) is the one field that still carries free text.
Anything the backend needs to see beyond the enum goes there — a deep-link path,
a tapped card, a screen label.

`ActivityModule` and `ActivitySubModule` each carry the integer that goes on the
wire:

| `ActivityModule` | `id` | `label` |
| --- | --- | --- |
| `generalTrade` | 1 | `GeneralTrade` |
| `faOne` | 2 | `FaOne` |
| `embeddedGtFaOne` | 3 | `EmbeddedGTFaOne` |

| `ActivitySubModule` | `id` | `label` |
| --- | --- | --- |
| `gtPinPage` | 10 | `GTPinPage` |
| `faOneSocialTap` | 20 | `FaOneSocialTap` |
| `faOneLearningTap` | 21 | `FaOneLearningTap` |
| `faOneLeaderboardTap` | 22 | `FaOneLeaderboardTap` |
| `faOneSfaTap` | 23 | `FaOneSfaTap` |
| `faOneHomePageLand` | 24 | `FaOneHomePageLand` |
| `faOneSocialSession` | 25 | `FaOneSocialSession` |
| `faOneLearningSession` | 26 | `FaOneLearningSession` |
| `embeddedGtFaOneSession` | 30 | `EmbeddedGTFaOneSession` |

> `embeddedGtFaOneSession` stayed at 30 rather than shifting to 31 with the
> block above it — the tens read as ranges (10s GT, 20s FA One, 30s embedded)
> and 26 collides with nothing. Say so if it should move.

`Tap` values pair with `logEvent()` (an instant), `Session` values with
`track()` / `startSession()` (a span).

`moduleEnum` is **required** on `track()` / `logEvent()` / `startSession()`,
which is what makes the backend's non-nullable `ModuleEnum` structurally
satisfied — there is no path that could send null. Screens pass `generalTrade`
or `faOne`; `embeddedGtFaOne` is reserved for the app-level session below.

`subModuleEnum` is optional and has no fallback: null is sent as null, and
`subModuleName` goes null with it rather than naming a submodule the enum does
not cover.

```dart
// a span
await ActivityRepository.instance.track(
  name: 'Social Feed',
  moduleEnum: ActivityModule.faOne,
  subModuleEnum: ActivitySubModule.faOneSocialSession,
  source: ActivitySource.faOne,
);

// an instant
await ActivityRepository.instance.logEvent(
  name: 'Social tapped',
  moduleEnum: ActivityModule.faOne,
  subModuleEnum: ActivitySubModule.faOneSocialTap,
  source: ActivitySource.faOne,
);
```

Both are stored by **name**, not by `id`, precisely because ids are not unique —
an `id` of 22 could not be read back unambiguously.

`toJson()` / `fromJson()` remain the *storage* format, with `ModuleEnum` and
`SubModuleEnum` added as nullable keys so sessions buffered before these fields
existed still decode.

## Total application usage

`embeddedGtFaOne` / `embeddedGtFaOneSession` do **not** mean "FA One inside GT"
— they mean *the application as a whole*, and answer "how long has the user used
the app". That span is owned by a separate pair of calls:

```dart
await ActivityRepository.instance.startAppSession();  // on launch and on resume
await ActivityRepository.instance.endAppSession();    // on background
```

It runs **in parallel with** `track()` / `currentSession`, not through it. The
screen chain holds one open session at a time, so an app-wide span could not
live there — the next `track()` would close it. It gets its own
SharedPreferences key (`APP_SESSION_ACTIVITY`) and is buffered only by
`endAppSession()`.

`startAppSession()` is idempotent: calling it while a segment is running returns
that segment rather than restarting the clock, so a re-entered lifecycle
callback cannot silently discard elapsed time.

Total usage is the **sum of the segments**, one per foreground stretch.
Backgrounded time is excluded, and each segment is buffered the moment the app
backgrounds — which is also when the background sync runs, so a segment is
uploaded rather than lost if the process is then killed.

GT drives both ends: `_initActivityRepository` opens the first segment (a cold
start never fires `resumed`), and `AppState.didChangeAppLifecycleState` closes
and reopens the rest. Screens keep reporting `generalTrade` / `faOne` as before.

## Storage

Closed sessions live in a local Realm, `fa_flutter_activity.realm`, next to the
app's documents on Android and iOS. `ActivitySessionEntity` is keyed by `guid`,
so re-adding the same session updates its row instead of duplicating it.

The domain model stays a plain freezed class and never leaves the DAO as a
managed Realm object, so nothing upstream has to care whether the database that
produced it is still open.

Two things are worth knowing:

- **A Realm cannot cross isolates.** Each isolate opens its own handle against
  the same file and Realm coordinates the concurrent access, which is exactly
  what GT's background sync task needs. `ActivityRepository.initialise()` is
  per-isolate for the same reason, so a background isolate simply calls it
  again.
- **The schema is disposable.** The Realm is opened with
  `shouldDeleteIfMigrationNeeded: true`. This database is an upload buffer, not
  a source of truth — anything in it is at most a few minutes of usage data —
  so a schema change drops it rather than requiring a migration, and can never
  fail to open and silently stop tracking.

Realm has no web support, so activity tracking is Android/iOS/desktop only.

## Debugging

Every state change prints to console under `fa_activity`, tagged `[Activity]`
(repository) or `[ActivityDao]` (buffer). Filter your console on `[Activity`.

Each line carries `source:ModuleName/SubModuleName "name" [guid8]` — the same
names the backend receives, since both come off the enums — so one session can
be followed end to end — opened on one screen, closed on another, uploaded from
the background isolate — and matched against what the backend received:

```
[Activity] App session started sfa:EmbeddedGTFaOne/EmbeddedGTFaOneSession "Application" [7c11ab02]
[Activity] Started sfa:GeneralTrade "Order Booking" [3f6b1c9e]
[ActivityDao] Buffered, 4 pending
[Activity] Continue sfa:GeneralTrade "Order Booking" [3f6b1c9e] (1523ms so far)
[Activity] Switch sfa:GeneralTrade "Order Booking" [3f6b1c9e] -> FaOne
[Activity] Closed sfa:GeneralTrade "Order Booking" [3f6b1c9e] after 4820ms, buffered for upload
[Activity] Paused faOne:FaOne/FaOneSocialSession "Social Feed" [9a2f01bd], stashed for resume
[Activity] App session closed sfa:EmbeddedGTFaOne/EmbeddedGTFaOneSession "Application" [7c11ab02] after 41320ms, buffered for upload
[Activity] Resuming faOne:FaOne/FaOneSocialSession "Social Feed" [9a2f01bd] as a new session
[Activity] Uploading 5 session(s)...
[Activity]   -> sfa:GeneralTrade "Order Booking" [3f6b1c9e]
[Activity] Synced 5 session(s) in 412ms, buffer cleared
```

Levels: `d` for normal flow, `w` for things worth noticing (no uploader, buffer
overflow, state cleared), `e` for upload failures.

> `.v()` is **not** used anywhere here on purpose. In `logger` 2.x
> `Level.verbose` is 999 while the default `Logger.level` is `trace` (1000), so
> verbose lines are silently discarded and would never reach the console.

Sync frequency is owned by the host app, not core — GT drives it from
`BackgroundTaskHandler.fetchIntervalInMinutes` (Android 5 min, iOS 15 min).

## Notes

- **Mutations are serialized** on an internal queue. Callers fire `track()`
  without awaiting, and two apps share the instance, so without it two
  navigations could interleave their read-modify-write of the current session.
  Public methods take the lock; the private `*Unlocked` variants exist so
  internal calls don't deadlock.
- **Background isolates get their own instance.** A second isolate has its own
  prefs cache, so it should sync with `includeCurrentSession: false` — closing
  the open session there would be invisible to the foreground and could
  double-report the same span.
- `source` distinguishes which app produced a row. Without it the backend cannot
  tell GT usage from FA One usage, since they share everything else.
- The buffer is capped at 2000 sessions; if uploads keep failing the oldest are
  dropped rather than growing the database without limit.
