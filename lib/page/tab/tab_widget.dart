/*
 * @Author: 大能猫🐱
 * @Description: 哇咔咔
 * @Date: 2021-08-12 17:04:45
 */
import 'package:flutter/material.dart';
import 'package:pets_app/config/app_config.dart';
import 'package:pets_app/utils/convert.dart';

class BottomBarWidget extends StatefulWidget {
  const BottomBarWidget({
    Key? key,
    this.selectedPosition = 0,
    required this.selectedCallback,
    required this.iconList,
  }) : super(key: key);

  final int selectedPosition;
  final Function(int selectedPosition) selectedCallback;
  final List<IconData> iconList;

  @override
  _BottomBarWidgetState createState() => _BottomBarWidgetState();
}

class _BottomBarWidgetState extends State<BottomBarWidget>
    with TickerProviderStateMixin {
  /// BottomNavigationBar高度
  double barHeight = 56.0;

  /// 指示器高度
  double indicatorHeight = 44.0;

  /// 选中图标颜色
  Color selectedIconColor = AppConfig.primaryColor;

  /// 默认图标颜色
  Color normalIconColor = ColorUtil.fromHex('#ACACAC');

  /// 选中下标
  int selectedPosition = 0;

  /// 记录上一次的选中下标
  int previousSelectedPosition = 0;

  /// 选中图标高度
  double selectedIconHeight = 38.0;

  /// 默认图标高度
  double normalIconHeight = 32.0;

  double itemWidth = 0;

  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      itemWidth =
          (context.size!.width - barHeight) / (widget.iconList.length - 1);
      setState(() {});
    });

    /// 设置动画时长
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    selectedPosition = widget.selectedPosition;
    previousSelectedPosition = widget.selectedPosition;
    animation = Tween(
      begin: selectedPosition.toDouble(),
      end: selectedPosition.toDouble(),
    ).animate(CurvedAnimation(parent: controller, curve: Curves.linear));
  }

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[];

    /// 背景
    final background = Container(
      height: barHeight,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(barHeight / 2),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            offset: const Offset(0.0, 1.0),
            blurRadius: 4.0,
            spreadRadius: 0.0,
          ),
        ],
      ),
    );

    children.add(background);

    if (itemWidth == 0) {
      return Stack(
        children: children,
      );
    }

    /// 指示器
    children.add(
      AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return Positioned(
            left: 6.0 + animation.value * itemWidth,
            top: (barHeight - indicatorHeight) / 2,
            child: child!,
          );
        },
        child: Container(
          width: indicatorHeight,
          height: indicatorHeight,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: const Offset(0.0, 0.0),
                blurRadius: 1.0,
                spreadRadius: 0.0,
              ),
            ],
          ),
        ),
      ),
    );

    for (var i = 0; i < widget.iconList.length; i++) {
      /// 图标中心点计算
      final rect = Rect.fromCenter(
        center: Offset(28.0 + (i * itemWidth), 28.0),
        width: (i == selectedPosition) ? selectedIconHeight : normalIconHeight,
        height: (i == selectedPosition) ? selectedIconHeight : normalIconHeight,
      );

      children.add(
        AnimatedPositioned.fromRect(
          rect: rect,
          duration: const Duration(milliseconds: 300),
          child: GestureDetector(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: (i == selectedPosition)
                    ? selectedIconColor
                    : normalIconColor,
              ),
              child: Icon(widget.iconList[i], color: Colors.white),
            ),
            onTap: () => _selectedPosition(i),
          ),
        ),
      );
    }

    return Stack(
      children: children,
    );
  }

  void _selectedPosition(int position) {
    /// 去除重复点击
    if (position == selectedPosition) return;

    previousSelectedPosition = selectedPosition;
    selectedPosition = position;

    /// 执行动画
    animation = Tween(
            begin: previousSelectedPosition.toDouble(),
            end: selectedPosition.toDouble())
        .animate(CurvedAnimation(parent: controller, curve: Curves.linear));
    controller.forward(from: 0.0);

    widget.selectedCallback(selectedPosition);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
