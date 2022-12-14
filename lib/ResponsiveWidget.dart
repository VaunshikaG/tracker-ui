import 'package:flutter/cupertino.dart';

class ResponsiveWidget {

  static bool isTabScreen(BuildContext context) {
    return MediaQuery.of(context).size.width > 800;
  }

  static bool isSmallScreen(BuildContext context) {
  return MediaQuery.of(context).size.width < 800;
  }

  static bool isMediumScreen(BuildContext context) {
  return MediaQuery.of(context).size.width > 800 &&
  MediaQuery.of(context).size.width < 1200;
  }

  static bool isLargeScreen(BuildContext context) {
    return MediaQuery.of(context).size.width > 1200;
  }

}