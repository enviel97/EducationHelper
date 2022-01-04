import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/roots/app_root.dart';
import 'package:education_helper/views/home/adapters/home.adapter.dart';
import 'package:education_helper/views/widgets/button/custom_text_button.dart';
import 'package:flutter/material.dart';

class ErrorAuthenticate extends StatelessWidget {
  final String messenger;
  final Function()? onPressConfirm;
  final String? labelConfirm;
  const ErrorAuthenticate({
    required this.messenger,
    this.onPressConfirm,
    Key? key,
    this.labelConfirm,
  }) : super(key: key);

  HomeAdapter get _adapter =>
      Root.ins.adapter.getAdapter(homeAdapter).as<HomeAdapter>();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 200.0,
          decoration: BoxDecoration(
            border: Border.all(
              color: kErrorColor.withOpacity(0.7),
              width: 5.0,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(30)),
            color: kPlaceholderColor,
          ),
          margin: const EdgeInsets.symmetric(horizontal: 24.0),
          alignment: Alignment.center,
          child: Text(
            messenger,
            style: TextStyle(
              color: kBlackColor,
              fontWeight: FontWeight.bold,
              fontSize: SPACING.XL.size,
            ),
          ),
        ),
        SPACING.LG.vertical,
        KTextButton(
          onPressed: () => _onConfrim(context),
          text: labelConfirm ?? 'Confirm',
        )
      ],
    );
  }

  Future<void> _onConfrim(BuildContext context) async {
    if (onPressConfirm != null) onPressConfirm!();
    _adapter.goToLogin(context);
  }
}
