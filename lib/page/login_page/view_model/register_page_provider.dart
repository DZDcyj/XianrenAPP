///
/// register_page_provider
///
/// created by DZDcyj at 2021/11/29
///
import 'package:dartin/dartin.dart';
import 'package:xianren_app/base/view_model/base_page_view_provider.dart';
import 'package:xianren_app/utils/global_util.dart';
import 'package:xianren_app/utils/net_util.dart';
import 'package:xianren_app/utils/regex_util.dart';
import 'package:xianren_app/utils/string_util.dart';

class RegisterPageProvider extends BasePageProvider {
  NetUtil _netUtil = inject();

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

  DateTime _birthday;

  DateTime get birthday => _birthday ?? DateTime.now();

  set birthday(DateTime value) {
    _birthday = value;
    notifyListeners();
  }

  bool _birthdayHidden;

  bool get birthdayHidden => _birthdayHidden ?? false;

  set birthdayHidden(bool value) {
    _birthdayHidden = value;
    notifyListeners();
  }

  /// 验证用信息：邮件、真实姓名、学号、身份证号
  String phone;
  String realName;
  String studentId;
  String idNumber;

  /// 注册信息：密码
  String password;

  /// 验证输入数据
  bool validateInformation({
    void Function(dynamic msg) onError,
  }) {
    if (nickName.isEmpty ||
        (phone?.isEmpty ?? true) ||
        (password?.isEmpty ?? true) ||
        (realName?.isEmpty ?? true) ||
        (idNumber?.isEmpty ?? true) ||
        (studentId?.isEmpty ?? true)) {
      onError?.call('部分信息不完整');
      return false;
    }

    if (!validatePassword(password)) {
      onError?.call('密码不符合要求');
      return false;
    }

    if (!validatePhoneNumber(phone)) {
      onError?.call('手机号不合法');
      return false;
    }

    if (!validateIdNumber(idNumber)) {
      onError?.call('身份证号不合法');
      return false;
    }

    return true;
  }

  Map<String, dynamic> constructPostData() {
    return {
      'phonenumber': phone,
      'gender': genderTranslation[gender],
      'password': password,
      'birthday': transferDate(birthday),
      'nickname': nickName,
      'realname': realName,
      'idnumber': idNumber,
      'studentnumber': studentId,
      'boolhidebirthday': birthdayHidden ? 1 : 0,
    };
  }

  Future<void> doRegister({
    void Function(dynamic data) onData,
    void Function() onStart,
    void Function() onDone,
  }) async {
    onStart?.call();
    asyncRequest(
      _netUtil.register(constructPostData()),
      onData: onData,
      onDone: onDone,
    );
  }
}
