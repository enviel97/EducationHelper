import 'package:education_helper/constants/constant.dart';
import 'package:education_helper/models/classroom.model.dart';
import 'package:education_helper/roots/miragate/http.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'classroom.state.dart';

class ClassroomsBloc extends Cubit<ClassroomState> {
  late RestApi _restApi;
  ClassroomsBloc() : super(const ClassroomInitialState()) {
    _restApi = RestApi();
  }

  Future<void> refresh() async {
    await getClassCollection();
  }

  Future<void> getClassCollection() async {
    emit(const ClassroomLoadingState());
    final sort = Helper(
      sorted: 'updatedAt',
      direction: 'desc',
      limit: 10,
    );

    final result = await _restApi
        .get('classrooms/top', parametter: sort.toJson())
        .catchError((err) {
      emit(ClassroomFailState(err['error']));
      return null;
    });
    if (result == null) return;
    final List<Classroom> classrooms;
    if ((result?.length ?? 0) == 0) {
      classrooms = [];
    } else {
      classrooms = List<Classroom>.generate(
          result.length, (index) => Classroom.fromJson(result[index]));
    }
    emit(ClassroomLoadedState(classrooms));
  }
}
