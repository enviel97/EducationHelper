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
