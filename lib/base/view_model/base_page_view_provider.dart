///
/// base_page_view_provider
///
/// created by DZDcyj at 2021/11/28
///
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:xianren_app/constants/constants.dart';

abstract class BasePageProvider extends ChangeNotifier {
  bool isDisposed = false;

  CompositeSubscription _compositeSubscription = CompositeSubscription();

  @override
  void dispose() {
    if (!_compositeSubscription.isDisposed) {
      _compositeSubscription.dispose();
    }
    isDisposed = true;
    super.dispose();
  }

  @override
  void notifyListeners() {
    if (isDisposed) {
      return;
    }
    super.notifyListeners();
  }

  void asyncRequest(
    Stream<dynamic> request, {
    bool cancelOnError,
    DataCallback onData,
    void Function(Error) handleError,
    VoidCallback onDone,
  }) {
    if (request == null || _compositeSubscription.isDisposed) {
      return;
    }
    _compositeSubscription.add(request.listen(null, cancelOnError: cancelOnError))
      ..onData(onData)
      ..onError(handleError)
      ..onDone(onDone);
  }
}
