import '../../../fa_flutter_core.dart';

typedef ActivityUploader = Future<void> Function(
  List<ActivitySession> activities,
);

/// Call [initialise] once per process, as early as possible. It is idempotent,
/// so every app in the process can call it defensively — whoever gets there
/// first creates the instance and the rest receive it.
abstract class ActivityRepository {
  static const String defaultDatabaseName = 'fa_flutter_activity';

  static const String prefsCurrentActivity = 'APP_CURRENT_ACTIVITY';

  /// SharedPreferences key holding the session stashed by [pauseCurrentSession],
  /// so [resumeLastSession] can reopen it when the app returns to foreground.
  static const String prefsLastActivity = 'APP_LAST_ACTIVITY';

  /// SharedPreferences key holding the open application-level session.
  ///
  /// Separate from [prefsCurrentActivity] on purpose: the app session runs
  /// *alongside* whatever screen session is open, so the two cannot share one
  /// slot. See [startAppSession].
  static const String prefsAppSession = 'APP_SESSION_ACTIVITY';

  static ActivityRepository? _instance;

  /// Whether [initialise] has run in this isolate.
  ///
  /// Check this before tracking from code that may run before startup finishes.
  static bool get isInitialised => _instance != null;

  /// The process-wide instance, or null when [initialise] has not run.
  ///
  /// Prefer this over [instance] in fire-and-forget paths so tracking can
  /// silently no-op rather than throw.
  static ActivityRepository? get instanceOrNull => _instance;

  /// The process-wide instance.
  ///
  /// Throws a [StateError] if [initialise] has not been awaited yet.
  static ActivityRepository get instance {
    final repository = _instance;
    if (repository == null) {
      throw StateError(
        'ActivityRepository.initialise() must be awaited before use. '
        'Call it during app startup, before any track() call.',
      );
    }
    return repository;
  }

  static Future<ActivityRepository> initialise({
    required AppPrefs appPrefs,
    ActivityUploader? uploader,
    String databaseName = defaultDatabaseName,
    ActivityRealmDb? activityRealmDb,
  }) async {
    final existing = _instance;
    if (existing != null) {
      if (uploader != null) {
        existing.uploader = uploader;
      }
      return existing;
    }

    final realmDb = activityRealmDb ?? ActivityRealmDbImpl();
    if (activityRealmDb == null) {
      await realmDb.initialise(databaseName);
    }

    return _instance = ActivityRepositoryImpl(
      appPrefs: appPrefs,
      activityDao: ActivityDaoImpl(realmDb),
      uploader: uploader,
    );
  }

  /// Drops the shared instance. For tests and for teardown after logout.
  ///
  /// Does not touch stored data — use [clear] for that.
  static void resetInstance() => _instance = null;

  /// Uploads buffered sessions. Null disables syncing.
  abstract ActivityUploader? uploader;

  /// Read straight from SharedPreferences, so it reflects writes made by any
  /// app in the process.
  ActivitySession? get currentSession;

  /// [ActivityModule.embeddedGtFaOne] is reserved for the app-level session —
  /// see [startAppSession] — so screens pass `generalTrade` or `faOne`.
  Future<ActivitySession> track({
    required String name,
    required ActivityModule moduleEnum,
    ActivitySubModule? subModuleEnum,
    ActivitySource source,
  });

  /// Goes straight into the buffer and **leaves the open session alone**. Use
  /// this rather than [track] for anything the user does *while staying put*:
  /// [track] would close the session for the screen they are on and open one
  /// for the tap, which then stays open until they navigate, attributing all
  /// the intervening time to a button press.
  Future<ActivitySession> logEvent({
    required String name,
    required ActivityModule moduleEnum,
    ActivitySubModule? subModuleEnum,
    ActivitySource source,
  });

  /// Closes any open session and unconditionally opens a new one, even if it
  /// matches the current screen. Prefer [track] unless you specifically need a
  /// fresh guid.
  Future<ActivitySession> startSession({
    required String name,
    required ActivityModule moduleEnum,
    ActivitySubModule? subModuleEnum,
    ActivitySource source,
  });

  /// Use when the user stays on the same logical screen but what it reports
  /// changes (e.g. a sub-tab switch that should not split the session). Null
  /// leaves a field unchanged; pass [clearSubModuleEnum] to null the submodule
  /// out. Returns null when no session is open.
  Future<ActivitySession?> updateCurrentSession({
    String? name,
    ActivityModule? moduleEnum,
    ActivitySubModule? subModuleEnum,
    bool clearSubModuleEnum,
  });

  Future<ActivitySession?> endCurrentSession();

  /// The open application-level session, or null if none is running.
  ActivitySession? get appSession;

  /// Pair it with the app lifecycle — start on resume, [endAppSession] on
  /// background — so each segment covers foreground time only and the total is
  /// their sum. Backgrounded time is then excluded rather than inflating usage.
  Future<ActivitySession> startAppSession({
    String name,
    ActivityModule moduleEnum,
    ActivitySubModule subModuleEnum,
    ActivitySource source,
  });

  Future<ActivitySession?> endAppSession();

  Future<ActivitySession?> pauseCurrentSession();

  Future<ActivitySession?> resumeLastSession();

  Future<List<ActivitySession>> getPendingActivities();

  Future<VoidResult> sync({bool includeCurrentSession});

  Future<void> clear();
}
