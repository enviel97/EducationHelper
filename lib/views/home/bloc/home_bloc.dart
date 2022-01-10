import 'package:education_helper/constants/constant.dart';
import 'package:education_helper/models/classroom.model.dart';
import 'package:education_helper/roots/miragate/http.dart';
import 'package:education_helper/views/home/bloc/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Cubit<HomeState> {
  late RestApi _restApi;

  HomeBloc() : super(HomeInitialState()) {
    _restApi = RestApi();
  }

  Future<void> refreshClassroomCollection() async {
    return await getClassCollection();
  }

  Future<void> getClassCollection() async {
    emit(HomeLoadingState());
    return await _struct(() async {
      final sort = Helper(
        sorted: 'updatedAt',
        direction: 'desc',
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
      }
      emit(HClassCollectionSuccessState(classrooms));
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
