///
/// homepage_provider
///
/// created by DZDcyj at 2021/11/28
///
import 'package:xianren_app/base/view_model/base_page_view_provider.dart';

class HomePageProvider extends BasePageProvider {
  int _currIndex;

  int get currIndex => _currIndex ?? 2;

  set currIndex(int value) {
    _currIndex = value;
    notifyListeners();
  }
}
