///
/// new_post_page_provider
///
/// created by DZDcyj at 2021/12/8
///
import 'package:dartin/dartin.dart';
import 'package:flutter/cupertino.dart';
import 'package:xianren_app/base/view_model/base_page_view_provider.dart';
import 'package:xianren_app/constants/constants.dart';
import 'package:xianren_app/utils/net_util.dart';
import 'package:xianren_app/utils/string_util.dart';

class NewPostPageProvider extends BasePageProvider {
  NewPostPageProvider(this.phoneNumber);

  final String phoneNumber;
  String title;
  String content;

  bool successfullyPublished; // 是否成功发布

  NetUtil netUtil = inject();

  Map<String, dynamic> _constructPost() {
    return {
      'phonenumber': phoneNumber,
      'mdate': transferDateWithTime(DateTime.now().toLocal()),
      'mtitle': title,
      'mbody': content,
    };
  }

  /// 校验数据合法性
  bool validateData({
    void Function(String errorMessage) callback,
  }) {
    if (title?.isEmpty ?? true) {
      callback?.call('帖子标题不能为空');
      return false;
    }
    if (content?.isEmpty ?? true) {
      callback?.call('帖子内容不能为空');
      return false;
    }
    return true;
  }

  void publishPost({
    VoidCallback onStart,
    VoidCallback onFinished,
    DataCallback onData,
  }) {
    onStart?.call();
    asyncRequest(
      netUtil.publishNewPost(_constructPost()),
      onData: (response) {
        onData?.call(response);
        onFinished?.call();
      },
    );
  }
}
