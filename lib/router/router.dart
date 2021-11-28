///
/// router
///
/// created by DZDcyj at 2021/11/28
///
import 'package:xianren_app/router/router_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomNavigatorObserver extends NavigatorObserver {
  static CustomNavigatorObserver _instance;

  static CustomNavigatorObserver getInstance() {
    if (_instance == null) {
      _instance = CustomNavigatorObserver._internal();
    }
    return _instance;
  }

  static NavigatorState get instanceNavigator => _instance.navigator;

  CustomNavigatorObserver._internal();
}

class RouteWrapper {
  /// 进入新页面
  /// [routeName] 为对应页面
  /// [arguments] 为传递的参数
  static pushNamed(
    String routeName, {
    List<dynamic> arguments,
  }) {
    var navigator = CustomNavigatorObserver.instanceNavigator;
    navigator.push(
      MaterialPageRoute(
        builder: (context) => routerMap[routeName].call(params: arguments),
      ),
    );
  }

  /// 安全弹出当前界面
  /// 若当前页面为栈顶则不弹出
  static popSafety() {
    var navigator = CustomNavigatorObserver.instanceNavigator;
    navigator.maybePop();
  }

  /// 弹出当前页面并进入新页面
  static popAndPushNamed(
    String routerName, {
    List<dynamic> arguments,
  }) {
    var navigator = CustomNavigatorObserver.instanceNavigator;
    navigator.pop();
    pushNamed(routerName, arguments: arguments);
  }
}
