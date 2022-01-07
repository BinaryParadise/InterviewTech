import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/demo/tabbar_pageview.dart';
import 'package:one_context/one_context.dart';

import 'demo/alignment_demo.dart';

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
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
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

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

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
  }

  @override
  Widget build(BuildContext context) {
    Widget current = ListView.separated(
        padding: EdgeInsets.only(top: 12),
        itemBuilder: (context, index) {
          var item = routes[index];
          return Container(
            height: 50,
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
              height: 8,
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
