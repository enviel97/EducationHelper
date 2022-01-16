import 'package:flutter/material.dart';

abstract class IAdapter {
  Widget layout({Map<String, dynamic>? params});
  T cast<T>() {
    if (this is T) return this as T;
    throw Exception('Error cass to adapter ${T.toString()}');
  }
}
