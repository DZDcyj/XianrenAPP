///
/// register_page_test
///
/// created by DZDcyj at 2021/11/30
///
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xianren_app/page/login_page/view/register_page.dart';
import 'package:xianren_app/page/login_page/view_model/register_page_provider.dart';

import '../base/app_module.dart';
import '../base/base.dart';

void main() {
  init();

  testWidgets('RegisterPage', (WidgetTester tester) async {
    RegisterPage page = RegisterPage();
    await showWidget(tester, page);

    // 输入信息
    await tester.enterText(find.byType(TextField).first, 'asd');
    expect(page.mProvider.nickName, 'asd');
    await tester.enterText(find.byType(TextField).at(1), 'abc@cde.com');
    expect(page.mProvider.phone, 'abc@cde.com');
    await tester.enterText(find.byType(TextField).at(2), 'cdef');
    expect(page.mProvider.password, 'cdef');
    await tester.enterText(find.byType(TextField).at(3), 'ghij');
    expect(page.mProvider.realName, 'ghij');
    await tester.enterText(find.byType(TextField).at(4), 'klmn');
    expect(page.mProvider.studentId, 'klmn');
    await tester.enterText(find.byType(TextField).at(5), 'opqr');
    expect(page.mProvider.idNumber, 'opqr');

    // 点击测试
    // 隐藏生日
    await tap(tester, find.byType(CheckboxListTile));
    expect(page.mProvider.birthdayHidden, true);

    await tap(tester, find.byType(DropdownButton));
    await tap(tester, find.byType(DropdownMenuItem).last);
    expect(page.mProvider.gender, Gender.secret);

    await tap(tester, find.byType(ElevatedButton));
  });
}
