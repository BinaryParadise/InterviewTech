import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:one_context/one_context.dart';

import 'component/sm_segment.dart';
import 'listview_demo.dart';

class TabbarPageViewPage extends StatelessWidget {
  final _pageController = PageController();
  SegmentController controller = SegmentController();

  TabbarPageViewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.addListener(() {
      print('切换tab');
      _pageController.animateToPage(controller.currentIndex,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOutCubic);
    });

    Widget current;
    // 标签切换
    current = SMSegment(
      datas: [
        SMSegmentItem<String>('待处理(5)'),
        SMSegmentItem<String>('已处理(20)')
      ],
      controller: controller,
      key: const Key('workbench_sg'),
    );

    // 分页视图
    PageView pageView = PageView(
      key: Key('warehousing'),
      controller: _pageController,
      physics: ClampingScrollPhysics(),
      onPageChanged: (page) {
        print('切换page');
        controller.animateTo(page);
      },
      children: [
        ListViewDemo(
          key: Key('d0'),
        ),
        ListViewDemo(
          key: Key('d1'),
        )
      ],
    );
    current = Column(
      children: [current, Expanded(child: pageView)],
    );

    current = Scaffold(
      appBar: AppBar(title: Text('TabBar+PageView')),
      body: current,
    );
    return current;
  }
}
