///
/// global_util
///
/// created by DZDcyj at 2021/12/7
///
import 'package:xianren_app/bean/bean.dart';

class Global {
  Global._internal();

  static UserInformationEntity userInformationEntity;
}

/// 性别选项
enum Gender {
  unknown, // 未设置
  male, // 男
  female, // 女
  secret, // 保密
}

Map<Gender, String> genderTranslation = {
  Gender.unknown: '未知',
  Gender.male: '男',
  Gender.female: '女',
  Gender.secret: '不便透露',
};
