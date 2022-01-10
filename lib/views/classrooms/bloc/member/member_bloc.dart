import 'package:education_helper/views/classrooms/bloc/member/member_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MemberBloc extends Cubit<MemberState> {
  MemberBloc() : super(MemberInitialState());
}
