import 'package:flutter/widgets.dart';

class DeviceUtils {
  static Size getDeviceDimension(BuildContext context) {

    return MediaQuery.of(context).size;
  }
}