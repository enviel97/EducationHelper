import 'dart:io';

import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/helpers/extensions/state.x.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flowder/flowder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class DownloadButton extends StatefulWidget {
  final String name;
  final String download;
  final double iconSize;
  final Color? iconColor;
  const DownloadButton({
    required this.name,
    required this.download,
    Key? key,
    this.iconSize = 32.0,
    this.iconColor,
  }) : super(key: key);

  @override
  State<DownloadButton> createState() => _DownloadButtonState();
}

class _DownloadButtonState extends State<DownloadButton> {
  DownloaderCore? core;
  late final String path;
  late IconData icon = Entypo.download;
  late File file;
  String name = '';
  double process = 0.0;
  bool isDownloading = false;

  @override
  void didUpdateWidget(DownloadButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.name != widget.name) {
      initPlatformState();
    }
  }

  @override
  void dispose() {
    core?.pause();
    core?.cancel();
    super.dispose();
  }

  initPlatformState() async {
    if (!mounted) return;
    await _setPath();
  }

  Future<void> _setPath() async {
    path = (await getExternalStorageDirectory())?.path ?? '';
    file = File('$path/${widget.name}');
    setState(() =>
        icon = file.existsSync() ? Icons.open_in_browser : Entypo.download);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        IconButton(
          iconSize: widget.iconSize,
          padding: const EdgeInsets.all(0.0),
          onPressed: _onHandleFile,
          color: widget.iconColor ?? (isLightTheme ? kWhiteColor : kBlackColor),
          icon: Icon(icon),
        ),
        Container(
          child: isDownloading
              ? SizedBox(
                  width: widget.iconSize * 1.2,
                  child: LinearProgressIndicator(
                    color: kSuccessColor,
                    value: process,
                    minHeight: 5.0,
                  ),
                )
              : const SizedBox.shrink(),
        )
      ],
    );
  }

  void _onHandleFile() async {
    if (path.isEmpty) return;
    try {
      if (file.existsSync()) {
        _openFile();
      } else {
        _download();
      }
    } catch (error) {
      debugPrint('$error');
    }
  }

  void _openFile() {
    if (file.path.contains('rar') || file.path.contains('zip')) {
      return;
    }
    OpenFile.open(file.path);
  }

  Future<void> _download() async {
    if (widget.name.isEmpty || widget.download.isEmpty) return;
    setState(() => isDownloading = true);
    try {
      Flowder.download(
        widget.download,
        DownloaderUtils(
          progressCallback: (current, total) {
            setState(() => process = current / total);
          },
          file: file,
          progress: ProgressImplementation(),
          onDone: () async {
            setState(() => icon = Icons.download_done_rounded);
            await Future.delayed(
              const Duration(milliseconds: 500),
              () => setState(() {
                icon = Icons.open_in_browser;
                isDownloading = false;
              }),
            );
          },
          deleteOnCancel: true,
        ),
      ).then((value) => core = value);
    } catch (e) {
      debugPrint('[Download button error]: $e');
      setState(() => isDownloading = false);
    }
  }
}
