import 'package:education_helper/constants/constant.dart';
import 'package:education_helper/models/classroom.model.dart';
import 'package:education_helper/roots/miragate/http.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'classroom_state.dart';

class ClassroomBloc extends Cubit<ClassroomState> {
  final _path = '/classrooms';
  late RestApi _restApi;

  /// store
  List<Classroom> restoreFull = [];
  List<Classroom> classrooms = [];

  ClassroomBloc() : super(ClassroomInitialState()) {
    _restApi = RestApi();
  }

  Future<void> createClassroom(String name) async {
    return await _struct(() async {
      final result = await _restApi
          .post('$_path/create', {'name': name}).catchError((err) {
        emit(ClassroomFailureState(err['error']));
        return null;
      });
      if (result == null) return;
      final classroom = Classroom.fromJson(result);
      classrooms.add(classroom);
      emit(ClassroomCreateSuccessState(classroom));
    });
  }

  Future<void> editClassroom(String id, String name) async {
    return await _struct(() async {
      final result = await _restApi.put(
        '$_path/update/$id',
        {'name': name},
      ).catchError((err) {
        emit(ClassroomFailureState(err['error']));
        return null;
      });
      if (result == null) return;
      final classroom = Classroom.fromJson(result);
      emit(ClassroomEditSuccessState(classroom));
      classrooms[classrooms.indexWhere((c) => c.id == classroom.id)] =
          classroom;
    });
  }

  Future<void> deleteClassroom(String id) async {
    return await _struct(() async {
      final result = await _restApi.delete('$_path/$id').catchError((err) {
        emit(ClassroomFailureState(err['error']));
        return null;
      });
      if (result == null) return;
      final classroom = Classroom.fromJson(result);
      classrooms = classrooms;
      classrooms = classrooms.where((c) => c.id != id).toList();
      emit(ClassroomDeleteSuccessState(classroom));
    });
  }

  // get
  Future<void> searchClassroom(String value) async {
    if (value.isEmpty) {
      return await getListClassroom();
    }
    emit(ClassroomLoadingState());
    return await _struct(() async {
      final sort = Helper(sorted: 'name', direction: 'desc', query: value);

      final result = await _restApi
          .get('$_path/search', parametter: sort.toJson())
          .catchError((err) {
        emit(ClassroomFailureState(err['error']));
        return null;
      });
      if (result == null) return;
      classrooms = mapJsonToList(result);
      emit(ClassroomGetAllSuccessState(classrooms));
    });
  }

  Future<void> refreshClassroom() async {
    await getListClassroom();
  }

  Future<void> getListClassroom() async {
    emit(ClassroomLoadingState());
    return await _struct(() async {
      final sort = Helper(sorted: 'name', direction: 'desc');
      final result = await _restApi
          .get(_path, parametter: sort.toJson())
          .catchError((err) {
        emit(ClassroomFailureState(err['error']));
        return null;
      });
      if (result == null) return;
      classrooms = mapJsonToList(result);
      emit(ClassroomGetAllSuccessState(classrooms));
    });
  }

  Future<void> getClassroom(String id) async {
    emit(ClassroomLoadingState());
    return await _struct(() async {
      final result = await _restApi.get('$_path/$id').catchError((err) {
        emit(ClassroomFailureState(err['error']));
        return null;
      });
      if (result == null) return;
      final classroom = Classroom.fromJson(result);
      emit(ClassroomGetSuccessState(classroom));
    });
  }

  // helper

  List<Classroom> mapJsonToList(dynamic result) {
    try {
      final List<Classroom> classrooms;
      if ((result?.length ?? 0) == 0) {
        classrooms = [];
      } else {
        classrooms = List<Classroom>.generate(
          result.length,
          (index) => Classroom.fromJson(
            result[index],
          ),
        );
      }
      return classrooms;
    } catch (error) {
      debugPrint('[Classroom]: map list error');
      return [];
    }
  }

  Future<void> _struct(Future<void> Function() handler) async {
    try {
      await handler();
    } catch (error) {
      debugPrint('[error $_path]: $error');
      emit(const ClassroomFailureState('Error system'));
    }
  }
}
