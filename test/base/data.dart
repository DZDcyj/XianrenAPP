///
/// data
///
/// created by DZDcyj at 2021/11/28
///
const String successResponse = '''
{
    "code": 20000,
    "message": "success",
    "data": {}
}
''';

const String failedResponse = '''
{
    "code": 20007,
    "message": "用户不存在",
    "data": {}
}
''';

const String successInfoResponse = '''
{
    "success": true,
    "code": 20000,
    "message": "成功",
    "data": {
        "ua": {
            "anonymName": "匿名者597126",
            "phoneNumber": "13666279971"
        },
        "ubi": {
            "birthday": "2005-11-14",
            "boolHideBirthday": 1,
            "gender": "男",
            "idNumber": "440102198001021230",
            "nickName": "Zhangsan",
            "phoneNumber": "13666279971",
            "realName": "Zhangsan",
            "studentNumber": "U123456"
        }
    }
}
''';

const String sessionInvalidResponse = '''
{
    "success": false,
    "code": 21009,
    "message": "Session无效",
    "data": {}
}
''';
