import 'dart:io';

import 'package:education_helper/views/widgets/deorate/box_decorate_separate_number.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class AnswersPDF extends StatefulWidget {
  final File file;
  const AnswersPDF({
    required this.file,
    Key? key,
  }) : super(key: key);

  @override
  State<AnswersPDF> createState() => _AnswersPDFState();
}

class _AnswersPDFState extends State<AnswersPDF> {
  late PdfViewerController _controller;
  int? pages = 0, currentPage = 0;
  bool isReady = false;
  String errorMessage = '';
  @override
  void initState() {
    super.initState();
    _controller = PdfViewerController();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Container(
            padding: const EdgeInsets.only(top: 60.0),
            child: SfPdfViewer.file(
              widget.file,
              canShowScrollHead: false,
              controller: _controller,
              enableDocumentLinkAnnotation: false,
              scrollDirection: PdfScrollDirection.horizontal,
              interactionMode: PdfInteractionMode.pan,
              pageLayoutMode: PdfPageLayoutMode.single,
              onPageChanged: (detail) {
                setState(() => currentPage = _controller.pageNumber);
              },
              onDocumentLoaded: (detail) {
                setState(() {
                  currentPage = _controller.pageNumber;
                  pages = _controller.pageCount;
                  isReady = true;
                });
              },
              onDocumentLoadFailed: (error) {
                setState(() => errorMessage = error.toString());
              },
            ),
          ),
          errorMessage.isEmpty
              ? !isReady
                  ? const Center(child: CircularProgressIndicator())
                  : Container()
              : Center(
                  child: Text(errorMessage,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16.0))),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 50.0, right: 20.0),
              child: BoxDecorateSeparateNumber(
                totalMembers: pages!,
                totalExams: currentPage!,
              ),
            ),
          )
        ],
      ),
    );
  }
}
