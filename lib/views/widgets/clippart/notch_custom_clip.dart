import 'package:flutter/material.dart';

class NotchedCustomClippath extends CustomClipper<Path> {
  final Offset notchOffset;
  const NotchedCustomClippath(this.notchOffset);

  @override
  Path getClip(Size size) {
    final host = getApproximateClipRect(size);

    final guest = Rect.fromCircle(center: notchOffset, radius: 30);
    return const CircularNotchedRectangle().getOuterPath(host, guest);
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) => true;
}
