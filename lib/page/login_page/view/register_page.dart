///
/// register_page
///
/// created by DZDcyj at 2021/11/29
///
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xianren_app/base/view/base_page_view.dart';
import 'package:xianren_app/page/login_page/view_model/register_page_provider.dart';

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
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _logo(),
              _title(),
              _registerHint(),
              _nickNameInput(),
              _genderSelector(),
              _emailInput(),
              _passwordInput(),
              _realNameInput(),
              _studentIdInput(),
              _idNumberInput(),
              _registerButton(),
            ],
          ),
        ),
      ),
    );
  }

  /// Xianren Logo
  Widget _logo() {
    return Image(image: AssetImage('assets/logo.png'));
  }

  /// Xianren 文字
  Widget _title() {
    return Text(
      'Xianren',
      style: TextStyle(
        fontSize: 64,
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

  /// 邮箱输入
  Widget _emailInput() {
    return TextField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: '邮箱',
        hintText: '在此输入您的邮箱',
        prefixIcon: Icon(Icons.mail),
      ),
      onChanged: (value) => mProvider.email = value,
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
      width: double.infinity,
      child: ElevatedButton(
        child: Text('注册'),
        onPressed: _registerHandler,
      ),
    );
  }

  /// 处理注册
  void _registerHandler() {
    // TODO: 处理注册事件回调
  }

  /// 密码输入
  Widget _passwordInput() {
    return TextField(
      decoration: InputDecoration(
        labelText: '密码',
        hintText: '在此输入密码',
        prefixIcon: Icon(Icons.lock),
      ),
      obscureText: true,
      onChanged: (value) => mProvider.password = value,
    );
  }
}
