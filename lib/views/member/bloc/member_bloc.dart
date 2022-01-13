import 'package:education_helper/helpers/extensions/map_x.dart';
import 'package:education_helper/models/members.model.dart';
import 'package:education_helper/roots/miragate/http.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'member_state.dart';

class MemberBloc extends Cubit<MemberState> {
  final _restApi = RestApi();
  final String idClassrooms;

  final List<Member> members = [];

  MemberBloc(this.idClassrooms) : super(const MemberInitialState());
  String get path => '/members/$idClassrooms';

  Future<void> getMembers() async {
    emit(const MemberLoadingState());

    return await _structure(() async {
      final result = await _restApi.get(path).catchError(
        (error) {
          emit(MemberFailureState(error[error]));
          return null;
        },
      );
      if (result == null) return;
      emit(MemberLoadedState([]));
    });
  }

  Future<void> addMember({
    required String firstname,
    required String lastname,
    required String gender,
    String? phonenumber,
    String? birth,
    String? mail,
  }) async {
    // emit(const MemberLoadingState());
    return await _structure(() async {
      final vMember = Member(
        uid: '',
        firstName: firstname,
        lastName: lastname,
        gender: gender,
        mail: mail,
        phoneNumber: phonenumber,
        birth: birth,
      ).toJson().filterNull();
      final result = await _restApi.put(path, {
        'members': [vMember]
      }).catchError((err) {
        emit(MemberFailureState(err['error']));
        return null;
      });
      if (result == null) return;
      final member = Member.fromJson(result);
      members.add(member);

      emit(MemberCreateState(member));
    });
  }

  Future<void> _structure(Future<void> Function() handler) async {
    try {
      await handler();
    } catch (e) {
      debugPrint('[Members]:\t$e');
      emit(const MemberFailureState('Error systems'));
    }
  }
}
