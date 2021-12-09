String? isNotEmpty(String? value) {
  return value == null || value.isEmpty ? 'This field is required' : null;
}

String? isEmail(String? value) {
  if (isNotEmpty(value) != null) return 'Email is not empty';
  const pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
  final regExp = RegExp(pattern);

  if (!regExp.hasMatch(value!)) {
    return 'Email invalid !';
  }
  return null;
}

String? isLength(String? value, {int? max, int? min}) {
  if (isNotEmpty(value) != null) return 'Field is not empty';
  if (max == null && min == null) {
    return throw Exception('This max or min is required ');
  }
  if (max != null || min != null) {
    if (max != null && value!.length > max) {
      return 'Your field required maximum character is $max';
    }
    if (min != null && value!.length < min) {
      return 'Your field required minimum character is $min';
    }
  }

  return null;
}

String? isPassword(String? value) {
  if (isNotEmpty(value) != null) return 'Password is not empty';

  // 1
  final hasUpper = RegExp(r'[A-Z]');
  final hasLower = RegExp(r'[a-z]');
  final hasDigit = RegExp(r'\d');
  final hasPunct = RegExp(r'[!@#\$&*~-]');
  // 2
  if (!RegExp(r'.{8,}').hasMatch(value!)) {
    return 'Passwords must have at least 8 characters';
  }
  // 3
  if (!hasUpper.hasMatch(value)) {
    return 'Passwords must have at least one uppercase character';
  }
  // 4
  if (!hasLower.hasMatch(value)) {
    return 'Passwords must have at least one lowercase character';
  }
  // 5
  if (!hasDigit.hasMatch(value)) {
    return 'Passwords must have at least one number';
  }
  // 6
  if (!hasPunct.hasMatch(value)) {
    return 'Passwords need at least one special character like !@#\$&*~-';
  }
  // 7
  return null;
}

String? isEqual(String? value, String? other) {
  if (value == null || other == null || value.isEmpty || other.isEmpty) {
    return 'May be once value is null';
  }

  if (value != other) {
    return 'Two field must be equal !';
  }
  return null;
}

String? isPhone(String? value) {
  if (value == null) {
    return 'Phone is not empty';
  }
  final phoneRex = RegExp(
      r'^\+?(((03)?[2-9])|(05?(6|8))|(07?(0|[6-9]))|(08?([1-6]|[8-9]))|(09?([0-4]|[7-8])))[0-9]{7}$');
  if (!phoneRex.hasMatch(value)) {
    return 'Invalid phone number';
  }
  return null;
}
