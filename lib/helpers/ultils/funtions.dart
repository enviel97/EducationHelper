class ImageFromLocal {
  ImageFromLocal._();
  static const _dir = 'assets/images/';
  static String asSvg(String name) => '$_dir$name.svg';
  static String asPng(String name) => '$_dir$name.png';
}
