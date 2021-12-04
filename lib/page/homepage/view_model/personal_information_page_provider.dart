///
/// personal_information_page_provider
///
/// created by DZDcyj at 2021/12/4
///
import 'package:xianren_app/base/view_model/base_page_view_provider.dart';

class PersonalInformationPageProvider extends BasePageProvider {
  String _nickname;

  String get nickname => _nickname ?? 'Anonymous';

  set nickname(String value) {
    _nickname = value;
    notifyListeners();
  }

  String _phoneNumber;

  String get phoneNumber => _phoneNumber ?? '123456';

  set phoneNumber(String value) {
    _phoneNumber = value;
    notifyListeners();
  }

  DateTime _birthday;

  DateTime get birthday => _birthday ?? DateTime.now();

  set birthday(DateTime value) {
    _birthday = value;
    notifyListeners();
  }
}
