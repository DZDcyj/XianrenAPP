///
/// string_util
///
/// created by DZDcyj at 2021/12/4
///
import 'package:intl/intl.dart';

import 'global_util.dart';

/// 转换日期为 yyyy-mm-dd 格式
String transferDate(DateTime dateTime) {
  return DateFormat('yyyy-MM-dd').format(dateTime);
}

Gender transferStringToGender(String value) {
  switch (value) {
    case '男':
      return Gender.male;
    case '女':
      return Gender.female;
    case '不便透露':
      return Gender.secret;
    default:
      return Gender.unknown;
  }
}
