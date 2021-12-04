///
/// string_util
///
/// created by DZDcyj at 2021/12/4
///

/// 转换日期为 yyyy-mm-dd 格式
String transferDate(DateTime dateTime) {
  String monthPart = dateTime.month < 10 ? '0${dateTime.month}' : '${dateTime.month}';
  String dayPart = dateTime.day < 10 ? '0${dateTime.day}' : '${dateTime.day}';
  return '${dateTime.year}-$monthPart-$dayPart';
}
