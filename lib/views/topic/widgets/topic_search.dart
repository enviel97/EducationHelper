import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/helpers/extensions/datetime_x.dart';
import 'package:education_helper/helpers/extensions/state.x.dart';
import 'package:education_helper/views/widgets/button/custom_animate_icon_button.dart';
import 'package:education_helper/views/widgets/deorate/horizantal_divider.dart';
import 'package:education_helper/views/widgets/form/custom_date_picker_search.dart';
import 'package:education_helper/views/widgets/form/custom_search_field.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class TopicSearch extends StatefulWidget {
  final bool defaultExpanded;
  final bool isLoading;
  const TopicSearch({
    Key? key,
    this.defaultExpanded = false,
    this.isLoading = false,
  }) : super(key: key);

  @override
  State<TopicSearch> createState() => _TopicSearchState();
}

class _TopicSearchState extends State<TopicSearch>
    with SingleTickerProviderStateMixin {
  String searchHint = 'Search query ... ';
  late ExpandableController _controller;
  final _datefromController = KDatePickerSearchController();
  final _datetoController = KDatePickerSearchController();
  final format = 'dd/MM/yy';
  DateTime? from, to;

  @override
  void initState() {
    super.initState();
    _controller = ExpandableController(initialExpanded: widget.defaultExpanded);
  }

  @override
  void dispose() {
    _controller.dispose();
    _datefromController.dispose();
    _datetoController.dispose();
    super.dispose();
  }

  Color get color => isLightTheme ? kPrimaryDarkColor : kPrimaryColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 5.0,
      ),
      child: Stack(
        children: [
          Positioned(
            top: 0.0,
            right: 0.0,
            child: Container(
              decoration: BoxDecoration(
                  color: kWhiteColor,
                  border: Border.all(color: color, width: 1.5),
                  borderRadius: const BorderRadius.horizontal(
                      right: Radius.circular(40.0))),
              alignment: Alignment.centerRight,
              height: 48.0,
              width: 75.0,
              child: AnimateIcons(
                startIcon: AntDesign.calendar,
                endIcon: Entypo.chevron_up,
                iconColor: color,
                onStartIconPress: () {
                  _datefromController.set(DateTime.now());
                  _controller.toggle();
                },
                onEndIconPress: () {
                  _datetoController.clear();
                  _datefromController.clear();
                  from = to = null;
                  _controller.toggle();
                },
              ),
            ),
          ),
          ExpandablePanel(
            theme: const ExpandableThemeData(
              tapBodyToExpand: false,
              tapBodyToCollapse: false,
              tapHeaderToExpand: false,
              hasIcon: false,
              useInkWell: false,
            ),
            header: _builderCollapsed,
            controller: _controller,
            collapsed: const SizedBox.shrink(),
            expanded: _buildExpanded,
          ),
        ],
      ),
    );
  }

  Widget get _builderCollapsed {
    return Padding(
      padding: const EdgeInsets.only(right: 45.0),
      child: KSearchText(
        hintText: 'Search with name',
        onSearch: _searching,
        isLoading: widget.isLoading,
        elevation: 0.0,
      ),
    );
  }

  Widget get _buildExpanded {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Row(
        children: [
          Flexible(
            child: KDatePickerSearch(
              iconSize: 20,
              controller: _datefromController,
              initDate: from,
              hintText: 'Selected date',
              formatDate: format,
              onChange: (date) {
                from = DateTimeX.cast(date, format: format);
                _datetoController.set(from!, start: from);
                to = from;
              },
            ),
          ),
          Container(
            width: 20.0,
            height: 54.0,
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: const HorizantalDivider(),
          ),
          Flexible(
            child: KDatePickerSearch(
              iconSize: 20,
              controller: _datetoController,
              hintText: 'Selected date',
              formatDate: format,
              onChange: (date) {
                to = DateTimeX.cast(date, format: format);
              },
            ),
          )
        ],
      ),
    );
  }

  void _searching(String value) {
    final Map<String, dynamic> parameters = {
      'text': value,
    };
    if (from != null) {
      parameters['from'] = from!.startDay;
      parameters['to'] = to?.endDay;
    }
  }
}
