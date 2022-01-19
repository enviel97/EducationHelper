import 'dart:io';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ExamPdf extends StatefulWidget {
  final File file;
  const ExamPdf({
    required this.file,
    Key? key,
  }) : super(key: key);

  @override
  _ExamPdfState createState() => _ExamPdfState();
}

class _ExamPdfState extends State<ExamPdf> {
  final _pdfkey = GlobalKey<SfPdfViewerState>();
  final _controller = PdfViewerController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(pdfControllerListen);
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(20.0)),
      child: SfPdfViewer.file(
        widget.file,
        key: _pdfkey,
        controller: _controller,
        pageSpacing: 0.0,
        initialScrollOffset: const Offset(40.0, 25.0),
        enableTextSelection: false,
        initialZoomLevel: 1,
        interactionMode: PdfInteractionMode.selection,
        scrollDirection: PdfScrollDirection.horizontal,
        pageLayoutMode: PdfPageLayoutMode.single,
        canShowPaginationDialog: false,
      ),
    );
  }

  void pdfControllerListen({String? property}) {}
}
