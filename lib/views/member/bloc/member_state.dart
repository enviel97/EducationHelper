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
  const MemberLoadedState(
    this.members,
  );

  @override
  List<Object?> get props => [members];
}

class MemberCreateState extends MemberState {
  final Member member;

  const MemberCreateState(this.member);

  @override
  List<Object?> get props => [member];
}

class MembersCreateState extends MemberState {
  final List<Member> members;

  const MembersCreateState(this.members);

  @override
  List<Object?> get props => [members];
}

class MemberFailureState extends MemberState {
  final String messenger;

  const MemberFailureState(this.messenger);

  @override
  List<Object?> get props => [messenger];
}

class MemberEditSuccessState extends MemberState {
  final Member member;

  const MemberEditSuccessState(this.member);

  @override
  List<Object?> get props => [member];
}

class MemberDeleteSuccessState extends MemberState {
  final Member member;

  const MemberDeleteSuccessState(this.member);

  @override
  List<Object?> get props => [member];
}
