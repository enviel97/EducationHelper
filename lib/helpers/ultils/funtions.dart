class ImageFromLocal {
  ImageFromLocal._();
  static const _dir = 'assets/images/';
  static String asSvg(String name) => '$_dir$name.svg';
  static String asPng(String name) => '$_dir$name.png';
}

String getLastName(String name) {
  final nameSplit = name.split(' ');
  final firstCharacterName =
      (nameSplit.length > 1 ? nameSplit[nameSplit.length - 2][0] : '') +
          nameSplit[nameSplit.length - 1][0];
  return firstCharacterName.toUpperCase();
}

String quantity(int quantity, String ext) {
  final String extention = ' $ext${quantity > 1 ? 's' : ''}';
  return '$quantity $extention';
}

List<T> mapToList<T>(dynamic json, T Function(dynamic json) create) {
  if (json == null || json.isEmpty) {
    return [];
  }
  final jsons = json as List;
  return List<T>.generate(jsons.length, (index) => create(jsons[index]));
}

T mapToModel<T>(dynamic json, T Function(dynamic json) create) {
  if (json == null || json.isEmpty || json is String) {
    return create({'id': json ?? ''});
  }
  return create(json);
}
