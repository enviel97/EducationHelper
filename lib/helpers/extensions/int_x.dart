extension IntX on int {
  String get str => this < 10 ? '0$this' : '$this';
}
