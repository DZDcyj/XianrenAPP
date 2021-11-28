///
/// homepage_provider
///
/// created by DZDcyj at 2021/11/28
///
import 'package:xianren_app/base/view_model/base_page_view_provider.dart';

class HomePageProvider extends BasePageProvider {
  HomePageProvider(this.title);

  final String title;

  int _counter;

  int get counter => _counter ?? 0;

  set counter(int value) {
    _counter = value;
    notifyListeners();
  }

  void increment() => counter++;
}
