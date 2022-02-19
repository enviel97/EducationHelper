import 'dart:io';

import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/helpers/extensions/state.x.dart';
import 'package:education_helper/helpers/streams/file_picker_stream.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class KSelectImage extends StatefulWidget {
  final File? file;
  final void Function(File? image) onAvatarChanged;
  final double imageWidth;
  final double imageHeight;
  const KSelectImage({
    required this.onAvatarChanged,
    Key? key,
    this.file,
    this.imageWidth = double.infinity,
    this.imageHeight = double.infinity,
  }) : super(key: key);

  @override
  State<KSelectImage> createState() => _KSelectImageState();
}

class _KSelectImageState extends State<KSelectImage> {
  late FilePickerStream _controller;
  File? file;

  @override
  void initState() {
    super.initState();
    _controller = FilePickerStream(widget.file,
        type: FileType.custom, allowedExtensions: ['jpg', 'jpeg', 'png']);
    _controller.stream.listen(hookData);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = isLightTheme ? kSecondaryLightColor : kPrimaryLightColor;
    Widget tools = const SizedBox.shrink();
    if (file != null) {
      tools = Positioned(
        right: 0.0,
        top: 0.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 18.0,
              backgroundColor: kErrorColor,
              child: IconButton(
                onPressed: _controller.remove,
                icon: const Icon(FontAwesome.remove),
                iconSize: 18.0,
                color: kWhiteColor,
              ),
            )
          ],
        ),
      );
    }

    return SizedBox(
      width: widget.imageWidth,
      height: widget.imageHeight,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          GestureDetector(
            onTap: _controller.filePicker,
            child: Container(
              width: widget.imageWidth - 10.0,
              height: widget.imageHeight - 10.0,
              decoration: BoxDecoration(
                border: Border.all(
                  color: color,
                  width: 2.0,
                ),
              ),
              child: StreamBuilder<File?>(
                initialData: _controller.file,
                stream: _controller.stream,
                builder: _streamBuilder,
              ),
            ),
          ),
          tools,
        ],
      ),
    );
  }

  Widget _streamBuilder(BuildContext context, AsyncSnapshot<File?> snapshot) {
    if (snapshot.hasData) {
      if (snapshot.data == null) {
        return DecoratedBox(
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
          ),
          child: const Center(
              child: CircularProgressIndicator(backgroundColor: kNone)),
        );
      } else {
        final file = snapshot.data!;
        return Image.file(
          file,
          fit: BoxFit.cover,
        );
      }
    }

    return const Icon(
      Icons.add,
      size: 40.0,
      color: kWhiteColor,
    );
  }

  void hookData(File? file) {
    setState(() {
      this.file = file;
    });
    widget.onAvatarChanged(file);
  }
}
