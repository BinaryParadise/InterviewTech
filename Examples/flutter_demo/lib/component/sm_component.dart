import 'package:flutter/material.dart';
import 'package:one_context/one_context.dart';

/// 导航栏复用组件
class AppNav {
  /// 导航栏标题
  static Widget title(String title) {
    return Text(
      title,
      style: const TextStyle(
          color: Color(0xFF222222),
          fontSize: 19.0,
          fontWeight: FontWeight.w500),
    );
  }

  /// 导航栏按钮
  static Widget action(String icon, VoidCallback onPressed,
      {double iconSize = 24}) {
    return IconButton(
      onPressed: onPressed,
      iconSize: iconSize,
      icon: Image.asset(icon),
    );
  }

  static Widget backButton() {
    Widget current = IconButton(
      onPressed: () {
        OneContext().pop();
      },
      iconSize: 24,
      icon: Image.asset('images/common/ic_nav_backarrow@3x.png'),
    );
    current = Container(
      padding: EdgeInsets.only(left: 12),
      child: current,
    );
    return current;
  }
}

extension TextStyleExtension on Color {
  TextStyle fontSize(double size) {
    return TextStyle(color: this, fontSize: size);
  }

  Container colorful(Widget widget) {
    return Container(color: this, child: widget);
  }
}

extension FontWidthExtension on TextStyle {
  get medium {
    return copyWith(fontWeight: FontWeight.w500);
  }
}

extension WidgetExtension on Widget {
  // 添加背景色
  Container fillColor(Color color, {double? height}) {
    return Container(color: color, child: this, height: height,);
  }
}
