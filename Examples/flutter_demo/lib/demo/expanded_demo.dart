import 'package:flutter/material.dart';
import '../component/intro_component.dart';

class ExpandedDemo extends StatelessWidget {
  const ExpandedDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget current;
    current = Row(
      children: [
        Text('flex = 1').fill(color: Colors.purpleAccent),
        Text('flex = 2').fill(color: Colors.orange).expanded(flex: 2),
        Text('flex = 3').fill(color: Colors.cyanAccent).expanded(flex: 3)
      ],
    );
    current = Container(
      height: 80,
      color: Colors.white,
      child: current,
    );

    current = Column(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          color: Colors.white,
          child: Text(
            'Expanded用于展开Row、Column、Flex的child，根据flex因子划分空间大小。',
            style: TextStyle(color: Colors.redAccent),
          ),
        ),
        SizedBox(height: 16,),
        current
      ],
    );
    current = Scaffold(
      appBar: AppBar(
        title: Text('Expanded'),
      ),
      body: current,
    );
    return current;
  }
}
