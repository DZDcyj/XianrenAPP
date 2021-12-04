///
/// register_page_provider_test
///
/// created by DZDcyj at 2021/11/30
///
import 'dart:convert';

import 'package:dartin/dartin.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:xianren_app/bean/bean.dart';
import 'package:xianren_app/page/login_page/view_model/register_page_provider.dart';
import 'package:xianren_app/utils/net_util.dart';

import '../base/app_module.dart';
import '../base/data.dart';

void main() {
  init();

  NetUtil netUtil = inject();

  void checkValue(dynamic value, dynamic valueToCheck) {
    expect(value, valueToCheck);
  }

  test('validateInfo', () {
    RegisterPageProvider provider = RegisterPageProvider();
    expect(provider.validateInformation(onError: (value) => checkValue(value, '部分信息不完整')), false);
    provider.idNumber = '123';
    provider.studentId = 'u123';
    provider.realName = 'asd';
    provider.password = '123456';
    provider.phone = '123456';
    provider.nickName = 'aaa';
    provider.birthday = DateTime(2000);
    expect(provider.validateInformation(onError: (value) => checkValue(value, '密码不符合要求')), false);
    provider.password = 'Abc123456';
    expect(provider.validateInformation(onError: (value) => checkValue(value, '手机号不合法')), false);
    provider.phone = '13384581839';
    expect(provider.validateInformation(onError: (value) => checkValue(value, '身份证号不合法')), false);
    provider.idNumber = '440102198001021230';
    expect(provider.validateInformation(onError: (value) => fail('Should Not Be Called')), true);
  });

  test('doRegister', () {
    // 注册成功
    RegisterPageProvider provider = RegisterPageProvider();
    bool success = false;
    when(netUtil.register(any)).thenAnswer(
      (realInvocation) => Stream.fromFuture(
        Future.value(
          HttpResponseEntity<MapEntity>.fromJson(
            json.decode(successResponse),
          ),
        ),
      ),
    );
    bool started = false;
    provider.doRegister(onData: (response) => success = true, onStart: () => started = true).then((value) {
      expect(success, true);
      expect(started, true);
    });
  });
}
