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
const int responseSessionInvalid = 21009; // Session 无效
const int responseWrongPassword = 21008; // 密码错误
const int responseSessionMismatch = 21010; // Session 不匹配

/// 网络请求相关
const int maxTimeout = 10000;
const String contentType = 'application/json; charset=utf8';
const String serverDomain = '81.70.93.231:8080';

/// 请求 API
const String registerApi = 'register'; // 注册
const String loginApi = 'login'; // 登录
const String getAllInfoApi = 'getallinfo'; // 获取所有信息
const String modifyAnonymousApi = 'changeua'; // 更改匿名
const String modifyPersonalBasicInformationApi = 'changeubi'; // 修改基本信息
const String publishNewPostApi = 'newarticle'; // 发表新的帖子
const String getTreeHoleArticlesApi = 'simplearticles'; // 获取所有帖子
const String postNewCommentApi = 'newcomments';
const String getPostDetailApi = 'articledetails'; // 获取单个帖子详细信息

/// SharedPreferences Key
String usernameKey = 'username';
String passwordKey = 'password';
String autoInputKey = 'autoInput';
String autoLoginKey = 'autoLogin';

/// 一些常量
const int maxRefreshCoolDownMilliseconds = 3000; // 刷新间隔（毫秒）

/// 类型变量
typedef DataCallback = void Function(dynamic data); // 数据回调
