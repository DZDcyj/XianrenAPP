///
/// personal_information_page_provider
///
/// created by DZDcyj at 2021/12/4
///
import 'package:dartin/dartin.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xianren_app/base/view_model/base_page_view_provider.dart';
import 'package:xianren_app/bean/bean.dart';
import 'package:xianren_app/constants/constants.dart';
import 'package:xianren_app/utils/net_util.dart';

class PersonalInformationPageProvider extends BasePageProvider {
  NetUtil netUtil = inject();

  String _nickname;

  String get nickname => _nickname ?? 'Anonymous';

  set nickname(String value) {
    _nickname = value;
    notifyListeners();
  }

  String _phoneNumber;

  String get phoneNumber => _phoneNumber ?? '123456';

  set phoneNumber(String value) {
    _phoneNumber = value;
    notifyListeners();
  }

  DateTime _birthday;

  DateTime get birthday => _birthday ?? DateTime.now();

  set birthday(DateTime value) {
    _birthday = value;
    notifyListeners();
  }

  bool _hideBirthday;

  bool get hideBirthday => _hideBirthday ?? false;

  set hideBirthday(bool value) {
    _hideBirthday = value;
    notifyListeners();
  }

  String _anonymous;

  String get anonymous => _anonymous ?? '无';

  set anonymous(String value) {
    _anonymous = value;
    notifyListeners();
  }

  Future<void> logout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool(autoLoginKey, false);
  }

  void getAllInformation({
    void Function() onSessionInvalid,
    void Function() onStart,
    void Function() onFinished,
  }) {
    onStart?.call();
    asyncRequest(
      netUtil.getAllInfo(),
      cancelOnError: true,
      onData: (response) {
        if (response.code == responseOK) {
          updateUserInfo(response.data);
        } else if (response.code == responseSessionInvalid) {
          Fluttertoast.showToast(msg: '会话过期，请重新登陆！');
          onSessionInvalid?.call();
        } else {
          Fluttertoast.showToast(msg: '发生错误！(${response.code}');
        }
        onFinished?.call();
      },
    );
  }

  void updateUserInfo(UserInformationEntity entity) {
    nickname = entity.ubi.nickName;
    anonymous = entity.ua.anonymousName;
    phoneNumber = entity.ubi.phoneNumber;
    birthday = entity.ubi.birthday;
    hideBirthday = entity.ubi.hideBirthday;
  }
}
