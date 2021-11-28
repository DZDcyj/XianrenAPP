///
/// base_page_view
///
/// created by DZDcyj at 2021/11/28
///
import 'package:dartin/dartin.dart';
import 'package:flutter/cupertino.dart';
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
}
