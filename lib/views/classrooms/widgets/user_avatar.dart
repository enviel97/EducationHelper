import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/helpers/ultils/funtions.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class UserAvatar extends StatelessWidget {
  final String url;
  const UserAvatar({Key? key, this.url = ''}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(40.0),
      child: Container(
        height: 100,
        width: 100,
        decoration: const BoxDecoration(color: kPrimaryColor),
        child: url.isNotEmpty
            ? FadeInImage.memoryNetwork(
                fit: BoxFit.cover,
                placeholder: kTransparentImage,
                imageErrorBuilder: _buildError,
                image: url,
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  ImageFromLocal.asPng('error_avatar'),
                  fit: BoxFit.cover,
                ),
              ),
      ),
    );
  }

  Widget _buildError(
      BuildContext context, Object error, StackTrace? stackTrace) {
    debugPrint(error.toString());
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        color: kWhiteColor,
        border: Border.all(
          width: 2.0,
          color: kPrimaryColor,
        ),
      ),
      child: Center(
        child: Text(
          'Error',
          style: TextStyle(color: kErrorColor, fontSize: SPACING.LG.size),
        ),
      ),
    );
  }
}
