import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class IntroSegment extends StatefulWidget {
  static const String viewType = 'plugins.flutter.io/nano_platform_view';
  List<SMSegmentItem> datas;
  double height;
  SegmentController controller;
  Widget Function(int)? itemBuilder;
  static const TextStyle _selectedTitleStyle =
      TextStyle(fontSize: 14, color: Color(0xFF0A62FF));
  static const TextStyle _titleStyle =
      TextStyle(fontSize: 13, color: Color(0xFF222222));
  bool native;

  IntroSegment({
    required this.datas,
    required this.controller,
    Key? key,
    this.height = 44,
    this.itemBuilder,
    this.native = false,
  }) : super(key: key);

  @override
  State<IntroSegment> createState() => _IntroSegmentState();
}

class _IntroSegmentState extends State<IntroSegment> {
  late int currentIndex;

  @override
  initState() {
    super.initState();
    currentIndex = widget.controller.currentIndex;
    widget.controller.addListener(() {
      if (currentIndex != widget.controller.currentIndex) {
        setState(() {
          currentIndex = widget.controller.currentIndex;
        });
      }
    });
  }

  /// 指示器
  Widget indicator() {
    return Container(
      width: 87.5,
      height: 2,
      color: const Color(0xFF0A62FF),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget current = byNative(context);
    current = Container(
      height: widget.height,
      color: Colors.white,
      child: current,
    );
    return current;
  }

  Widget byDart(BuildContext context) {
    List<Widget> items = [];
    for (int i = 0; i < widget.datas.length; i++) {
      var selected = widget.controller.currentIndex == i;
      Widget current;
      // 按钮
      if (widget.itemBuilder == null) {
        current = Container(
          // color: Colors.purple,
          child: TextButton(
            onPressed: () {
              widget.controller.animateTo(i);
            },
            child: Text(
              widget.datas[i].title,
              style: selected
                  ? IntroSegment._selectedTitleStyle
                  : IntroSegment._titleStyle,
            ),
            style: ButtonStyle(
                shadowColor: MaterialStateProperty.all(Colors.transparent),
                splashFactory: NoSplash.splashFactory),
          ),
        );
      } else {
        current = widget.itemBuilder!(i);
      }

      // 指示器
      if (selected) {
        current = Stack(
          alignment: AlignmentDirectional.center,
          fit: StackFit.expand,
          children: [current, Positioned(bottom: 0, child: indicator())],
        );
      } else {}

      // 撑满父容器
      current = Expanded(child: current);
      items.add(current);
    }
    Widget current = Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: items);
    return current;
  }

  Widget byNative(BuildContext context) {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return AndroidView(viewType: IntroSegment.viewType);
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      return UiKitView(
        viewType: IntroSegment.viewType,
        creationParams: {
          'currentIndex': widget.controller.currentIndex,
          'data': widget.datas.map((e) => e.title).toList()
        },
        creationParamsCodec: StandardMessageCodec(),
      );
    }
    return byDart(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}

class SMSegmentItem<T> {
  String title;
  T? value;

  SMSegmentItem(this.title, {this.value});
}

class SegmentController extends ChangeNotifier {
  MethodChannel? _platform;

  SegmentController({int initIndex = 0}) {
    _currentIndex = initIndex;

    if (defaultTargetPlatform == TargetPlatform.android ||
        defaultTargetPlatform == TargetPlatform.iOS) {
      _platform = MethodChannel('com.xincheng.sm.SegmentView');
      _platform!.setMethodCallHandler(callHandler);
    }
  }

  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  set currentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  void animateTo(int index) {
    _currentIndex = index;
    if (_platform != null) {
      _platform!.invokeMethod('setCurrentIndex', index).then((value) => null);
    }
    notifyListeners();
  }

  Future<dynamic> callHandler(MethodCall call) async {
    switch (call.method) {
      case 'setCurrentIndex':
        currentIndex = call.arguments as int;
        break;
    }
    return true;
  }
}
