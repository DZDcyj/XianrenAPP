///
/// personal_information_modify_page_provider
///
/// created by DZDcyj at 2021/12/7
///
import 'package:dartin/dartin.dart';
import 'package:xianren_app/base/view_model/base_page_view_provider.dart';
import 'package:xianren_app/constants/constants.dart';
import 'package:xianren_app/utils/global_util.dart';
import 'package:xianren_app/utils/net_util.dart';
import 'package:xianren_app/utils/string_util.dart';

class PersonalInformationModifyPageProvider extends BasePageProvider {
  PersonalInformationModifyPageProvider(
    this.phoneNumber,
    this._birthday,
    this._gender,
    this._birthdayHidden,
    this.callback,
  );

  NetUtil netUtil = inject();

  final String phoneNumber;
  String newNickname;
  DateTime _birthday;
  final void Function(dynamic response) callback;

  DateTime get birthday => _birthday;

  set birthday(DateTime value) {
    _birthday = value;
    notifyListeners();
  }

  Gender _gender;

  Gender get gender => _gender;

  set gender(Gender value) {
    _gender = value;
    notifyListeners();
  }

  bool _birthdayHidden;

  bool get birthdayHidden => _birthdayHidden;

  set birthdayHidden(bool value) {
    _birthdayHidden = value;
    notifyListeners();
  }

  /// 构造数据
  Map<String, dynamic> _constructData() {
    Map<String, dynamic> result = {
      'phonenumber': phoneNumber,
      'gender': genderTranslation[gender],
      'birthday': transferDate(birthday),
      'boolhidebirthday': birthdayHidden ? 1 : 0,
    };
    if (newNickname?.isNotEmpty ?? false) {
      result['nickname'] = newNickname;
    }
    return result;
  }

  /// 更新基础信息
  Future<void> modifyPersonalBasicInformation({
    VoidCallback onStart,
    DataCallback onSuccess,
    DataCallback onFailed,
  }) async {
    onStart?.call();
    asyncRequest(
      netUtil.modifyPersonalInformation(_constructData()),
      onData: (response) {
        if (response.code == responseOK) {
          onSuccess?.call(response);
        } else {
          onFailed?.call(response);
        }
      },
    );
  }
}
