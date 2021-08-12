/*
 * @Author: 大能猫🐱
 * @Description: 哇咔咔
 * @Date: 2021-08-12 17:16:32
 */
import 'package:flutter/rendering.dart';

class ColorUtil {
  ///  user
  /// 1. ColorUtil.fromHex('#F96600')
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// use
  /// 1. ColorsUtil.hexColor(0x3caafa)//透明度为1
  /// 2.ColorsUtil.hexColor(0x3caafa,alpha: 0.5)//透明度为0.5
  static Color hexColor(int hex, {double alpha = 1}) {
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }
    return Color.fromRGBO((hex & 0xFF0000) >> 16, (hex & 0x00FF00) >> 8,
        (hex & 0x0000FF) >> 0, alpha);
  }
}
