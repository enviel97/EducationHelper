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
  final Future<void> Function()? onRefresh;
  final EdgeInsets margin;
  final Widget? endOfList;

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
    this.onRefresh,
    this.endOfList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (datas.isEmpty) {
      return emptyList ?? const SizedBox.shrink();
    }
    if (scrollBehavior != null) {
      return ScrollConfiguration(
        behavior: scrollBehavior!,
        child: _listViewBuilder,
      );
    }
    return _listViewBuilder;
  }

  Widget get _listViewBuilder {
    if (onRefresh != null) {
      return RefreshIndicator(
        triggerMode: RefreshIndicatorTriggerMode.onEdge,
        onRefresh: () async {
          await onRefresh!();
        },
        child: _listViewMoreButton,
      );
    }
    return _listViewMoreButton;
  }

  Widget get _listViewMoreButton {
    // if (endOfList != null) {
    if (endOfList != null) {
      switch (scrollDirection) {
        case Axis.horizontal:
          return Row(children: [Flexible(child: _listView), endOfList!]);
        case Axis.vertical:
          return Column(children: [Flexible(child: _listView), endOfList!]);
      }
    }
    return _listView;
    // }
  }

  Widget get _listView {
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
