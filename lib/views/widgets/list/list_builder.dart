import 'package:flutter/material.dart';

class ListBuilder<T> extends StatelessWidget {
  final List<T> datas;
  final Widget Function(T data) itemBuilder;
  final Widget? emptyList;
  final EdgeInsets padding;
  final bool shirinkWrap;
  final ScrollPhysics physics;
  final Axis scrollDirection;
  final ScrollController? controller;
  final ScrollBehavior? scrollBehavior;
  final EdgeInsets margin;

  const ListBuilder({
    required this.datas,
    required this.itemBuilder,
    Key? key,
    this.emptyList,
    this.padding = const EdgeInsets.all(0.0),
    this.shirinkWrap = false,
    this.physics = const BouncingScrollPhysics(),
    this.scrollDirection = Axis.vertical,
    this.controller,
    this.scrollBehavior,
    this.margin = const EdgeInsets.all(0.0),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (datas.isEmpty) {
      return emptyList ?? const SizedBox.shrink();
    }
    if (scrollBehavior != null) {
      return ScrollConfiguration(
        behavior: scrollBehavior!,
        child: listViewBuilder,
      );
    }
    return listViewBuilder;
  }

  Widget get listViewBuilder {
    return ListView.builder(
      controller: controller,
      physics: physics,
      itemCount: datas.length,
      itemBuilder: _itemBuilder,
      padding: padding,
      shrinkWrap: shirinkWrap,
      scrollDirection: scrollDirection,
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
    );
  }

  Widget _itemBuilder(BuildContext context, int index) => Container(
        margin: margin,
        child: itemBuilder(datas[index]),
      );
}
