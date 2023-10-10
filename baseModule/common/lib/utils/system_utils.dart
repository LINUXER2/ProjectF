import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';

class System {
  static double get width {
    return window.physicalSize.width / window.devicePixelRatio;
  }

  static double get height {
    return window.physicalSize.height / window.devicePixelRatio;
  }

  static double get devicePixelRatio {
    return window.devicePixelRatio;
  }

  static bool get isAndroid {
    return Platform.isAndroid;
  }

  static bool get isIOS {
    return Platform.isIOS;
  }

  static double get statusHeight {
    return MediaQueryData.fromWindow(window).padding.top;
  }
}
