import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/demo/expanded_demo.dart';
import 'package:flutter_demo/demo/tabbar_pageview.dart';
import 'package:one_context/one_context.dart';

import 'demo/alignment_demo.dart';
import 'demo/network_demo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        backgroundColor: const Color(0xFFF2F4F6),
        scaffoldBackgroundColor: Color(0xFFF2F4F6),
      ),
      home: OneContext()
          .builder(context, const MyHomePage(title: 'Flutter Demo')),
      navigatorKey: OneContext().navigator.key,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<RouteData> routes = [];

  @override
  void initState() {
    super.initState();
    routes.add(RouteData('TabBar+PageView', () => TabbarPageViewPage()));
    routes.add(RouteData('MainAxisAlignment', () => MainAlignmentDemo()));
    routes.add(RouteData('CrossAxisAlignment', () => CrossAlignmentDemo()));
    routes.add(RouteData('Expanded', () => ExpandedDemo()));
    routes.add(RouteData('Network', () => NetworkDemo()));
  }

  @override
  Widget build(BuildContext context) {
    Widget current = ListView.separated(
        padding: EdgeInsets.only(top: 12),
        itemBuilder: (context, index) {
          var item = routes[index];
          return Container(
            height: 39,
            color: Colors.white, //若不提供颜色，则整个ListView都是白色
            child: TextButton(
                onPressed: () => OneContext().push(
                    CupertinoPageRoute(builder: (context) => item.child())),
                child: Text(
                  item.title,
                  style: TextStyle(fontSize: 15),
                )),
          );
        },
        separatorBuilder: (context, index) => Divider(
              height: 10,
              color: Color(0xFFF2F4F6),
            ),
        itemCount: routes.length);
    current = Container(
      color: Color(0xFFF2F4F6),
      child: current,
    );
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body:
          current, // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class RouteData {
  String title;
  Widget Function() child;

  RouteData(this.title, this.child);
}
