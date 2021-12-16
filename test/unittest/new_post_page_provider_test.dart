///
/// new_post_page_provider_test
///
/// created by DZDcyj at 2021/12/14
///
import 'package:flutter_test/flutter_test.dart';
import 'package:xianren_app/page/tree_hole/view_model/new_post_page_provider.dart';

import '../base/app_module.dart';

void main() {
  init();

  NewPostPageProvider provider;

  setUp(() {
    provider = NewPostPageProvider('123456');
  });

  test('validateData', () {
    expect(
      provider.validateData(
        callback: (string) => expect(string, '帖子标题不能为空'),
      ),
      false,
    );
    provider.title = 'asd';
    expect(
      provider.validateData(
        callback: (string) => expect(string, '帖子内容不能为空'),
      ),
      false,
    );
    provider.content = 'cde';
    expect(
      provider.validateData(
        callback: (string) => fail('Should not run here'),
      ),
      true,
    );
  });
}
