import 'package:flutter/material.dart';

class KGoBack<T> extends StatelessWidget {
  final Function()? preGoBack;
  final T? result;
  final Color? color;
  const KGoBack({
    Key? key,
    this.preGoBack,
    this.result,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.arrow_back_ios_new,
        color: color,
      ),
      onPressed: () => _onPressed(context),
    );
  }

  Future<void> _onPressed(BuildContext context) async {
    final navigation = Navigator.of(context);
    if (navigation.canPop()) {
      if (preGoBack != null) {
        preGoBack!();
      }
      navigation.pop<T>(result);
    }
  }
}
