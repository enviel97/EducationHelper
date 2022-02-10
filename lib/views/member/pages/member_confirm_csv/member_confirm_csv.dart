import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/helpers/extensions/state.x.dart';
import 'package:education_helper/models/members.model.dart';
import 'package:education_helper/roots/bloc/app_bloc.dart';
import 'package:education_helper/views/member/bloc/member_bloc.dart';
import 'package:education_helper/views/member/bloc/member_state.dart';
import 'package:education_helper/views/widgets/button/custom_text_button.dart';
import 'package:education_helper/views/widgets/header/appbar_bottom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/members_detail_list.dart';

class MemberConfirmCSV extends StatefulWidget {
  final String classname;
  final List<Member> members;

  const MemberConfirmCSV({
    required this.classname,
    required this.members,
    Key? key,
  }) : super(key: key);

  @override
  _MemberConfirmCSVState createState() => _MemberConfirmCSVState();
}

class _MemberConfirmCSVState extends State<MemberConfirmCSV> {
  final members = [];
  @override
  void initState() {
    super.initState();
    members.addAll(widget.members);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: Navigator.of(context).pop,
        ),
        title: const Text('Add members'),
        bottom: const AppbarBottom(),
      ),
      body: BlocListener<MemberBloc, MemberState>(
        listener: (BuildContext context, MemberState state) {
          if (state is MemberFailureState) {
            BlocProvider.of<AppBloc>(context)
                .showError(context, state.messenger);
          }

          if (state is MemberCreateState) {
            Navigator.of(context).pop();
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text(
                  widget.classname,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: SPACING.LG.size,
                  ),
                ),
              ),
              SPACING.M.vertical,
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(25.0),
                        bottomLeft: Radius.circular(25.0),
                      ),
                      color: kWhiteColor,
                      border: Border.all(
                        color: kBlackColor.withOpacity(.7),
                        width: 1.2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: isLightTheme ? kBlackColor : kWhiteColor,
                          offset: const Offset(4.0, 4.0),
                          blurRadius: 4.0,
                        )
                      ]),
                  child: MembersDetailList(members: widget.members),
                ),
              ),
              SPACING.M.vertical,
              const Center(
                child: Text(
                  'Press confirm to add members',
                  textAlign: TextAlign.center,
                ),
              ),
              SPACING.M.vertical,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  KTextButton(
                    width: 150.0,
                    onPressed: _storeValue,
                    text: 'Confirm',
                  ),
                  KTextButton(
                    width: 150.0,
                    isOutline: true,
                    color: kWhiteColor,
                    style: TextStyle(
                        color: isLightTheme ? kBlackColor : kWhiteColor),
                    onPressed: Navigator.of(context).pop,
                    text: 'Cancel',
                  )
                ],
              ),
              SPACING.LG.vertical,
            ],
          ),
        ),
      ),
    );
  }

  void _storeValue() {
    BlocProvider.of<MemberBloc>(context).addMembers(widget.members);
  }
}
