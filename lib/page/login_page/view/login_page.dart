///
/// login_page
///
/// created by DZDcyj at 2021/11/28
///
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:xianren_app/base/view/base_page_view.dart';
import 'package:xianren_app/page/login_page/view_model/login_page_provider.dart';
import 'package:xianren_app/router/router.dart';
import 'package:xianren_app/router/router_constant.dart';

class LoginPage extends PageNodeProvider<LoginPageProvider> {
  @override
  Widget buildContent(BuildContext context) => _LoginPageContent(mProvider);
}

class _LoginPageContent extends BasePageContentView<LoginPageProvider> {
  _LoginPageContent(LoginPageProvider provider) : super(provider);

  @override
  _LoginPageContentState createState() => _LoginPageContentState();
}

class _LoginPageContentState extends BasePageContentViewState<LoginPageProvider> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Duration.zero, () {
        mProvider.initialize().then((_) {
          _usernameController.text = mProvider.username;
          _passwordController.text = mProvider.password;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 15.0, right: 15.0),
        child: Center(
          child: _loginBody(),
        ),
      ),
    );
  }

  /// 中部控件
  Widget _loginBody() {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _logo(),
          _title(),
          _usernameInput(),
          _passwordInput(),
          _autoCheckboxes(),
          _loginButton(),
          _registerButton(),
        ],
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

  /// 用户名输入
  Widget _usernameInput() {
    return TextField(
      controller: _usernameController,
      decoration: InputDecoration(
        labelText: '用户名',
        hintText: '输入用户名或邮箱',
        prefixIcon: Icon(Icons.person),
      ),
      onChanged: (value) => mProvider.username = value,
    );
  }

  /// 密码输入
  Widget _passwordInput() {
    return TextField(
      controller: _passwordController,
      decoration: InputDecoration(
        labelText: '密码',
        hintText: '在此输入密码',
        prefixIcon: Icon(Icons.lock),
      ),
      obscureText: true,
      onChanged: (value) => mProvider.password = value,
    );
  }

  /// 保存用户名密码、自动登录勾选框
  Widget _autoCheckboxes() {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Selector<LoginPageProvider, bool>(
            selector: (_, provider) => provider.autoInput,
            builder: (context, autoInput, child) {
              return CheckboxListTile(
                title: Text(
                  '记住用户名和密码',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                value: autoInput,
                onChanged: (_autoInput) {
                  mProvider.autoInput = _autoInput;
                  // 取消记住密码将会自动取消自动登录
                  if (!_autoInput) {
                    mProvider.autoLogin = false;
                  }
                },
              );
            },
          ),
        ),
        Expanded(
          flex: 2,
          child: Selector<LoginPageProvider, bool>(
            selector: (_, provider) => provider.autoLogin,
            builder: (context, autoLogin, child) {
              return CheckboxListTile(
                title: Text(
                  '自动登录',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                value: autoLogin,
                onChanged: (_autoLogin) {
                  mProvider.autoLogin = _autoLogin;
                  // 勾选自动登录将会启用记住密码
                  if (_autoLogin) {
                    mProvider.autoInput = true;
                  }
                },
              );
            },
          ),
        ),
      ],
    );
  }

  /// 登录按钮
  Widget _loginButton() {
    return Container(
      padding: EdgeInsets.only(left: 40.0, right: 40.0, top: 20.0),
      width: double.infinity,
      child: ElevatedButton(
        child: Text(
          '登录',
          style: TextStyle(
            fontSize: 18.0,
          ),
        ),
        onPressed: _loginHandler,
      ),
    );
  }

  /// 处理登录
  void _loginHandler() {
    mProvider.login(() {});
    // TODO: 登录、跳转
  }

  /// 注册按钮
  Widget _registerButton() {
    return TextButton(
      onPressed: _handleRegisterJump,
      child: Text('没有账号？注册一个！'),
    );
  }

  /// 跳转到注册界面
  void _handleRegisterJump() {
    RouteWrapper.pushNamed(routerNameRegisterPage);
  }
}
