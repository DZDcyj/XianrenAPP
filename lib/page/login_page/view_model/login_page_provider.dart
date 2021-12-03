///
/// login_page_provider
///
/// created by DZDcyj at 2021/11/28
///
import 'package:dartin/dartin.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xianren_app/base/view_model/base_page_view_provider.dart';
import 'package:xianren_app/constants/constants.dart';
import 'package:xianren_app/utils/net_util.dart';

String usernameKey = 'username';
String passwordKey = 'password';
String autoInputKey = 'autoInput';
String autoLoginKey = 'autoLogin';

class LoginPageProvider extends BasePageProvider {
  /// 是否启用记住用户名密码
  bool _autoInput;

  NetUtil _netUtil = inject();

  bool get autoInput => _autoInput ?? false;

  set autoInput(bool value) {
    _autoInput = value;
    notifyListeners();
  }

  /// 是否启用自动登录，需要记住用户名密码
  bool _autoLogin;

  bool get autoLogin => _autoLogin ?? false;

  set autoLogin(bool value) {
    _autoLogin = value;
    notifyListeners();
  }

  String _username;

  String get username => _username ?? '';

  set username(String value) {
    _username = value;
    notifyListeners();
  }

  String _password;

  String get password => _password ?? '';

  set password(String value) {
    _password = value;
    notifyListeners();
  }

  /// 从数据库载入保存的密码
  Future<void> loadInfoFromPreferences() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    username = preferences.getString(usernameKey) ?? '';
    password = preferences.getString(passwordKey) ?? '';
  }

  /// 向数据库保存用户名密码
  Future<void> saveInfoToPreferences() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool(autoLoginKey, autoLogin);
    await preferences.setBool(autoInputKey, autoInput);
    await preferences.setString(usernameKey, autoInput ? username : '');
    await preferences.setString(passwordKey, autoInput ? password : '');
  }

  /// 清空数据库中已有信息
  Future<void> clearInfoFromPreferences() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove(usernameKey);
    await preferences.remove(passwordKey);
    await preferences.remove(autoInputKey);
    await preferences.remove(autoLoginKey);
  }

  /// 初始化
  Future<void> initialize() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    autoInput = preferences.getBool(autoInputKey) ?? false;
    if (autoInput) {
      autoLogin = preferences.getBool(autoLoginKey) ?? false;
      await loadInfoFromPreferences();
    }
  }

  /// 登录
  Future<void> doLogin(void Function() callback) async {
    if (autoInput) {
      saveInfoToPreferences();
    } else {
      clearInfoFromPreferences();
    }
    asyncRequest(
      _netUtil.login(username, password),
      onData: (response) {
        if (response.code == httpResponseOK) {
          callback?.call();
        } else {
          Fluttertoast.showToast(msg: '发生错误！错误信息：${response.msg} (${response.code})');
        }
      },
      handleError: errorHandler,
      cancelOnError: true,
    );
  }

  void errorHandler(error) {
    if (error is DioError) {
      Fluttertoast.showToast(msg: '网络不可用，请检查你的网络设置');
    }
  }
}
