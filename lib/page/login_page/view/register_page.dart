///
/// register_page
///
/// created by DZDcyj at 2021/11/29
///
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:xianren_app/base/view/base_page_view.dart';
import 'package:xianren_app/constants/constants.dart';
import 'package:xianren_app/page/login_page/view_model/register_page_provider.dart';
import 'package:xianren_app/router/router.dart';
import 'package:xianren_app/utils/string_util.dart';

class RegisterPage extends PageNodeProvider<RegisterPageProvider> {
  @override
  Widget buildContent(BuildContext context) => _RegisterPageContent(mProvider);
}

class _RegisterPageContent extends BasePageContentView<RegisterPageProvider> {
  _RegisterPageContent(RegisterPageProvider provider) : super(provider);

  @override
  _RegisterPageContentState createState() => _RegisterPageContentState();
}

class _RegisterPageContentState extends BasePageContentViewState<RegisterPageProvider> {
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
                _registerHint(),
                _nickNameInput(),
                _genderSelector(),
                _birthDaySelector(),
                _phoneInput(),
                _passwordInput(),
                _realNameInput(),
                _studentIdInput(),
                _idNumberInput(),
                _registerButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// 注册文字
  Widget _registerHint() {
    return Text(
      '注册',
      style: TextStyle(
        fontSize: 48,
      ),
    );
  }

  /// 昵称输入
  Widget _nickNameInput() {
    return TextField(
      decoration: InputDecoration(
        labelText: '昵称',
        hintText: '在此输入您的昵称',
        prefixIcon: Icon(Icons.person),
      ),
      onChanged: (value) => mProvider.nickName = value,
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
          child: Selector<RegisterPageProvider, Gender>(
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
            child: Selector<RegisterPageProvider, DateTime>(
              selector: (_, provider) => provider.birthday,
              builder: (context, value, child) => Text(transferDate(value)),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Selector<RegisterPageProvider, bool>(
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

  /// 手机号码输入
  Widget _phoneInput() {
    return TextField(
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        labelText: '手机号',
        hintText: '在此输入您的手机号',
        prefixIcon: Icon(Icons.phone_android),
      ),
      onChanged: (value) => mProvider.phone = value,
    );
  }

  /// 实名认证
  Widget _realNameInput() {
    return TextField(
      decoration: InputDecoration(
        labelText: '姓名',
        hintText: '在此输入您的真实姓名',
        prefixIcon: Icon(Icons.person_outline),
      ),
      onChanged: (value) => mProvider.realName = value,
    );
  }

  /// 学号输入
  Widget _studentIdInput() {
    return TextField(
      decoration: InputDecoration(
        labelText: '学号',
        hintText: '在此输入您的学号',
        prefixIcon: Icon(Icons.school),
      ),
      onChanged: (value) => mProvider.studentId = value,
    );
  }

  /// 身份证号输入
  Widget _idNumberInput() {
    return TextField(
      decoration: InputDecoration(
        labelText: '身份证号',
        hintText: '在此输入您的身份证号码',
        prefixIcon: Icon(Icons.perm_identity),
      ),
      onChanged: (value) => mProvider.idNumber = value,
    );
  }

  /// 注册按钮
  Widget _registerButton() {
    return Container(
      padding: EdgeInsets.only(left: 40.0, right: 40.0, top: 20.0),
      width: double.infinity,
      child: ElevatedButton(
        child: Text(
          '注册',
          style: TextStyle(
            fontSize: 18.0,
          ),
        ),
        onPressed: _registerHandler,
      ),
    );
  }

  /// 处理注册
  void _registerHandler() {
    if (mProvider.validateInformation(onError: _messageShowHandler)) {
      mProvider.doRegister(
        onData: (response) {
          _messageShowHandler(response.message);
          if (response.code == responseOK) {
            RouteWrapper.popSafety();
          }
        },
      );
    }
  }

  void _messageShowHandler(value) {
    if (value is String) {
      Fluttertoast.showToast(msg: value);
    }
  }

  /// 密码输入
  Widget _passwordInput() {
    return TextField(
      decoration: InputDecoration(
        labelText: '密码',
        hintText: '8-16位，必须包含数字和大小写字母',
        prefixIcon: Icon(Icons.lock),
      ),
      obscureText: true,
      onChanged: (value) => mProvider.password = value,
    );
  }
}
