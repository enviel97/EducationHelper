import 'package:education_helper/helpers/extensions/map_x.dart';
import 'package:education_helper/models/members.model.dart';
import 'package:education_helper/roots/miragate/http.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'member_state.dart';

class MemberBloc extends Cubit<MemberState> {
  final _restApi = RestApi();
  final String idClassrooms;

  List<Member> _members = [];

  MemberBloc(this.idClassrooms) : super(const MemberInitialState());

  Future<void> refreshMembers() async {
    await getMembers();
  }

  Future<void> getMembers() async {
    emit(const MemberLoadingState());

    return await _structure(() async {
      final result = await _restApi.get('/members/$idClassrooms').catchError(
        (error) {
          emit(MemberFailureState(error[error]));
          return null;
        },
      );
      if (result == null) return;
      final List<dynamic> members = result['members'] ?? [];
      _members.addAll(List<Member>.generate(
          members.length, (i) => Member.fromJson(members[i])));
      notificationChanged();
    });
  }

  Future<void> addMembers(List<Member> members) async {
    emit(const MemberLoadingState());

    return await _structure(() async {
      final result = await _restApi.put(
          '/members/create/$idClassrooms', {'members': members}).catchError(
        (error) {
          emit(MemberFailureState(error[error]));
          return null;
        },
      );
      if (result == null) return;

      notificationChanged();
    });
  }

  Future<void> addMember(Member vMember) async {
    return await _structure(() async {
      final result = await _restApi
          .put('/members/create/$idClassrooms', vMember.toJson().filterNull())
          .catchError((err) {
        emit(MemberFailureState(err['error']));
        return null;
      });
      if (result == null) return;
      final member = Member.fromJson(result);
      _members.add(member);
      emit(MemberCreateState(member));
      notificationChanged();
    });
  }

  Future<void> editMember(Member member) async {
    return await _structure(() async {
      final result = await _restApi
          .put('/members/update/${member.uid}', member.toJson().filterNull())
          .catchError((err) {
        emit(MemberFailureState(err['error']));
        return null;
      });

      if (result == null) return;
      final index = _members.indexWhere((m) => m.uid == member.uid);
      if (index > -1) {
        _members[index] = member;
      }

      emit(MemberEditSuccessState(member));
      notificationChanged();
    });
  }

  Future<void> deleteMember(String members) async {
    return await _structure(() async {
      final result = await _restApi
          .delete(
        '/members/$members',
      )
          .catchError((err) {
        emit(MemberFailureState(err['error']));
        return null;
      });

      if (result == null) return;
      final member = Member.fromJson(result);
      _members = _members.where((m) => m.uid != member.uid).toList();
      emit(MemberDeleteSuccessState(member));
      notificationChanged();
    });
  }

  void notificationChanged() {
    emit(MemberLoadedState(_members));
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
