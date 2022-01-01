import 'package:flutter/material.dart';

abstract class IAdapter {
  Widget layout();
  T as<T>() => this as T;
}
