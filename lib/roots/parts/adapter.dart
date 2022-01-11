import 'package:flutter/material.dart';

abstract class IAdapter {
  Widget layout({Map<String, dynamic>? params});
  T as<T>() => this as T;
}
