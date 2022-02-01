import 'package:education_helper/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:share/share.dart';

class ShareButton extends StatelessWidget {
  final String publicLink;
  final String subject;
  final double iconSize;
  final Color? iconColor;
  const ShareButton({
    required this.publicLink,
    required this.subject,
    Key? key,
    this.iconSize = 24.0,
    this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: const EdgeInsets.all(0.0),
      onPressed: _shareFile,
      iconSize: iconSize,
      color: iconColor ?? kBlueColor,
      icon: const Icon(Fontisto.share_a),
    );
  }

  Future<void> _shareFile() async {
    try {
      await Share.share(publicLink, subject: 'This is link file');
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
