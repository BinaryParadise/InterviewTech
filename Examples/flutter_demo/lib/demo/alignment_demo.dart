import 'package:flutter/material.dart';
import '../component/intro_component.dart';

class MainAlignmentDemo extends StatelessWidget {
  const MainAlignmentDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget current;

    List<Widget> mainRows = [];

    mainRows.add(Row(children: [
      Text('空白区域示例→'),
      SizedBox(
        width: 8,
      ),
      Text('             ').fill(color: Colors.deepPurple.withOpacity(0.5))
    ]));

    mainRows.add(SizedBox(
      height: 20,
    ));

    mainRows.add(Text('MainAxisAlignment: 主轴布局').fill(color: Colors.orange));

    mainRows.add(SizedBox(
      height: 20,
    ));

    // 默认: MainAxisAlignment.start
    mainRows.add(_AlignmentRowItem(
      _AlignmentData('start', '从头部开始布局', '纱窗日落渐黄昏，金屋无人见泪痕。'),
      mainAxisAlignment: MainAxisAlignment.start,
    ));

    mainRows.add(SizedBox(
      height: 20,
    ));

    // MainAxisAlignment.end
    mainRows.add(_AlignmentRowItem(
      _AlignmentData('end', '从尾部开始布局', '寂寞空庭春欲晚，梨花满地不开门。'),
      mainAxisAlignment: MainAxisAlignment.end,
    ));

    mainRows.add(SizedBox(
      height: 20,
    ));

    // MainAxisAlignment.center
    mainRows.add(_AlignmentRowItem(
      _AlignmentData('center', '居中布局', '歌管楼台声细细'),
      mainAxisAlignment: MainAxisAlignment.center,
    ));

    mainRows.add(SizedBox(
      height: 20,
    ));

    // MainAxisAlignment.spaceBetween
    mainRows.add(_AlignmentRowItem(
      _AlignmentData('spaceBetween', '空白区均分,头尾无空隙', '歌管楼台声细细'),
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
    ));

    mainRows.add(SizedBox(
      height: 20,
    ));

    // MainAxisAlignment.spaceAround
    mainRows.add(_AlignmentRowItem(
      _AlignmentData('spaceAround', '空白区均分,首尾间隙x0.5', '三出阙'),
      mainAxisAlignment: MainAxisAlignment.spaceAround,
    ));

    mainRows.add(SizedBox(
      height: 20,
    ));

    // MainAxisAlignment.spaceEvenly
    mainRows.add(_AlignmentRowItem(
      _AlignmentData('spaceEvenly', '空白区均分,间距相等', '歌管楼台声细细'),
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    ));

    current = Column(
      children: mainRows,
    );

    current = Scaffold(
      appBar: AppBar(
        title: Text('主轴布局方式'),
      ),
      body: current,
    );
    return current;
  }
}

class CrossAlignmentDemo extends StatelessWidget {
  const CrossAlignmentDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget current;

    List<Widget> crossRows = [];

    crossRows.add(Row(children: [
      Text('空白区域示例→'),
      SizedBox(
        width: 8,
      ),
      Text('             ').fill(color: Colors.deepPurple.withOpacity(0.5))
    ]));

    crossRows.add(SizedBox(
      height: 30,
    ));

    // 以下是副轴
    crossRows
        .add(Text('CrossAxisAlignment: 副轴布局').fill(color: Colors.deepOrange));

    crossRows.add(SizedBox(
      height: 20,
    ));

    // CrossAxisAlignment.start
    crossRows.add(_AlignmentRowItem(
      _AlignmentData('start', '头部开始布局', '歌管楼台声细细'),
      crossAxisAlignment: CrossAxisAlignment.start,
    ));

    crossRows.add(SizedBox(
      height: 20,
    ));

    // CrossAxisAlignment.center
    crossRows.add(_AlignmentRowItem(
      _AlignmentData('center', '居中布局', '歌管楼台声细细'),
      crossAxisAlignment: CrossAxisAlignment.center,
    ));

    crossRows.add(SizedBox(
      height: 20,
    ));

    // CrossAxisAlignment.end
    crossRows.add(_AlignmentRowItem(
      _AlignmentData('end', '尾部布局', '歌管楼台声细细'),
      crossAxisAlignment: CrossAxisAlignment.end,
    ));

    crossRows.add(SizedBox(
      height: 20,
    ));

    // CrossAxisAlignment.stretch
    crossRows.add(_AlignmentRowItem(
      _AlignmentData('stretch', '充满交叉轴', '歌管楼台声细细'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
    ));

    crossRows.add(SizedBox(
      height: 20,
    ));

    crossRows.add(_AlignmentRowItem(
      _AlignmentData('baseline', '基线匹配，不常用', '歌管楼台声细细'),
      crossAxisAlignment: CrossAxisAlignment.start,
    ));

    current = Column(
      children: crossRows,
    );

    current = Scaffold(
      appBar: AppBar(
        title: Text('副轴布局方式'),
      ),
      body: current,
    );
    return current;
  }
}

class _AlignmentData {
  String leading;
  String center;
  String tail;

  _AlignmentData(this.leading, this.center, this.tail);
}

class _AlignmentRowItem extends StatelessWidget {
  MainAxisAlignment mainAxisAlignment;
  CrossAxisAlignment crossAxisAlignment;
  _AlignmentData data;

  _AlignmentRowItem(this.data,
      {this.mainAxisAlignment = MainAxisAlignment.start,
      this.crossAxisAlignment = CrossAxisAlignment.center});

  @override
  Widget build(BuildContext context) {
    Widget current = Row(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: this.crossAxisAlignment,
      children: [
        Text(
          data.leading,
          style: TextStyle(
              textBaseline: crossAxisAlignment == CrossAxisAlignment.baseline
                  ? TextBaseline.ideographic
                  : null,
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w600),
        ).fill(color: Colors.red),
        Text(data.center).fill(color: Colors.amber),
        Container(
          height: 50,
          child: Text(data.tail).fill(color: Colors.lightGreen),
        ),
      ],
    );
    return current.fill(color: Colors.deepPurple.withOpacity(0.5), height: 50);
  }
}
