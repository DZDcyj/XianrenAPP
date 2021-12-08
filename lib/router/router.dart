///
/// router
///
/// created by DZDcyj at 2021/11/28
///
import 'package:dartin/dartin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xianren_app/router/router_constant.dart';

class RouteWrapper {
  static NavigatorObserver observer = inject();

  /// 进入新页面
  /// [routeName] 为对应页面
  /// [arguments] 为传递的参数
  static Future<void> pushNamed(
    BuildContext context,
    String routeName, {
    List<dynamic> arguments,
  }) async {
    var navigator = observer.navigator;
    navigator ??= Navigator.of(context);
    await navigator.push(
      MaterialPageRoute(
        builder: (context) => routerMap[routeName].call(params: arguments),
      ),
    );
  }

  /// 安全弹出当前界面
  /// 若当前页面为栈顶则不弹出
  static Future<bool> popSafety(
    BuildContext context, {
    dynamic result,
  }) async {
    var navigator = observer.navigator;
    navigator ??= Navigator.of(context);
    return navigator?.maybePop(result);
  }

  /// 弹出当前页面并进入新页面
  static Future<void> popAndPushNamed(
    BuildContext context,
    String routerName, {
    List<dynamic> arguments,
  }) async {
    var navigator = observer.navigator;
    navigator ??= Navigator.of(context);
    navigator?.pop();
    await pushNamed(context, routerName, arguments: arguments);
  }
}
