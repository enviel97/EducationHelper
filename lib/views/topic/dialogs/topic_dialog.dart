import 'package:education_helper/views/topic/blocs/topic/topic_bloc.dart';
import 'package:education_helper/views/widgets/deorate/custom_confirm_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'topic_edit_form.dart';

const _raidus = BorderRadius.only(
  topLeft: Radius.circular(40.0),
  topRight: Radius.circular(40.0),
);

void editBottomSheet(
  BuildContext builder, {
  required String id,
  required DateTime expired,
  String? note,
}) {
  showModalBottomSheet(
    elevation: 1,
    context: builder,
    isScrollControlled: true,
    isDismissible: false,
    shape: const RoundedRectangleBorder(borderRadius: _raidus),
    builder: (_) {
      return BlocProvider.value(
        value: BlocProvider.of<TopicBloc>(builder),
        child: TopicEditForm(
          expired: expired,
          note: note ?? '',
        ),
      );
    },
  ).then((value) {
    if (value is Map<String, dynamic>) {
      BlocProvider.of<TopicBloc>(builder).edit(
        id,
        expiredDate: value['expiredDate'],
        note: value['note'] ?? '',
      );
    }
  });
}

void deleteTopic(
  BuildContext builder,
  String id,
  String name,
) {
  showDialog(
    context: builder,
    builder: (context) {
      return BlocProvider.value(
        value: BlocProvider.of<TopicBloc>(builder),
        child: KConfirmAlert(
          content: name,
          notice: 'You want to remove member: ',
          title: 'Delete Classrooms',
          onConfirm: () {
            BlocProvider.of<TopicBloc>(builder)
                .delete(id)
                .whenComplete(Navigator.of(context).pop);
          },
        ),
      );
    },
  );
}
