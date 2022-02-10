import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/helpers/extensions/build_context_x.dart';
import 'package:education_helper/helpers/extensions/state.x.dart';
import 'package:education_helper/helpers/ultils/funtions.dart';
import 'package:education_helper/models/topic.model.dart';
import 'package:education_helper/roots/app_root.dart';
import 'package:education_helper/roots/bloc/app_bloc.dart';
import 'package:education_helper/views/auth/adapter/auth.adapter.dart';
import 'package:education_helper/views/auth/bloc/auth_bloc.dart';
import 'package:education_helper/views/auth/bloc/auth_state.dart';
import 'package:education_helper/views/widgets/button/custom_icon_button.dart';
import 'package:education_helper/views/widgets/deorate/custom_confirm_alert.dart';
import 'package:education_helper/views/widgets/form/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class TopicForm extends StatefulWidget {
  const TopicForm({Key? key}) : super(key: key);

  @override
  State<TopicForm> createState() => _TopicFormState();
}

class _TopicFormState extends State<TopicForm> {
  String idTopic = '';

  @override
  void initState() {
    super.initState();
  }

  double get height => size.height * .8;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthGetAssignmentState) {
          BlocProvider.of<AppBloc>(context).hiddenLoading(context);
          _dialogConfirm(state.topic);
        }

        if (state is AuthErrorState) {
          BlocProvider.of<AppBloc>(context).hiddenLoading(context);
          BlocProvider.of<AppBloc>(context)
              .showError(context, state.error.mess);
        }
      },
      child: Align(
        alignment: Alignment.bottomCenter,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            width: size.width,
            height: height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  ImageFromLocal.asPng('student_welcome'),
                  width: size.width * .8,
                  fit: BoxFit.fitWidth,
                ),
                SPACING.XL.vertical,
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text.rich(
                      TextSpan(
                        text: 'You should input assginment id in this text. '
                            'If you want to create assigment, please click ',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: isLightTheme
                              ? kPlacehoderSuperDarkColor
                              : kPlaceholderDarkColor,
                        ),
                        children: [
                          TextSpan(
                              text: 'SIGN IN at top-right',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: isLightTheme
                                    ? kSecondaryDarkColor
                                    : kSecondaryLightColor,
                                fontWeight: FontWeight.bold,
                              )),
                          const TextSpan(
                            text: ' screens or swipe to right',
                          )
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SPACING.S.vertical,
                    const Text(
                      'ASSIGMENT: ',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SPACING.S.vertical,

                    KTextField(
                      iconData: Icons.topic,
                      hintText: 'Enter id assignment here ...',
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      onChange: (value) => idTopic = value,
                      onSubmit: _goToTopic,
                    ),
                    // KTextField(
                    //   iconData: Icons.lock_rounded,
                    //   hintText: 'Password',
                    //   isSecurity: true,
                    //   textInputAction: TextInputAction.done,
                    //   onChange: (value) => password = value,
                    //   onSubmit: _submit,
                    // )
                  ],
                ),
                SPACING.M.vertical,
                SizedBox(
                  width: size.width * .52,
                  child: KIconButton(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 8.0),
                    icon: const Icon(Entypo.documents, color: kWhiteColor),
                    onPressed: () => _goToTopic(idTopic),
                    text: 'GET ASSIGMENT',
                  ),
                ),
                SPACING.M.vertical,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _goToTopic(String id) async {
    context.disableKeyBoard();
    if (id.isEmpty || idTopic.isEmpty) {
      return;
    }
    BlocProvider.of<AppBloc>(context).showLoading(context, 'Checking');
    await BlocProvider.of<AuthBloc>(context).checkId(idTopic);
  }

  void _dialogConfirm(Topic topic) async {
    final isConfirm = await showDialog<bool>(
        context: context,
        builder: (_) {
          return KConfirmAlert(
            onConfirm: () => Navigator.maybePop(context, true),
            title: 'Confirm',
            notice: 'For member of classroom: '
                '\nClassname: ${topic.classroom.name}',
            content: '\nAsignment: ${topic.exam.name}',
          );
        });
    if (isConfirm ?? false) {
      final adapter =
          Root.ins.adapter.getAdapter(authAdapter).cast<AuthAdpater>();
      adapter.gotoTopic(context, topic.id);
    }
  }
}
