import 'package:flutter/material.dart';

class ListViewDemo extends StatefulWidget {
  ListViewDemo({Key? key}) : super(key: key);

  @override
  _ListViewDemoState createState() => _ListViewDemoState();
}

class _ListViewDemoState extends State<ListViewDemo> {
  @override
  Widget build(BuildContext context) {
    Widget current = ListView.separated(
        padding: EdgeInsets.fromLTRB(12, 8, 12, 28),
        itemBuilder: (context, row) {
          return Container(
            padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(6)),
            height: 66,
            child: Text('t${row}'),
          );
        },
        separatorBuilder: (context, row) {
          return SizedBox(
            height: 8,
          );
        },
        itemCount: 35);

    current = Container(
      color: const Color(0xFFF2F4F6),
      child: current,
    );
    return current;
  }
}
