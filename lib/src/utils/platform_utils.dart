import 'dart:io';

import 'package:flutter/foundation.dart';

bool get isMobile {
  return !kIsWeb && (Platform.isAndroid || Platform.isIOS);
}

bool get isAndroid {
  return !isMobile && Platform.isAndroid;
}

bool get isIOS {
  return !isMobile && Platform.isIOS;
}

bool get isLinux {
  return !isMobile && Platform.isLinux;
}

bool get isMac {
  return !isMobile && Platform.isMacOS;
}

bool get isWindows {
  return !isMobile && Platform.isWindows;
}

bool get isWeb {
  return kIsWeb;
}
