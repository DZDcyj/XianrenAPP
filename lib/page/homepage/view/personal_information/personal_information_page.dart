///
/// personal_information_page
///
/// created by DZDcyj at 2021/12/4
///
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';
import 'package:xianren_app/base/view/base_page_view.dart';
import 'package:xianren_app/constants/constants.dart';
import 'package:xianren_app/page/homepage/view_model/personal_information/personal_information_page_provider.dart';
import 'package:xianren_app/router/router.dart';
import 'package:xianren_app/router/router_constant.dart';
import 'package:xianren_app/utils/global_util.dart';
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
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      mProvider.getAllInformation(
        onSessionInvalid: _sessionInvalidHandler,
        onError: _errorCodeCommonHandler,
        onStart: startLoading,
        onFinished: finishLoading,
      );
    });
  }

  /// 下拉刷新
  Future<void> _refresh() async {
    int timeStamp = DateTime.now().millisecondsSinceEpoch;
    if (timeStamp - (mProvider.refreshTimestamp ?? 0) > maxRefreshCoolDownMilliseconds) {
      mProvider.getAllInformation(
        onSessionInvalid: _sessionInvalidHandler,
        onStart: startLoading,
        onFinished: finishLoading,
        onError: _errorCodeCommonHandler,
        refresh: true,
      );
      mProvider.refreshTimestamp = timeStamp;
    } else {
      showToast(msg: '操作太频繁，请稍后再试');
    }
  }

  /// 错误码处理
  void _errorCodeCommonHandler(dynamic response) {
    showToast(msg: '发生错误！(${response.code})');
  }

  /// 会话过期
  void _sessionInvalidHandler() {
    showToast(msg: '会话过期，请重新登陆！');
    _logout();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
      onRefresh: _refresh,
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.only(left: 40.0, right: 40.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _avatar(),
                Selector<PersonalInformationPageProvider, String>(
                  selector: (_, provider) => provider.nickname,
                  builder: (context, value, child) => _nicknameDisplay(value),
                ),
                Selector<PersonalInformationPageProvider, String>(
                  selector: (_, provider) => provider.phoneNumber,
                  builder: (context, value, child) => _phoneNumberDisplay(value),
                ),
                Selector<PersonalInformationPageProvider, Tuple2<DateTime, bool>>(
                  selector: (_, provider) => Tuple2(provider.birthday, provider.hideBirthday),
                  builder: (context, tuple, child) => _birthdayDisplay(tuple.item1, tuple.item2),
                ),
                SizedBox(height: 20.0),
                _buildButtons(),
              ],
            ),
          ),
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
      '昵称：$nickname',
      style: TextStyle(fontSize: 36.0),
    );
  }

  /// 展示电话号码
  Widget _phoneNumberDisplay(String phoneNumber) {
    return Text(
      '电话：$phoneNumber',
      style: TextStyle(fontSize: 24.0),
    );
  }

  /// 展示生日
  Widget _birthdayDisplay(DateTime dateTime, bool hidden) {
    var suffix = hidden ? '(隐藏)' : '';
    return Text(
      '生日：${transferDate(dateTime)} $suffix',
      style: TextStyle(fontSize: 24.0),
    );
  }

  /// 展示匿名
  Widget _anonymousDisplay(String anonymous) {
    return Text(
      '我的匿名：$anonymous',
      style: TextStyle(fontSize: 18.0),
    );
  }

  /// 按钮组合
  Widget _buildButtons() {
    return Column(
      children: [
        _buildButton(label: '我的小纸条'),
        _buildButton(label: '我的树洞'),
        _buildButton(label: '修改个人信息', onTap: _jump2ModifyPersonalInformation),
        SizedBox(height: 30.0),
        Selector<PersonalInformationPageProvider, String>(
          selector: (_, provider) => provider.anonymous,
          builder: (context, value, child) => _anonymousDisplay(value),
        ),
        _buildButton(label: '修改匿名', onTap: _modifyAnonymous),
        SizedBox(height: 30.0),
        _buildButton(
          label: '退出登录',
          onTap: _logout,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith(
              (states) => states.contains(MaterialState.pressed) ? Colors.white : Colors.red,
            ),
            foregroundColor: MaterialStateProperty.resolveWith(
              (states) => states.contains(MaterialState.pressed) ? Colors.red : Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  /// 跳转到修改个人信息
  void _jump2ModifyPersonalInformation() {
    RouteWrapper.pushNamed(
      context,
      routerNamePersonalInformationModifyPage,
      arguments: [
        mProvider.phoneNumber,
        mProvider.birthday,
        mProvider.gender,
        mProvider.hideBirthday,
        _modifyResultHandler,
      ],
    );
  }

  /// 处理修改内容回调
  void _modifyResultHandler(dynamic response) {
    if (response.status) {
      // 成功
      mProvider.getAllInformation(
        onSessionInvalid: _sessionInvalidHandler,
        onError: _errorCodeCommonHandler,
        refresh: true,
      );
    } else {
      // 失败
      if (response.code == responseSessionMismatch || response.code == responseSessionInvalid) {
        showToast(msg: '会话过期，请重新登陆！');
        _logout();
      } else {
        showToast(msg: '发生错误！(${response.code})');
      }
    }
  }

  /// 修改匿名
  void _modifyAnonymous() {
    String origin = mProvider.anonymous;
    _jump2modifyAnonymous(origin).then((value) {
      if (value.item1) {
        if (origin != value.item2) {
          mProvider.modifyAnonymousName(
            value.item2,
            onStart: startLoading,
            onSuccess: (value) {
              mProvider.anonymous = value;
              Global.userInformationEntity.ua.anonymousName = value;
            },
            onFailed: (data) {
              if (data.code == responseSessionInvalid || data.code == responseSessionMismatch) {
                showToast(msg: '会话过期，请重新登陆！');
                _logout();
              } else {
                showToast(msg: '发生错误！(${data.code})');
              }
            },
            onDone: finishLoading,
          );
        }
      }
    });
  }

  /// 跳转到修改匿名
  Future<Tuple2<bool, String>> _jump2modifyAnonymous(String origin) async {
    // result 代表 是否更改匿名、更改后匿名为啥
    return await showDialog(
      context: context,
      builder: (context) {
        String newAnonymousName;
        return AlertDialog(
          title: Text('修改匿名'),
          content: TextField(
            maxLength: 12,
            controller: TextEditingController()..text = origin,
            decoration: InputDecoration(
              labelText: '新的匿名',
              hintText: '在此输入您想要的新匿名',
              prefixIcon: Icon(Icons.person),
            ),
            onChanged: (value) => newAnonymousName = value,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(Tuple2(false, '')),
              child: Text('取消'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(Tuple2(true, newAnonymousName ?? origin)),
              child: Text('确认'),
            ),
          ],
        );
      },
    );
  }

  /// 退出登录
  void _logout() {
    mProvider.logout().then((value) {
      RouteWrapper.popAndPushNamed(context, routerNameLoginPage);
    });
  }

  /// 单个按钮
  Widget _buildButton({
    void Function() onTap,
    String label,
    ButtonStyle style,
  }) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onTap,
        style: style ??
            ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith(
                (states) => states.contains(MaterialState.pressed) ? Colors.white : Colors.blue,
              ),
              foregroundColor: MaterialStateProperty.resolveWith(
                (states) => states.contains(MaterialState.pressed) ? Colors.blue : Colors.white,
              ),
            ),
        child: Text(
          label,
          style: TextStyle(fontSize: 20.0),
        ),
      ),
    );
  }
}
