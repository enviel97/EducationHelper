import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/constants/typing.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class UserAvatar extends StatelessWidget {
  final String url;
  const UserAvatar({Key? key, this.url = ''}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(40.0),
      child: url.isNotEmpty
          ? FadeInImage.memoryNetwork(
              height: 100,
              width: 100,
              fit: BoxFit.cover,
              placeholder: kTransparentImage,
              imageErrorBuilder: _buildError,
              image: url,
            )
          : Container(
              height: 100,
              width: 100,
              decoration: const BoxDecoration(color: kPrimaryColor),
              child: const Center(
                child: CircularProgressIndicator(
                  color: kWhiteColor,
                ),
              ),
            ),
    );
  }

  Widget _buildError(
      BuildContext context, Object error, StackTrace? stackTrace) {
    debugPrint(error.toString());
    return SizedBox(
      height: 100,
      width: 100,
      child: Center(
        child: Text(
          'Image error',
          style: TextStyle(color: kErrorColor, fontSize: SPACING.LG.size),
        ),
      ),
    );
  }
}
