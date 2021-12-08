///
/// personal_information_entity
///
/// created by DZDcyj at 2021/12/5
///
import 'package:intl/intl.dart';
import 'package:xianren_app/utils/global_util.dart';
import 'package:xianren_app/utils/string_util.dart';

import 'bean.dart';

/// 匿名信息实体
class UserAnonymousEntity implements ToJson {
  String anonymousName;
  String phoneNumber;

  @override
  Map<String, dynamic> toJson() {
    return {
      'anonymoName': anonymousName ?? '',
      'phoneNumber': phoneNumber ?? '',
    };
  }

  UserAnonymousEntity.fromJson(Map<String, dynamic> json) {
    anonymousName = json['anonymName'];
    phoneNumber = json['phoneNumber'];
  }
}

/// 基础信息实体
class UserBasicInformationEntity implements ToJson {
  DateTime birthday;
  bool hideBirthday;
  Gender gender;
  String idNumber;
  String nickName;
  String phoneNumber;
  String realName;
  String studentNumber;

  UserBasicInformationEntity.fromJson(Map<String, dynamic> json) {
    birthday = DateFormat('yyyy-MM-dd').parse(json['birthday'] ?? '1970-01-01');
    hideBirthday = (json['boolHideBirthday'] ?? 0) == 1;
    gender = transferStringToGender(json['gender']);
    idNumber = json['idNumber'];
    nickName = json['nickName'];
    phoneNumber = json['phoneNumber'];
    realName = json['realName'];
    studentNumber = json['studentNumber'];
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'birthday': transferDate(birthday ?? DateTime(1970)),
      'boolHideBirthday': hideBirthday ? 1 : 0,
      'gender': genderTranslation[gender ?? Gender.unknown],
      'idNumber': idNumber ?? '',
      'nickName': nickName ?? '',
      'phoneNumber': phoneNumber ?? '',
      'realName': realName ?? '',
      'studentNumber': studentNumber ?? '',
    };
  }
}

class UserInformationEntity implements ToJson {
  UserBasicInformationEntity ubi;
  UserAnonymousEntity ua;

  UserInformationEntity.fromJson(Map<String, dynamic> json) {
    if (json['ubi'] != null) {
      ubi = UserBasicInformationEntity.fromJson(json['ubi']);
    }
    if (json['ua'] != null) {
      ua = UserAnonymousEntity.fromJson(json['ua']);
    }
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'ua': ua.toJson(),
      'ubi': ubi.toJson(),
    };
  }
}
