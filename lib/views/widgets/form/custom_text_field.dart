import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/helpers/extensions/build_context_x.dart';
import 'package:education_helper/helpers/extensions/state.x.dart';
import 'package:flutter/material.dart';

class KTextField extends StatefulWidget {
  final IconData iconData;
  final String hintText;
  final bool isSecurity;
  final String? Function(String? value)? validation;
  final TextInputAction textInputAction;
  final bool isClearButton;
  final TextInputType keyboardType;
  final void Function(String value)? onChange;
  final void Function(String value)? onSubmit;
  final bool autoFocus;
  final String? initValue;

  const KTextField({
    required this.iconData,
    required this.hintText,
    this.isSecurity = false,
    this.validation,
    this.textInputAction = TextInputAction.next,
    this.isClearButton = true,
    this.keyboardType = TextInputType.text,
    this.onChange,
    this.onSubmit,
    this.autoFocus = false,
    this.initValue,
    Key? key,
  }) : super(key: key);

  @override
  State<KTextField> createState() => _KTextFieldState();
}

class _KTextFieldState extends State<KTextField> {
  bool showText = false;

  late TextEditingController controller;

  final Color backgorundColor = kSecondarySuperDarkColor;
  final BorderRadius borderRadius = BorderRadius.circular(10.0);
  final _border = const OutlineInputBorder(
    borderRadius: BorderRadius.zero,
    borderSide: BorderSide(color: kPrimaryColor, width: 1.5),
  );

  final _radiusBorder = const OutlineInputBorder(
    borderRadius: BorderRadius.only(topLeft: Radius.circular(25.0)),
    borderSide: BorderSide(color: kPrimaryColor, width: 2.0),
  );
  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.initValue);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      width: double.infinity,
      decoration: const BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(25.0)),
          boxShadow: [
            BoxShadow(
              color: kPrimaryLightColor,
              blurRadius: 0,
              offset: Offset(5, 5),
            )
          ]),
      child: Row(
        children: [
          Flexible(
            child: TextFormField(
              controller: controller,
              cursorColor: kSecondaryColor,
              validator: widget.validation,
              textInputAction: widget.textInputAction,
              keyboardType: widget.keyboardType,
              obscureText: widget.isSecurity && !showText,
              autocorrect: false,
              autofocus: widget.autoFocus,
              onChanged: _onChagne,
              onFieldSubmitted: widget.onSubmit,
              maxLines: 1,
              decoration: InputDecoration(
                  prefixIcon: Icon(widget.iconData,
                      color: isLightTheme ? kPrimaryColor : kSecondaryColor),
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 12.0),
                  hintText: widget.hintText,
                  hintStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isLightTheme ? kBlackColor : kWhiteColor),
                  border: _border,
                  focusColor: kBlackColor,
                  filled: true,
                  fillColor: context.backgroundColor,
                  errorMaxLines: 1,
                  errorStyle: const TextStyle(
                      color: kBlackColor,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.fade),
                  enabledBorder: _border,
                  focusedBorder: _radiusBorder,
                  errorBorder: _border,
                  focusedErrorBorder: _radiusBorder,
                  suffixIcon: _buildClearButton()),
            ),
          ),
          _buildShowTextButton(),
        ],
      ),
    );
  }

  Widget _buildShowTextButton() {
    if (!widget.isSecurity) return const SizedBox.shrink();
    return Container(
      margin: const EdgeInsets.only(top: 5.0),
      decoration: const BoxDecoration(color: Colors.transparent),
      child: IconButton(
          onPressed: () {
            if (!mounted) return;
            setState(() => showText = !showText);
          },
          padding: const EdgeInsets.all(0.0),
          color: kBlackColor,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          tooltip: 'Show password text',
          icon: Icon(!showText
              ? Icons.visibility_rounded
              : Icons.visibility_off_rounded)),
    );
  }

  Widget _buildClearButton() {
    if (!widget.isClearButton || controller.text.isEmpty) {
      return const SizedBox.shrink();
    }
    return CircleAvatar(
      backgroundColor: Colors.transparent,
      child: IconButton(
          icon: const Icon(Icons.cancel_rounded),
          color: kSecondaryColor,
          splashColor: kBlackColor,
          highlightColor: kBlackColor,
          onPressed: () {
            if (!mounted) return;
            setState(controller.clear);
            if (widget.onChange != null) {
              widget.onChange!('');
            }
          }),
    );
  }

  void _onChagne(String value) {
    if (controller.text.length < 2) {
      setState(() {});
    }
    if (widget.onChange == null) return;
    widget.onChange!(value.trim());
  }
}
