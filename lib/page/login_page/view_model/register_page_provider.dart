///
/// register_page_provider
///
/// created by DZDcyj at 2021/11/29
///
import 'package:xianren_app/base/view_model/base_page_view_provider.dart';

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

class RegisterPageProvider extends BasePageProvider {
  /// 个人信息：昵称、性别、生日
  String _nickName;

  String get nickName => _nickName ?? '';

  set nickName(String value) {
    _nickName = value;
    notifyListeners();
  }

  Gender _gender;

  Gender get gender => _gender ?? Gender.unknown;

  set gender(Gender value) {
    _gender = value;
    notifyListeners();
  }

  DateTime birthday;

  /// 验证用信息：邮件、真实姓名、学号、身份证号
  String email;
  String realName;
  String studentId;
  String idNumber;

  /// 注册信息：密码
  String password;

  /// 验证输入数据
  void validateInformation() {
    // TODO: 验证数据合法性
  }
}