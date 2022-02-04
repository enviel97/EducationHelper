extension ListX<T> on List<T> {
  void push(T element) {
    return insert(0, element);
  }
}
