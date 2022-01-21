import 'package:education_helper/constants/constant.dart';
import 'package:education_helper/models/classroom.model.dart';
import 'package:education_helper/models/exam.model.dart';
import 'package:education_helper/roots/miragate/http.dart';
import 'package:education_helper/views/home/bloc/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum RefreshEvent { classroom, exam, all }

class HomeBloc extends Cubit<HomeState> {
  late RestApi _restApi;

  HomeBloc() : super(HomeInitialState()) {
    _restApi = RestApi();
  }

  Future<void> refreshCollections(RefreshEvent refresh) async {
    switch (refresh) {
      case RefreshEvent.classroom:
        return await getClassCollection();
      case RefreshEvent.exam:
        return await getExamCollection();
      case RefreshEvent.all:
        await Future.wait([getExamCollection(), getExamCollection()]);
        return;
    }
  }

  Future<void> getClassCollection() async {
    emit(const ClassroomLoadingState());
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
      emit(ClassroomLoadedState(classrooms));
    });
  }

  Future<void> getExamCollection() async {
    emit(const ExamLoadingState());
    return await _struct(
      () async {
        final sort = Helper(
          sorted: 'updatedAt',
          direction: 'desc',
          limit: 10,
        );

        final result = await _restApi
            .get('exams/top', parametter: sort.toJson())
            .catchError((err) {
          emit(HomeFailureState(err['error']));
          return null;
        });
        if (result == null) return;
        final List<Exam> exams;
        if ((result?.length ?? 0) == 0) {
          exams = [];
        } else {
          exams = List<Exam>.generate(
              result.length, (index) => Exam.fromJson(result[index]));
        }
        emit(ExamLoadedState(exams));
      },
    );
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
