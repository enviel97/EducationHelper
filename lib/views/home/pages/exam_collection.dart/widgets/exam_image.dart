import 'package:cached_network_image/cached_network_image.dart';
import 'package:education_helper/constants/typing.dart';
import 'package:flutter/material.dart';

class ExamImage extends StatelessWidget {
  final String public;
  final String name;
  const ExamImage({
    required this.public,
    required this.name,
    Key? key,
  }) : super(key: key);

  Color get color {
    switch (name.split('/').first.toUpperCase()) {
      case 'PDF':
        return Colors.red;
      case 'RAR':
        return const Color(0xFF16772b);
      case 'ZIP':
        return const Color(0xFF3b3da3);
      default:
        return Colors.transparent;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 95.0,
      width: 127.0,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(30.0)),
        child: name.toLowerCase().contains('image')
            ? CachedNetworkImage(
                imageUrl: public,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                placeholder: (context, url) => const Center(
                  child: SizedBox(
                    height: 50.0,
                    width: 50.0,
                    child: CircularProgressIndicator(),
                  ),
                ),
                errorWidget: (context, url, error) => const Center(
                  child: SizedBox(
                    height: 50.0,
                    width: 50.0,
                    child: Icon(Icons.error),
                  ),
                ),
              )
            : Container(
                color: color,
                alignment: Alignment.center,
                child: Text(
                  name.split('/').first,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: SPACING.XL.size,
                  ),
                ),
              ),
      ),
    );
  }
}
