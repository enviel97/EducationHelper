import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/helpers/extensions/state.x.dart';
import 'package:education_helper/views/member/bloc/member_bloc.dart';
import 'package:education_helper/views/widgets/button/custom_icon_button.dart';
import 'package:education_helper/views/widgets/header/appbar_bottom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class MemberAddMultible extends StatefulWidget {
  final String classname;

  const MemberAddMultible({
    required this.classname,
    Key? key,
  }) : super(key: key);

  @override
  _MemberAddMultibleState createState() => _MemberAddMultibleState();
}

class _MemberAddMultibleState extends State<MemberAddMultible> {
  bool isNeedRefresh = false;
  @override
  void initState() {
    super.initState();
    //
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new), onPressed: _onGoBack),
        title: const Text('Add Users'),
        bottom: const AppbarBottom(),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.classname),
              KIconButton(
                backgroundColor: kPrimaryColor,
                sideColor: kPrimaryColor,
                icon: const Icon(FontAwesome5Solid.file_csv),
                onPressed: _handleReadCsv,
              )
            ],
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(40.0),
                    bottomLeft: Radius.circular(40.0),
                  ),
                  color: kWhiteColor,
                  boxShadow: [
                    BoxShadow(
                      color: isLightTheme ? kBlackColor : kWhiteColor,
                      offset: const Offset(4, 4),
                    )
                  ]),
            ),
          )
        ]),
      ),
    );
  }

  Future<void> _onGoBack() async {
    // if (isNeedRefresh) {
    //   await Future.wait([BlocProvider.of<MemberBloc>(context).refreshMembers()])
    //       .whenComplete(Navigator.of(context).pop);
    // } else {
    Navigator.of(context).pop();
    // }
  }

  void _handleReadCsv() {}
}
