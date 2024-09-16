import 'dart:convert';

extension StringExtension on String {
  String capitalized() {
    if (isEmpty) return '';
    return this[0].toUpperCase() + substring(1);
  }
}

extension StringIsJsonExtension on String {
  bool get isJson {
    try {
      jsonDecode(this);
    } catch (e) {
      return false;
    }
    return true;
  }
}
