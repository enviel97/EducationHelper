import 'dart:io';

import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/helpers/extensions/build_context_x.dart';
import 'package:education_helper/helpers/streams/file_picker_stream.dart';
import 'package:education_helper/views/answer/widgets/answers_show_file/pages/answers_content.dart';
import 'package:flutter/material.dart';

class AnswerFilePickerContent extends StatefulWidget {
  final File? file;
  final Function(File? file) onFileChange;
  final bool isDisable;

  const AnswerFilePickerContent({
    required this.file,
    required this.onFileChange,
    required this.isDisable,
    Key? key,
  }) : super(key: key);

  @override
  State<AnswerFilePickerContent> createState() =>
      _AnswerFilePickerContentState();
}

class _AnswerFilePickerContentState extends State<AnswerFilePickerContent> {
  late FilePickerStream controller;
  File? file;

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  void didUpdateWidget(covariant AnswerFilePickerContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.file != widget.file) {
      _init();
    }
  }

  void _init() {
    file = widget.file;
    controller = FilePickerStream(widget.file);
    controller.stream.listen(_onFileChanged);
  }

  @override
  Widget build(BuildContext context) {
    Widget tools = const SizedBox.shrink();
    if (file != null) {
      tools = Align(
        alignment: Alignment.topLeft,
        child: Row(
          children: [
            IconButton(
              onPressed: widget.isDisable ? null : controller.filePicker,
              icon: const Icon(Icons.edit),
              color: kPrimaryColor,
            ),
            IconButton(
              onPressed: widget.isDisable ? null : controller.remove,
              icon: const Icon(Icons.delete),
              color: kErrorColor,
            )
          ],
        ),
      );
    }
    return Stack(fit: StackFit.expand, children: [
      StreamBuilder<File?>(
        initialData: controller.file,
        stream: controller.stream,
        builder: _streamBuilder,
      ),
      tools,
    ]);
  }

  Widget _streamBuilder(BuildContext context, AsyncSnapshot<File?> snapshot) {
    if (snapshot.hasData) {
      if (snapshot.data == null) {
        return DecoratedBox(
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: const BorderRadius.all(Radius.circular(25)),
          ),
          child: const Center(
              child: CircularProgressIndicator(
            backgroundColor: kNone,
          )),
        );
      } else {
        final file = snapshot.data!;
        return ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(25)),
          child: AnswerContent(
            file: file,
            pdfPadding: const EdgeInsets.symmetric(horizontal: 10.0),
            imageHeight: context.mediaSize.height * .65,
          ),
        );
      }
    }

    return IconButton(
      iconSize: 40.0,
      color: kWhiteColor,
      icon: const Icon(Icons.add),
      onPressed: controller.filePicker,
    );
  }

  void _onFileChanged(File? snapshot) {
    widget.onFileChange(snapshot);
    setState(() => file = snapshot);
  }
}
