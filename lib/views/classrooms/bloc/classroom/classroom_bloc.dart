import 'package:education_helper/constants/constant.dart';
import 'package:education_helper/models/classroom.model.dart';
import 'package:education_helper/roots/miragate/http.dart';
import 'package:education_helper/views/classrooms/bloc/classroom/classroom_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClassroomBloc extends Cubit<ClassroomState> {
  final _path = '/classrooms';
  late RestApi _restApi;

  /// store
  List<Classroom>? _classrooms;
  List<Classroom>? _classroomCollection;

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
      if (_classrooms != null) {
        _classrooms!.add(classroom);
      } else {
        _classrooms = [classroom];
      }
      emit(ClassroomCreateSuccessState(classroom));
    });
  }

  Future<void> getClassroomCollection({
    String sortWith = 'updatedAt',
    bool isDesc = true,
  }) async {
    if (_classroomCollection != null) {
      return emit(ClassroomCollectionState(_classroomCollection!));
    }
    emit(ClassroomLoadingState());
    return await _struct(() async {
      final sort =
          SortedHelper(sorted: sortWith, direction: isDesc ? 'desc' : 'asc');

      final result = await _restApi
          .get(_path, parametter: sort.toJson())
          .catchError((err) {
        emit(ClassroomFailureState(err['error']));
        return null;
      });
      if (result == null) return;
      final List<Classroom> classrooms;
      if ((result?.length ?? 0) == 0) {
        classrooms = [];
      } else {
        classrooms = List<Classroom>.generate(
            result.length, (index) => Classroom.fromJson(result[index]));
        _classroomCollection = classrooms;
      }

      emit(ClassroomCollectionState(classrooms));
    });
  }

  Future<void> getAllClassrooms({
    String sortWith = 'updatedAt',
    bool isDesc = true,
  }) async {
    if (_classrooms != null) {
      return emit(ClassroomGetAllSuccessState(_classrooms!));
    }
    emit(ClassroomLoadingState());
    return await _struct(() async {
      final sort =
          SortedHelper(sorted: sortWith, direction: isDesc ? 'desc' : 'asc');

      final result = await _restApi
          .get(_path, parametter: sort.toJson())
          .catchError((err) {
        emit(ClassroomFailureState(err['error']));
        return null;
      });
      if (result == null) return;
      final List<Classroom> classrooms;
      if ((result?.length ?? 0) == 0) {
        classrooms = [];
      } else {
        classrooms = List<Classroom>.generate(
            result.length, (index) => Classroom.fromJson(result[index]));
        _classrooms = classrooms;
      }

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

  Future<void> editClassroom(String id, String name) async {
    return await _struct(() async {
      final result = await _restApi.get('$_path/update/$id').catchError((err) {
        emit(ClassroomFailureState(err['error']));
        return null;
      });
      if (result == null) return;
      final classroom = Classroom.fromJson(result);
      emit(ClassroomGetSuccessState(classroom));
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
      emit(ClassroomDeleteSuccessState(classroom));
    });
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
