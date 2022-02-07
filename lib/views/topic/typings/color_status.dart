import 'package:education_helper/models/answer.model.dart';
import 'package:flutter/material.dart';

Color getStatusColor(StatusAnswer type) {
  switch (type) {
    case StatusAnswer.submit:
      return const Color(0xFF60FF66);
    case StatusAnswer.lated:
      return const Color(0xFFFFEF60);
    case StatusAnswer.empty:
      return const Color(0xFFFF6060);
  }
}
