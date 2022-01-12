import 'package:education_helper/helpers/ultils/validation.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'datetime_x.dart';

final phoneMask = MaskTextInputFormatter(
  mask: '+# (###) ###-##-##',
  filter: {'#': RegExp(r'[0-9]')},
);

extension StringX on String {
  String toPhone() {
    if (isPhone(this) != null) {
      return '(###)-###-####';
    }
    final regex = RegExp(r'(\d{3})(\d{3})(\d+)');
    final str = this;
    return str.replaceAllMapped(
      regex,
      (Match m) => '(${m[1]})-${m[2]}-${m[3]}',
    );
  }

  String toDateString({String format = 'dd/MM/yyyy'}) {
    final date = DateTime.tryParse(this);
    if (date == null) return format;
    return date.toStringFormat(format: format);
  }
}
