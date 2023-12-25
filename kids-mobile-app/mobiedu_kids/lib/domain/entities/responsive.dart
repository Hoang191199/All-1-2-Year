import 'package:flutter/widgets.dart';

extension Responsive on BuildContext {
  T responsive<T>(
    T defaultVal, {
      T? sm,    // small
      T? md,    // medium
      T? lg,    // large
      T? xl,    // extra large
    }
  ) {
    if (xl == null && lg == null && md == null && sm == null) {
      return defaultVal;
    } else {
      final wd = MediaQuery.of(this).size.width;
      return wd >= 1280
        ? (xl ?? lg ?? md ?? sm ?? defaultVal)
        : wd >= 1024
          ? (lg ?? md ?? sm ?? defaultVal)
          : wd >= 768
            ? (md ?? sm ?? defaultVal)
            : wd >= 640
              ? (sm ?? defaultVal)
              : defaultVal;
    }
  }
}