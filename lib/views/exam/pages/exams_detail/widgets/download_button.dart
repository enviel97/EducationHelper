import 'dart:io';

import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/helpers/extensions/state.x.dart';
import 'package:flowder/flowder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class DownloadButton extends StatefulWidget {
  final String name;
  final String download;
  const DownloadButton({
    required this.name,
    required this.download,
    Key? key,
  }) : super(key: key);

  @override
  State<DownloadButton> createState() => _DownloadButtonState();
}

class _DownloadButtonState extends State<DownloadButton> {
  late DownloaderCore core;
  late final String path;
  late IconData icon = Entypo.download;
  late File file;
  double process = 0.0;
  bool isDownloading = false;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    _setPath();
    if (!mounted) return;
  }

  void _setPath() async {
    path = (await getExternalStorageDirectory())?.path ?? '';
    file = File('$path/${widget.name}');
    setState(() =>
        icon = file.existsSync() ? Icons.open_in_browser : Entypo.download);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
          iconSize: 32.0,
          padding: const EdgeInsets.all(0.0),
          onPressed: _onHandleFile,
          color: isLightTheme ? kWhiteColor : kBlackColor,
          icon: Icon(icon),
        ),
        Container(
          child: isDownloading
              ? SizedBox(
                  width: 50.0,
                  child: LinearProgressIndicator(
                    value: process,
                    minHeight: 4.0,
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
      print(error);
    }
  }

  Future<void> _openFile() async {
    OpenFile.open(file.path);
  }

  Future<void> _download() async {
    setState(() => isDownloading = true);
    await Flowder.download(
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
    );
  }
}
