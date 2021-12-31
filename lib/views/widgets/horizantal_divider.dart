import 'package:flutter/material.dart';

class HorizantalDivider extends StatelessWidget {
  final String text;
  const HorizantalDivider({Key? key, this.text = ''}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const divider = Divider();
    final color = Theme.of(context).dividerColor;
    return Row(
      children: [
        const Expanded(child: divider),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: text.isEmpty ? 0.0 : 20.0,
          ),
          child: Text(text, style: TextStyle(color: color)),
        ),
        const Expanded(child: divider),
      ],
    );
  }
}
