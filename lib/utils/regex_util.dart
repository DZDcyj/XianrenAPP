///
/// regex_util
///
/// created by DZDcyj at 2021/11/29
///

//将前17位加权因子保存在数组里
final List<String> idCardList = ['7', '9', '10', '5', '8', '4', '2', '1', '6', '3', '7', '9', '10', '5', '8', '4', '2'];
//这是除以11后，可能产生的11位余数、验证码，也保存成数组
final List<String> idCardYArray = ['1', '0', '10', '9', '8', '7', '6', '5', '4', '3', '2'];

/// 验证手机号合法性
bool validatePhoneNumber(String number) {
  RegExp mobile = RegExp(r'1[0-9]\d{9}$');
  return mobile.hasMatch(number);
}

/// 验证邮箱合法性
bool validateEmail(String email) {
  RegExp emailExp = RegExp(r'^[a-z0-9A-Z]+[- | a-z0-9A-Z . _]+@([a-z0-9A-Z]+(-[a-z0-9A-Z]+)?\.)+[a-z]{2,}$');
  return emailExp.hasMatch(email);
}

/// 验证身份证号合法性
bool validateIdNumber(String idNumber) {
  if (idNumber.length != 18) {
    return false; // 位数不够
  }
  // 身份证号码正则
  RegExp postalCode = RegExp(r'^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}([0-9]|[Xx])$');
  // 通过验证，说明格式正确，但仍需计算准确性
  if (!postalCode.hasMatch(idNumber)) {
    return false;
  }

  // 前17位各自乖以加权因子后的总和
  int idCardWiSum = 0;

  for (int i = 0; i < 17; i++) {
    int subStrIndex = int.parse(idNumber.substring(i, i + 1));
    int idCardWiIndex = int.parse(idCardList[i]);
    idCardWiSum += subStrIndex * idCardWiIndex;
  }
  // 计算出校验码所在数组的位置
  int idCardMod = idCardWiSum % 11;
  // 得到最后一位号码
  String idCardLast = idNumber.substring(17, 18);
  //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
  if (idCardMod == 2) {
    if (idCardLast != 'x' && idCardLast != 'X') {
      return false;
    }
  } else {
    //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
    if (idCardLast != idCardYArray[idCardMod]) {
      return false;
    }
  }
  return true;
}
