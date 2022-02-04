extension MapX<K, V> on Map<K, V> {
  filterNull() {
    removeWhere((key, value) =>
        key == null || value == null || value == '' || value == []);
    return this;
  }
}
