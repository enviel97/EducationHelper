import 'package:education_helper/constants/constant.dart';
import 'package:education_helper/models/exam.model.dart';
import 'package:education_helper/roots/miragate/http.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'exam.state.dart';

class ExamsBloc extends Cubit<ExamState> {
  late RestApi _restApi;
  ExamsBloc() : super(const ExamInitialState()) {
    _restApi = RestApi();
  }

  Future<void> refresh() async {
    await getExamCollection();
  }

  Future<void> getExamCollection() async {
    emit(const ExamLoadingState());
    final sort = Helper(
      sorted: 'updatedAt',
      direction: 'desc',
      limit: 10,
    );

    final result = await _restApi
        .get('exams/top', parametter: sort.toJson())
        .catchError((err) {
      emit(ExamFailState(Messenger(err['error'])));
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
  }
}
