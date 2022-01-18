import 'package:cached_network_image/cached_network_image.dart';
import 'package:education_helper/constants/colors.dart';
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

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.0,
      width: 100.0,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(30.0)),
        child: name.toLowerCase().contains('image')
            ? CachedNetworkImage(
                imageUrl: public,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(30.0),
                    border: Border.all(color: kBlackColor, width: 2.0),
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
                    child: CircularProgressIndicator(color: kWhiteColor),
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
                color: kErrorColor,
                alignment: Alignment.center,
                child: Text(
                  '.PDF',
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
