///
/// register_page_provider_test
///
/// created by DZDcyj at 2021/11/30
///
import 'package:flutter_test/flutter_test.dart';
import 'package:xianren_app/page/login_page/view_model/register_page_provider.dart';

import '../base/app_module.dart';

void main() {
  init();

  void checkValue(dynamic value, dynamic valueToCheck) {
    expect(value, valueToCheck);
  }

  test('validateInfo', () {
    RegisterPageProvider provider = RegisterPageProvider();
    expect(provider.validateInformation(callback: (value) => checkValue(value, '部分信息不完整')), false);
    provider.idNumber = '123';
    provider.studentId = 'u123';
    provider.realName = 'asd';
    provider.password = '123456';
    provider.phone = '123456';
    provider.nickName = 'aaa';
    expect(provider.validateInformation(callback: (value) => checkValue(value, '密码不符合要求')), false);
    provider.password = 'Abc123456';
    expect(provider.validateInformation(callback: (value) => checkValue(value, '手机号不合法')), false);
    provider.phone = '13384581839';
    expect(provider.validateInformation(callback: (value) => checkValue(value, '身份证号不合法')), false);
    provider.idNumber = '440102198001021230';
    expect(provider.validateInformation(callback: (value) => fail('Should Not Be Called')), true);
  });
}
