import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/helpers/extensions/build_context_x.dart';
import 'package:education_helper/helpers/extensions/state.x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class KSearchText extends StatefulWidget {
  final String hintText;
  final String? initialValue;
  final Function(String value) onSearch;
  final Function(String value)? onChanged;

  const KSearchText({
    required this.hintText,
    required this.onSearch,
    Key? key,
    this.initialValue,
    this.onChanged,
  }) : super(key: key);

  @override
  _KSearchTextState createState() => _KSearchTextState();
}

class _KSearchTextState extends State<KSearchText> {
  late TextEditingController _controller;
  String value = '';
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue ?? '');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 20.0,
      shadowColor: kPrimaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.all(
          Radius.circular(40.0),
        ),
        side: BorderSide(
            color: isLightTheme ? kPrimaryDarkColor : kPrimaryColor,
            width: 1.5),
      ),
      child: Row(
        children: [
          Expanded(
            child: Theme(
              data: ThemeData(
                  textSelectionTheme: TextSelectionThemeData(
                      cursorColor: kWhiteColor,
                      selectionColor: kWhiteColor.withOpacity(.5),
                      selectionHandleColor: kWhiteColor.withOpacity(.5))),
              child: TextField(
                controller: _controller,
                cursorColor: kWhiteColor,
                enableSuggestions: false,
                enableInteractiveSelection: false,
                autocorrect: false,
                onChanged: _onChange,
                onTap: () {
                  _controller.selection = TextSelection(
                    baseOffset: 0,
                    extentOffset: value.length,
                  );
                },
                onSubmitted: (value) => widget.onSearch(value),
                style: const TextStyle(color: kWhiteColor),
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Feather.search,
                    color: kWhiteColor,
                    size: 20.0,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 10.0,
                  ),
                  hintText: 'Search',
                  hintStyle: const TextStyle(
                      fontWeight: FontWeight.bold, color: kWhiteColor),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(40.0)),
                  ),
                  focusColor: kBlackColor,
                  filled: true,
                  fillColor: isLightTheme ? kPrimaryDarkColor : kPrimaryColor,
                  errorMaxLines: 1,
                  suffixIcon: _buildClearButton(),
                ),
              ),
            ),
          ),
          _buildSend(),
        ],
      ),
    );
  }

  void _onChange(String value) {
    if (widget.onChanged != null) {
      widget.onChanged!(value);
    }
    setState(() => this.value = value);
  }

  Widget _buildClearButton() {
    if (_controller.text.isEmpty) {
      return const SizedBox.shrink();
    }
    return IconButton(
      icon: const Icon(
        Icons.cancel,
        color: kWhiteColor,
      ),
      onPressed: () {
        context.disableKeyBoard();
        setState(() => value = '');
        _controller.clear();
        widget.onSearch('');
      },
    );
  }

  Widget _buildSend() {
    return IconButton(
      icon: const Icon(
        Ionicons.send_sharp,
        color: kPrimaryColor,
      ),
      onPressed: () {
        context.disableKeyBoard();
        widget.onSearch(value);
      },
    );
  }
}
