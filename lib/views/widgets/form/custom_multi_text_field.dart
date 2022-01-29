import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/helpers/extensions/state.x.dart';
import 'package:flutter/material.dart';

class KMultiTextField extends StatefulWidget {
  final String hintText;
  final String labelText;
  final bool isSecurity;
  final String? Function(String? value)? validation;
  final TextInputAction textInputAction;
  final bool isClearButton;
  final TextInputType keyboardType;
  final void Function(String value)? onChange;
  final void Function(String value)? onSubmit;
  final bool autoFocus;
  final String? initValue;
  const KMultiTextField({
    required this.labelText,
    Key? key,
    this.hintText = '',
    this.isSecurity = false,
    this.validation,
    this.textInputAction = TextInputAction.next,
    this.isClearButton = true,
    this.keyboardType = TextInputType.text,
    this.onChange,
    this.onSubmit,
    this.autoFocus = false,
    this.initValue,
  }) : super(key: key);

  @override
  State<KMultiTextField> createState() => _KMultiTextFieldState();
}

class _KMultiTextFieldState extends State<KMultiTextField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initValue);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final _border = const OutlineInputBorder(
    borderRadius: BorderRadius.zero,
    borderSide: BorderSide(color: kPrimaryColor, width: 1.5),
  );

  final _radiusBorder = const OutlineInputBorder(
    borderRadius: BorderRadius.only(topLeft: Radius.circular(25.0)),
    borderSide: BorderSide(color: kPrimaryColor, width: 2.0),
  );

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: const ValueKey(123456789),
      controller: _controller,
      keyboardType: TextInputType.multiline,
      minLines: 2,
      maxLines: null,
      cursorColor: kSecondaryColor,
      validator: widget.validation,
      textInputAction: widget.textInputAction,
      onChanged: _onChagne,
      style: const TextStyle(
        color: kBlackColor,
      ),
      decoration: InputDecoration(
        label: Text(widget.labelText),
        labelStyle: const TextStyle(color: kPrimaryColor, fontSize: 18.0),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 10.0, vertical: 12.0),
        border: _border,
        focusColor: kBlackColor,
        errorMaxLines: 1,
        errorStyle: const TextStyle(
            color: kBlackColor,
            fontWeight: FontWeight.bold,
            overflow: TextOverflow.fade),
        enabledBorder: _border,
        focusedBorder: _radiusBorder,
        errorBorder: _border,
        focusedErrorBorder: _radiusBorder,
        suffixIcon: _buildClearButton(),
      ),
    );
  }

  Widget _buildClearButton() {
    if (!widget.isClearButton || _controller.text.isEmpty) {
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
            setState(_controller.clear);
            if (widget.onChange != null) {
              widget.onChange!('');
            }
          }),
    );
  }

  void _onChagne(String value) {
    try {
      if (_controller.text.length == 1) {
        setState(() {});
      }
      if (widget.onChange == null) return;
      widget.onChange!(value.trim());
    } catch (_) {}
  }
}
