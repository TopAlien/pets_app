/*
 * @Author: 大能猫🐱
 * @Description: 哇咔咔
 * @Date: 2021-08-12 17:02:07
 */
import 'package:flutter/material.dart';
import 'package:pets_app/page/tab/tab_widget.dart';

class BottomTabPage extends StatefulWidget {
  @override
  _BottomTabPageState createState() => _BottomTabPageState();
}

class _BottomTabPageState extends State<BottomTabPage> {
  int pageIndex = 0;

  final List<IconData> iconList = [
    Icons.home_outlined,
    Icons.add,
    Icons.access_alarms,
    Icons.settings,
    Icons.accessible,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('圆圈圈菜单'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            content(),
            bottomBar(),
          ],
        ),
      ),
    );
  }

  Widget content() {
    return Container(
      alignment: Alignment.center,
      child: Text(
        pageIndex.toString(),
        style: TextStyle(color: Colors.grey[400], fontSize: 80),
      ),
    );
  }

  Widget bottomBar() {
    final double width = MediaQuery.of(context).size.width;
    return Positioned(
      left: width * 0.05,
      right: width * 0.05,
      bottom: MediaQuery.of(context).padding.bottom > 0 ? 0 : 16.0,
      child: BottomBarWidget(
        iconList: iconList,
        selectedCallback: (position) => onClickBottomBar(position),
      ),
    );
  }

  void onClickBottomBar(int index) {
    if (!mounted) return;

    debugPrint('longer   点击了 >>> $index');
    setState(() => pageIndex = index);
  }
}
