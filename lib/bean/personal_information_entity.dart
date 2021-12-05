///
/// personal_information_entity
///
/// created by DZDcyj at 2021/12/5
///
import 'dart:convert';

import 'package:xianren_app/page/login_page/view_model/register_page_provider.dart';
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
    birthday = DateTime.fromMillisecondsSinceEpoch(json['birthday']);
    hideBirthday = (json['boolHideBirthday'] ?? 0) == 1;
    gender = _transferStringToGender(json['gender']);
    idNumber = json['idNumber'];
    nickName = json['nickName'];
    phoneNumber = json['phoneNumber'];
    realName = json['realName'];
    studentNumber = json['studentNumber'];
  }

  Gender _transferStringToGender(String value) {
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

  UserInformationEntity.fromJson(Map<String, dynamic> jsonData) {
    Map<String, dynamic> jsonUbi = (jsonData['ubi'] is String ? json.decode(jsonData['ubi']) : jsonData['ubi']);
    Map<String, dynamic> jsonUa = (jsonData['ua'] is String ? json.decode(jsonData['ua']) : jsonData['ua']);
    ubi = UserBasicInformationEntity.fromJson(jsonUbi);
    ua = UserAnonymousEntity.fromJson(jsonUa);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'ua': ua.toJson(),
      'ubi': ubi.toJson(),
    };
  }
}
