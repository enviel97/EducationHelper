import 'package:education_helper/models/members.model.dart';
import 'package:equatable/equatable.dart';

abstract class MemberState extends Equatable {
  const MemberState();
}

class MemberInitialState extends MemberState {
  const MemberInitialState();

  @override
  List<Object?> get props => [];
}

class MemberLoadingState extends MemberState {
  const MemberLoadingState();

  @override
  List<Object?> get props => [];
}

class MemberLoadedState extends MemberState {
  final List<Member> members;
  final String clasroomName;
  final List<String> exams;

  const MemberLoadedState(
    this.members,
    this.clasroomName,
    this.exams,
  );

  @override
  List<Object?> get props => [members, clasroomName, exams];
}

class MemberCreateState extends MemberState {
  final Member member;

  const MemberCreateState(this.member);

  @override
  List<Object?> get props => [member];
}

class MemberFailureState extends MemberState {
  final String messenger;

  const MemberFailureState(this.messenger);

  @override
  List<Object?> get props => [messenger];
}
