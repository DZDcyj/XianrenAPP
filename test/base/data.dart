///
/// data
///
/// created by DZDcyj at 2021/11/28
///
const String successResponse = '''
{
    "code": 20000,
    "status":true,
    "message": "success",
    "data": {}
}
''';

const String failedResponse = '''
{
    "code": 20007,
    "status": false,
    "message": "用户不存在",
    "data": {}
}
''';

const String wrongPasswordResponse = '''
{
    "code": 21008,
    "status": false,
    "message": "密码错误,请重新输入!",
    "data": {}
}
''';

const String successInfoResponse = '''
{
    "status": true,
    "code": 20000,
    "message": "成功",
    "data": {
        "ua": {
            "anonymName": "匿名者597126",
            "phoneNumber": "12345678910"
        },
        "ubi": {
            "birthday": "2005-11-14",
            "boolHideBirthday": 1,
            "gender": "男",
            "idNumber": "440102198001021230",
            "nickName": "Zhangsan",
            "phoneNumber": "12345678910",
            "realName": "Zhangsan",
            "studentNumber": "U123456"
        }
    }
}
''';

const String sessionInvalidResponse = '''
{
    "status": false,
    "code": 21009,
    "message": "Session无效",
    "data": {}
}
''';

const String postsResponse = '''
{
    "code": 20000,
    "message": "成功",
    "data": {
        "list": [
            {
                "mid": 1,
                "mtitle": "Test",
                "mdate": "2021-12-08 00:00:00",
                "phonenumber": "12345678910",
                "anonymname": "匿名者12138"
            },
            {
                "mid": 2,
                "mtitle": "asdasd",
                "mdate": "2021-12-08 00:00:00",
                "phonenumber": "12345678910",
                "anonymname": "匿名者12138"
            },
            {
                "mid": 3,
                "mtitle": "asdasd",
                "mdate": "2021-12-08 00:00:00",
                "phonenumber": "12345678910",
                "anonymname": "匿名者12138"
            },
            {
                "mid": 4,
                "mtitle": "dasdsad",
                "mdate": "2021-12-08 00:00:00",
                "phonenumber": "12345678910",
                "anonymname": "匿名者12138"
            },
            {
                "mid": 5,
                "mtitle": "sdasdsad",
                "mdate": "2021-12-08 00:00:00",
                "phonenumber": "12345678910",
                "anonymname": "匿名者12138"
            },
            {
                "mid": 6,
                "mtitle": "sdasdsad",
                "mdate": "2021-12-08 00:00:00",
                "phonenumber": "12345678910",
                "anonymname": "匿名者12138"
            }
        ]
    },
    "status": true
}
''';

const String emptyPostsResponse = '''
{
    "code": 20000,
    "message": "成功",
    "data": {
        "list": [
        ]
    },
    "status": true
}
''';

const String commentsResponse = '''
{
    "code": 20000,
    "message": "成功",
    "data": {
        "list": [
            {
                "anonymname": "张三",
                "cid": 4,
                "mid": 8,
                "phonenumber": "12345678910",
                "cdate": "2021-12-12 16:29:54",
                "cbody": "aasdasda"
            },
            {
                "anonymname": "张三",
                "cid": 3,
                "mid": 8,
                "phonenumber": "12345678910",
                "cdate": "2021-12-12 16:19:31",
                "cbody": "wojuedebuxing"
            },
            {
                "anonymname": "张三",
                "cid": 2,
                "mid": 8,
                "phonenumber": "12345678910",
                "cdate": "2021-12-12 16:19:28",
                "cbody": "wojuedebuxing"
            },
            {
                "anonymname": "张三",
                "cid": 1,
                "mid": 8,
                "phonenumber": "12345678910",
                "cdate": "2021-12-12 16:09:18",
                "cbody": "123123"
            }
        ]
    },
    "status": true
}
''';

const String emptyCommentsResponse = '''
{
    "code": 20000,
    "message": "成功",
    "data": {
        "list": [
        ]
    },
    "status": true
}
''';

const String postDetailResponse = '''
{
    "code": 20000,
    "message": "成功",
    "data": {
        "articledetails": {
            "mid": 1,
            "phonenumber": "12345678910",
            "mdate": "2021-12-08 00:00:00",
            "mtitle": "Test",
            "anonymname": "张三",
            "mbody": "Test"
        }
    },
    "status": true
}
''';

const String bottleResponse = '''
{
    "code": 20000,
    "message": "成功",
    "data": {
        "list": [
            {
                "id": 4,
                "content": "sdfas"
            },
            {
                "id": 3,
                "content": "啦啦啦啦"
            },
            {
                "id": 6,
                "content": "今天我联盟超级C"
            }
        ]
    },
    "status": true
}
''';
