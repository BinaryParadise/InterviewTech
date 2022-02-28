import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MiddlewarePage extends StatelessWidget {
  String path;
  MiddlewarePage(this.path, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget current = Column(
      children: [
        Text('当前路径: $path'),
        TextButton(
            onPressed: () =>
                Navigator.of(context).pushNamed('/middleware', arguments: path),
            child: const Text('打开flutter路由')),
        TextButton(
            onPressed: () =>
                Navigator.of(context).pushNamed('native://middleware'),
            child: const Text('打开原生路由'))
      ],
    );
    current = Padding(
      padding: const EdgeInsets.all(12),
      child: current,
    );
    current = Scaffold(
      appBar: AppBar(
        title: const Text('中间页'),
      ),
      body: current,
    );
    return current;
  }
}
