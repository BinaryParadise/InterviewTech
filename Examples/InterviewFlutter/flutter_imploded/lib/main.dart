import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_canary/flutter_canary.dart';
import 'package:flutter_imploded/middleware_page.dart';

void main() async {
  runApp(MyApp(window.defaultRouteName));
  // 初始化金丝雀
  await FlutterCanary.instance.configure('82e439d7968b7c366e24a41d7f53f47d',
      service: 'http://127.0.0.1/api', deviceid: 'canary-imploded-device-id');
  FlutterCanary.instance.start();
  FlutterCanary.platformVersion.then((value) => print(value));
}

class MyApp extends StatefulWidget {
  String route;
  MyApp(this.route, {Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static const MethodChannel channel = MethodChannel('native.to.flutter');
  late String route;
  @override
  void initState() {
    route = widget.route;
    channel.setMethodCallHandler((call) {
      print(call);
      if (call.method == "setInitialRoute") {
        setState(() {
          route = call.arguments as String;
        });
      }
      return Future.value(true);
    });
    super.initState();
  }

  Widget buildFactory(RouteSettings settings, BuildContext context) {
    switch (settings.name) {
      case "/":
      case '/canary':
        return FlutterCanary.instance.options();
      case "/middleware":
        return MiddlewarePage((settings.arguments ?? '') as String);
      case "/status":
        return StatusPage();
      default:
        return Text('未知路由:${settings.name}');
    }
  }

  Route<dynamic>? pushNative(RouteSettings settings) {
    var uri = Uri.parse(settings.name!);
    if (uri.scheme == 'native') {
      channel.invokeMethod('openRoute', settings.name);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    print('路由: ${route}');
    return MaterialApp(
      title: '混合开发Deno',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: (settings) => CupertinoPageRoute(
          builder: (context) => buildFactory(settings, context)),
      onUnknownRoute: pushNative,
    );
  }
}

class StatusPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Status'),
      ),
      body: const Center(
        child: Text('Status'),
      ),
    );
  }
}
