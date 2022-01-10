import 'package:equatable/equatable.dart';

abstract class MemberState extends Equatable {
  const MemberState();
}

class MemberInitialState extends MemberState {
  @override
  List<Object?> get props => [];
}

class MemberLoadingState extends MemberState {
  @override
  List<Object?> get props => [];
}
