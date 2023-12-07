import 'dart:convert';

class globalVar{
  static String utf8convert(String newsTitle) {
    List<int> bytes = newsTitle.toString().codeUnits;
    return utf8.decode(bytes);
  }
}