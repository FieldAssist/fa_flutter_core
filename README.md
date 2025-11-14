# fa_flutter_core [![codecov](https://codecov.io/gh/FieldAssist/fa_flutter_core/branch/main/graph/badge.svg?token=0SJUKQDEC2)](https://codecov.io/gh/FieldAssist/fa_flutter_core)

Official FA Flutter core package.

## Getting Started

Add following code in pubspec.yaml file in dependencies:

```
  fa_flutter_core:
    git:
      url: https://github.com/FieldAssist/fa_flutter_core.git
      ref: main
```

## Logger

To use add following line as top level variable anywhere in your project

```
final AppLog logger = AppLogImpl();
```

### Debug

```
logger.d("debug value: $token");
```

### Exception

```
logger.e(e,stacktrace); // Use StackTrace.current in case no stacktrace available
```

### Info

```
logger.i("Api response: xyz");
```

## Functions

1. `Device_Info`: used to get details of device, namely:

   - `brand`
   - `manufacturer`
   - `model`
   - `os`
   - `sdk`
   - `id`
   - `imei`
   <br><br>
   Also contains three subclasses:
      - `IosDeviceInfoImpl`: For IOS devices
      - `AndroidDeviceInfoImpl`: For Android devices
      - `UnknownDeviceInfoImpl`: For other devices
<br><br>

2. `Package_Info`: used to get details of package and application, namely:

   - `appName`
   - `packageName`
   - `version`
   - `buildNumber`
   <br><br>
   `PackageInformationImpl` class defined here contains `getPackageInfo` function that returns all package and app details if detected platform:
   `isMobile` or else returns "NA' in all fields.
<br><br>

3. `System_Info`: used to combine device and package details to get system details, namely:

   - `version`
   - `appName`
   - `packageName`
   - `buildNumber`
   - `brand`
   - `id`
   - `manufacturer`
   - `model`
   - `os`
   - `sdk`
   - `imei`
<br><br>

4. `Platform_Utils`: used to check the platform on which the application is running. Platforms include:
   - `Debug`
   - `Mobile` (includes `Web`, `Android` and `IOS`)
   - `Linux`
   - `Mac`
   - `Windows`
