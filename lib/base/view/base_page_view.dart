///
/// base_page_view
///
/// created by DZDcyj at 2021/11/28
///
import 'package:dartin/dartin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

abstract class PageNodeProvider<T extends ChangeNotifier> extends StatelessWidget {
  final T mProvider;

  PageNodeProvider({Key key, List<dynamic> params})
      : mProvider = inject<T>(params: params),
        super(key: key);

  Widget buildContent(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>.value(
      value: mProvider,
      child: buildContent(context),
    );
  }
}

abstract class BasePageContentView<T extends ChangeNotifier> extends StatefulWidget {
  BasePageContentView(T provider, {Key key})
      : mProvider = provider,
        super(key: key);

  final T mProvider;

  @override
  BasePageContentViewState<T> createState();
}

abstract class BasePageContentViewState<T extends ChangeNotifier> extends State<BasePageContentView<T>> {
  T mProvider;

  void initState() {
    mProvider = widget.mProvider;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>.value(
      value: mProvider,
    );
  }

  /// 开始载入
  void startLoading() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        // 禁止手动退出加载界面
        return WillPopScope(
          onWillPop: () async => false,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  /// 移除载入弹窗
  void finishLoading() {
    Navigator.of(context, rootNavigator: true).pop();
  }

  Future<bool> showToast({
    @required String msg,
    Toast toastLength,
    int timeInSecForIosWeb = 1,
    double fontSize,
    ToastGravity gravity,
    Color backgroundColor,
    Color textColor,
    bool webShowClose = false,
    webBgColor: "linear-gradient(to right, #00b09b, #96c93d)",
    webPosition: "right",
  }) {
    return Fluttertoast.showToast(
      msg: msg,
      toastLength: toastLength,
      timeInSecForIosWeb: timeInSecForIosWeb,
      fontSize: fontSize,
      gravity: gravity,
      backgroundColor: backgroundColor,
      textColor: textColor,
      webShowClose: webShowClose,
      webBgColor: webBgColor,
      webPosition: webPosition,
    );
  }
}
