///
/// constants
///
/// created by DZDcyj at 2021/11/28
///

/// HTTP 返回码
const int httpResponseOK = 200;
const int httpResponseNotFound = 404;
const int httpResponseInternalError = 500;

/// 业务逻辑返回码
const int responseOK = 20000; // 成功
const int responseRegisterFailed = 20001; // 注册失败
const int responseUserNotExist = 20007; // 用户不存在
const int responseWrongPassword = 20008; // 密码错误
const int responseSessionInvalid = 21009; // Session 无效

/// 网络请求相关
const int maxTimeout = 10000;
const String contentType = 'application/json; charset=utf8';
const String serverDomain = '81.70.93.231:8080';

/// 请求 API
const String registerApi = 'register';
const String loginApi = 'login';
const String getAllInfoApi = 'getallinfor';

/// SharedPreferences Key
String usernameKey = 'username';
String passwordKey = 'password';
String autoInputKey = 'autoInput';
String autoLoginKey = 'autoLogin';
