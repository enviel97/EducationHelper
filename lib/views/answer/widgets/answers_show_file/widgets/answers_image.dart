import 'dart:io';
import 'package:flutter/material.dart';

class AnswersImage extends StatefulWidget {
  final File file;
  final double height;

  const AnswersImage({
    required this.file,
    required this.height,
    Key? key,
  }) : super(key: key);

  @override
  State<AnswersImage> createState() => _AnswersImageState();
}

class _AnswersImageState extends State<AnswersImage> {
  final _controller = TransformationController();
  TapDownDetails? _doubleTapDetails;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTapDown: _handleDoubleTapDown,
      onDoubleTap: _handleDoubleTap,
      child: InteractiveViewer(
        transformationController: _controller,
        constrained: false,
        scaleEnabled: false,
        child: Image.file(
          widget.file,
          height: widget.height,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  void _handleDoubleTap() {
    try {
      final pos = _doubleTapDetails!.localPosition;
      const double scale = 3;
      final x = -pos.dx * (scale - 1);
      final y = -pos.dy * (scale - 1);
      final zoomed = Matrix4.identity()
        ..translate(x, y)
        ..scale(scale);
      final value =
          _controller.value.isIdentity() ? zoomed : Matrix4.identity();
      _controller.value = value;
    } catch (e) {
      debugPrint('error: $e');
    }
  }

  void _handleDoubleTapDown(TapDownDetails details) {
    _doubleTapDetails = details;
  }
}
