import 'dart:async';
import 'dart:io';

import 'package:education_helper/helpers/extensions/state.x.dart';
import 'package:education_helper/views/widgets/deorate/box_decorate_separate_number.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

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
  final _controller = Completer<PDFViewController>();
  int? pages = 0;
  int? currentPage = 0;
  bool isReady = false;
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(25.0)),
          child: PDF(
            enableSwipe: true,
            swipeHorizontal: true,
            autoSpacing: true,
            pageFling: true,
            pageSnap: true,
            defaultPage: currentPage!,
            fitPolicy: FitPolicy.BOTH,
            nightMode: !isLightTheme,
            preventLinkNavigation: false,
            onRender: (_pages) {
              setState(() {
                pages = _pages;
                isReady = true;
              });
            },
            onError: (error) {
              setState(() => errorMessage = error.toString());
            },
            onViewCreated: _controller.complete,
            onPageChanged: (int? page, int? total) {
              setState(() => currentPage = page);
            },
            onPageError: (page, error) {
              setState(() {
                errorMessage = '$page: ${error.toString()}';
              });
            },
          ).fromPath(widget.file.path),
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
            padding: const EdgeInsets.all(15.0),
            child: BoxDecorateSeparateNumber(
              totalMembers: pages!,
              totalExams: currentPage!,
            ),
          ),
        )
      ],
    );
  }
}
