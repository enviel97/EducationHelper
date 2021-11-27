// ignore_for_file: avoid_classes_with_only_static_members
enum ImageExe { svg, png }

class Image {
  static get fromLocalSvg {
    const dir = 'assets/images/';
    return {
      'svg': (name) => '$dir$name.svg',
    };
  }

  static get fromLocalPng {
    const dir = 'assets/images/';
    return {
      'svg': (name) => '$dir$name.svg',
    };
  }
}
