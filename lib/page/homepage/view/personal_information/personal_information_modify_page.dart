///
/// personal_information_modify_page_provider
///
/// created by DZDcyj at 2021/12/7
///
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xianren_app/base/view/base_page_view.dart';
import 'package:xianren_app/page/homepage/view_model/personal_information/personal_information_modify_page_provider.dart';
import 'package:xianren_app/router/router.dart';
import 'package:xianren_app/utils/global_util.dart';
import 'package:xianren_app/utils/string_util.dart';

class PersonalInformationModifyPage extends PageNodeProvider<PersonalInformationModifyPageProvider> {
  PersonalInformationModifyPage(
    this.phoneNumber,
    this.birthday,
    this.gender,
    this.hideBirthday,
    this.callback,
  ) : super(params: [phoneNumber, birthday, gender, hideBirthday, callback]);

  final String phoneNumber;
  final DateTime birthday;
  final Gender gender;
  final bool hideBirthday;
  final void Function(dynamic response) callback;

  @override
  Widget buildContent(BuildContext context) => _PersonalInformationModifyPageContent(mProvider);
}

class _PersonalInformationModifyPageContent extends BasePageContentView<PersonalInformationModifyPageProvider> {
  _PersonalInformationModifyPageContent(PersonalInformationModifyPageProvider provider) : super(provider);

  @override
  _PersonalInformationModifyPageContentState createState() => _PersonalInformationModifyPageContentState();
}

class _PersonalInformationModifyPageContentState
    extends BasePageContentViewState<PersonalInformationModifyPageProvider> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 40.0, right: 40.0),
        child: Center(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _modifyTitle(),
                _modifyHint(),
                _nickNameInput(),
                _genderSelector(),
                _birthDaySelector(),
                _modifyButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// 标题文字
  Widget _modifyTitle() {
    return Text(
      '修改个人信息',
      style: TextStyle(
        fontSize: 36.0,
      ),
    );
  }

  /// 提示文字
  Widget _modifyHint() {
    return Text(
      '请在下方填写想要修改的内容，不修改的请留空',
      style: TextStyle(
        fontSize: 15.0,
      ),
    );
  }

  /// 昵称修改
  Widget _nickNameInput() {
    return TextField(
      decoration: InputDecoration(
        labelText: '昵称（不修改请留空）',
        hintText: '在此输入新的昵称',
        prefixIcon: Icon(Icons.person),
      ),
      onChanged: (value) => mProvider.newNickname = value,
    );
  }

  /// 性别选择
  Widget _genderSelector() {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            '请选择您的性别',
            style: TextStyle(
              fontSize: 18.0,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Selector<PersonalInformationModifyPageProvider, Gender>(
            selector: (_, provider) => mProvider.gender,
            builder: (context, gender, child) {
              return DropdownButton(
                isExpanded: true,
                hint: Text('请选择您的性别'),
                value: gender,
                items: List<DropdownMenuItem>.generate(
                  genderTranslation.length,
                  (index) => DropdownMenuItem(
                    value: Gender.values[index],
                    child: Center(
                      child: Text(
                        '${genderTranslation[Gender.values[index]]}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ),
                ),
                onChanged: (newValue) => mProvider.gender = newValue,
                icon: Icon(
                  Icons.people,
                  size: 28.0,
                ),
                elevation: 1,
              );
            },
          ),
        )
      ],
    );
  }

  /// 生日选择
  Widget _birthDaySelector() {
    return Row(
      children: [
        Expanded(
          child: Icon(Icons.calendar_today),
        ),
        Expanded(
          flex: 2,
          child: GestureDetector(
            onTap: _handleDatePick,
            child: Selector<PersonalInformationModifyPageProvider, DateTime>(
              selector: (_, provider) => provider.birthday,
              builder: (context, value, child) => Text(transferDate(value)),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Selector<PersonalInformationModifyPageProvider, bool>(
            selector: (_, provider) => provider.birthdayHidden,
            builder: (context, hidden, child) => CheckboxListTile(
              title: Text('隐藏生日'),
              onChanged: (value) => mProvider.birthdayHidden = value,
              value: hidden,
            ),
          ),
        ),
      ],
    );
  }

  /// 日期选择
  void _handleDatePick() async {
    var picker = await showDatePicker(
      context: context,
      initialDate: mProvider.birthday,
      firstDate: DateTime(1970),
      lastDate: DateTime.now(),
      locale: Locale('zh'),
    );
    if (picker != null) {
      mProvider.birthday = picker.toLocal();
    }
  }

  /// 修改按钮
  Widget _modifyButton() {
    return Container(
      padding: EdgeInsets.only(left: 40.0, right: 40.0, top: 20.0),
      width: double.infinity,
      child: ElevatedButton(
        child: Text(
          '确认修改',
          style: TextStyle(
            fontSize: 18.0,
          ),
        ),
        onPressed: _modifyHandler,
      ),
    );
  }

  /// 修改信息
  void _modifyHandler() {
    mProvider.modifyPersonalBasicInformation(
      onStart: startLoading,
      onSuccess: _successHandler,
      onFailed: _failureHandler,
    );
  }

  /// 修改成功
  void _successHandler(dynamic data) {
    finishLoading();
    mProvider.callback?.call(data);
    RouteWrapper.popSafety();
  }

  void _failureHandler(dynamic data) {
    finishLoading();
    mProvider.callback?.call(data);
    RouteWrapper.popSafety();
  }
}
