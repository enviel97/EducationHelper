import 'package:education_helper/constants/constant.dart';
import 'package:education_helper/models/classroom.model.dart';
import 'package:education_helper/roots/miragate/http.dart';
import 'package:education_helper/views/home/bloc/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Cubit<HomeState> {
  late RestApi _restApi;
  List<Classroom> _classrooms = [];

  HomeBloc() : super(HomeInitialState()) {
    _restApi = RestApi();
  }

  Future<void> getClassCollection({
    String sortWith = 'updatedAt',
    bool isDesc = true,
  }) async {
    if (_classrooms.isNotEmpty) {
      return emit(HomeClassroomCollectionSuccessState(_classrooms));
    }
    emit(HomeLoadingState());
    return await _struct(() async {
      final sort = Helper(
        sorted: sortWith,
        direction: isDesc ? 'desc' : 'asc',
        limit: 10,
      );

      final result = await _restApi
          .get('classrooms/top', parametter: sort.toJson())
          .catchError((err) {
        emit(HomeFailureState(err['error']));
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
      emit(HomeClassroomCollectionSuccessState(classrooms));
    });
  }

  Future<void> _struct(Future<void> Function() handler) async {
    try {
      await handler();
    } catch (error) {
      debugPrint('[error home]: $error');
      emit(const HomeFailureState('Error system'));
    }
  }
}
