///
/// personal_information_page
///
/// created by DZDcyj at 2021/12/4
///
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xianren_app/base/view/base_page_view.dart';
import 'package:xianren_app/page/homepage/view_model/personal_information_page_provider.dart';
import 'package:xianren_app/utils/string_util.dart';

class PersonalInformationPage extends PageNodeProvider<PersonalInformationPageProvider> {
  @override
  Widget buildContent(BuildContext context) => _PersonalInformationPageContent(mProvider);
}

class _PersonalInformationPageContent extends BasePageContentView<PersonalInformationPageProvider> {
  _PersonalInformationPageContent(PersonalInformationPageProvider provider) : super(provider);

  @override
  _PersonalInformationPageContentState createState() => _PersonalInformationPageContentState();
}

class _PersonalInformationPageContentState extends BasePageContentViewState<PersonalInformationPageProvider> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.only(left: 40.0, right: 40.0),
        child: Column(
          children: [
            _avatar(),
            _nicknameDisplay(mProvider.nickname),
            _phoneNumberDisplay(mProvider.phoneNumber),
            _birthdayDisplay(mProvider.birthday),
            SizedBox(height: 40.0),
            _buildButtons(),
          ],
        ),
      ),
    );
  }

  /// 头像（伪）
  Widget _avatar() {
    return Image(image: AssetImage('assets/self.png'));
  }

  /// 昵称
  Widget _nicknameDisplay(String nickname) {
    return Text(
      nickname,
      style: TextStyle(fontSize: 36.0),
    );
  }

  /// 展示电话号码
  Widget _phoneNumberDisplay(String phoneNumber) {
    return Text(
      phoneNumber,
      style: TextStyle(fontSize: 32.0),
    );
  }

  Widget _birthdayDisplay(DateTime dateTime) {
    return Text(
      transferDate(dateTime),
      style: TextStyle(fontSize: 24.0),
    );
  }

  /// 按钮组合
  Widget _buildButtons() {
    return Column(
      children: [
        _buildButton(label: '我的小纸条'),
        _buildButton(label: '我的树洞'),
        _buildButton(label: '修改个人信息'),
      ],
    );
  }

  /// 单个按钮
  Widget _buildButton({
    void Function() onTap,
    String label,
  }) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onTap ?? () {},
        child: Text(
          label,
          style: TextStyle(fontSize: 20.0),
        ),
      ),
    );
  }
}
