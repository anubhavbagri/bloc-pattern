import 'package:flutter/widgets.dart';

class SizeConfig {
  static MediaQueryData? _mediaQueryData;
  static double? screenWidth;
  static double? screenHeight;
  static double? safeAreaPaddingHorizontal;
  static double? safeAreaPaddingVertical;
  static double? safeAreaHorizontal;
  static double? safeAreaVertical;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData!.size.width;
    screenHeight = _mediaQueryData!.size.height;
    safeAreaPaddingHorizontal =
        _mediaQueryData!.padding.left + _mediaQueryData!.padding.right;
    safeAreaPaddingVertical =
        _mediaQueryData!.padding.top + _mediaQueryData!.padding.bottom;
    safeAreaHorizontal = screenWidth! - safeAreaPaddingHorizontal!;
    safeAreaVertical = screenHeight! - safeAreaPaddingVertical!;
  }
}
