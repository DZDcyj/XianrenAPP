///
/// constants
///
/// created by DZDcyj at 2021/11/28
///

/// HTTP 返回码
const int responseOK = 200;
const int responseNotFound = 404;
const int responseInternalError = 500;

/// 网络请求相关
const int maxTimeout = 10000;
const String contentType = 'application/json; charset=utf8';
const String serverDomain = 'api.chinsan.top'; // TODO: 修改地址

/// 请求 API
const String registerApi = 'register';
const String loginApi = 'login';
