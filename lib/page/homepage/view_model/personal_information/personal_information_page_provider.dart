///
/// personal_information_page_provider
///
/// created by DZDcyj at 2021/12/4
///
import 'package:dartin/dartin.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xianren_app/base/view_model/base_page_view_provider.dart';
import 'package:xianren_app/bean/bean.dart';
import 'package:xianren_app/constants/constants.dart';
import 'package:xianren_app/utils/global_util.dart';
import 'package:xianren_app/utils/net_util.dart';

class PersonalInformationPageProvider extends BasePageProvider {
  NetUtil netUtil = inject();

  int refreshTimestamp;

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

  String get anonymous => _anonymous ?? '匿名者';

  set anonymous(String value) {
    _anonymous = value;
    notifyListeners();
  }

  Gender gender = Gender.unknown;

  /// 注销
  Future<void> logout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool(autoLoginKey, false);
  }

  /// 获取信息
  void getAllInformation({
    void Function() onSessionInvalid,
    void Function() onStart,
    void Function() onFinished,
    void Function(dynamic data) onError,
    bool refresh = false,
  }) {
    if (refresh || Global.userInformationEntity == null) {
      onStart?.call();
      asyncRequest(
        netUtil.getAllInfo(),
        cancelOnError: true,
        onData: (response) {
          if (response.code == responseOK) {
            updateUserInfo(response.data);
          } else if (response.code == responseSessionInvalid) {
            onSessionInvalid?.call();
          } else {
            onError?.call(response);
          }
          onFinished?.call();
        },
      );
    } else {
      onStart?.call();
      updateUserInfo(Global.userInformationEntity);
      onFinished?.call();
    }
  }

  /// 更新显示信息
  void updateUserInfo(UserInformationEntity entity) {
    Global.userInformationEntity = entity;
    nickname = entity.ubi.nickName;
    anonymous = entity.ua.anonymousName;
    phoneNumber = entity.ubi.phoneNumber;
    birthday = entity.ubi.birthday;
    hideBirthday = entity.ubi.hideBirthday;
    gender = entity.ubi.gender;
  }

  /// 修改匿名信息
  void modifyAnonymousName(
    String newValue, {
    void Function() onStart,
    void Function(String newValue) onSuccess,
    void Function(dynamic data) onFailed,
    void Function() onDone,
  }) {
    onStart?.call();
    asyncRequest(
      netUtil.modifyAnonymous({
        'phonenumber': phoneNumber,
        'anonymname': newValue,
      }),
      onData: (response) {
        if (response.code == responseOK) {
          onSuccess?.call(newValue);
        } else {
          onFailed?.call(response);
        }
        onDone?.call();
      },
    );
  }
}
