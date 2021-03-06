///
/// personal_information_modify_page_provider
///
/// created by DZDcyj at 2021/12/7
///
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xianren_app/base/view/base_page_view.dart';
import 'package:xianren_app/page/personal_information/view_model/personal_information_modify_page_provider.dart';
import 'package:xianren_app/router/router.dart';
import 'package:xianren_app/utils/global_util.dart';
import 'package:xianren_app/utils/string_util.dart';

class PersonalInformationModifyPage extends PageNodeProvider<PersonalInformationModifyPageProvider> {
  PersonalInformationModifyPage(
    this.phoneNumber,
    this.birthday,
    this.gender,
    this.hideBirthday,
    this.callback,
  ) : super(params: [phoneNumber, birthday, gender, hideBirthday, callback]);

  final String phoneNumber;
  final DateTime birthday;
  final Gender gender;
  final bool hideBirthday;
  final void Function(dynamic response) callback;

  @override
  Widget buildContent(BuildContext context) => _PersonalInformationModifyPageContent(mProvider);
}

class _PersonalInformationModifyPageContent extends BasePageContentView<PersonalInformationModifyPageProvider> {
  _PersonalInformationModifyPageContent(PersonalInformationModifyPageProvider provider) : super(provider);

  @override
  _PersonalInformationModifyPageContentState createState() => _PersonalInformationModifyPageContentState();
}

class _PersonalInformationModifyPageContentState
    extends BasePageContentViewState<PersonalInformationModifyPageProvider> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 40.0, right: 40.0),
        child: Center(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _modifyTitle(),
                _modifyHint(),
                _nickNameInput(),
                _genderSelector(),
                _birthDaySelector(),
                _modifyButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// ????????????
  Widget _modifyTitle() {
    return Text(
      '??????????????????',
      style: TextStyle(
        fontSize: 36.0,
      ),
    );
  }

  /// ????????????
  Widget _modifyHint() {
    return Text(
      '???????????????????????????????????????????????????????????????',
      style: TextStyle(
        fontSize: 15.0,
      ),
    );
  }

  /// ????????????
  Widget _nickNameInput() {
    return TextField(
      decoration: InputDecoration(
        labelText: '??????????????????????????????',
        hintText: '????????????????????????',
        prefixIcon: Icon(Icons.person),
      ),
      onChanged: (value) => mProvider.newNickname = value,
    );
  }

  /// ????????????
  Widget _genderSelector() {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            '?????????????????????',
            style: TextStyle(
              fontSize: 18.0,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Selector<PersonalInformationModifyPageProvider, Gender>(
            selector: (_, provider) => mProvider.gender,
            builder: (context, gender, child) {
              return DropdownButton(
                isExpanded: true,
                hint: Text('?????????????????????'),
                value: gender,
                items: List<DropdownMenuItem>.generate(
                  genderTranslation.length,
                  (index) => DropdownMenuItem(
                    value: Gender.values[index],
                    child: Center(
                      child: Text(
                        '${genderTranslation[Gender.values[index]]}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ),
                ),
                onChanged: (newValue) => mProvider.gender = newValue,
                icon: Icon(
                  Icons.people,
                  size: 28.0,
                ),
                elevation: 1,
              );
            },
          ),
        )
      ],
    );
  }

  /// ????????????
  Widget _birthDaySelector() {
    return Row(
      children: [
        Expanded(
          child: Icon(Icons.calendar_today),
        ),
        Expanded(
          flex: 2,
          child: GestureDetector(
            onTap: _handleDatePick,
            child: Selector<PersonalInformationModifyPageProvider, DateTime>(
              selector: (_, provider) => provider.birthday,
              builder: (context, value, child) => Text(transferDate(value)),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Selector<PersonalInformationModifyPageProvider, bool>(
            selector: (_, provider) => provider.birthdayHidden,
            builder: (context, hidden, child) => CheckboxListTile(
              title: Text('????????????'),
              onChanged: (value) => mProvider.birthdayHidden = value,
              value: hidden,
            ),
          ),
        ),
      ],
    );
  }

  /// ????????????
  void _handleDatePick() async {
    var picker = await showDatePicker(
      context: context,
      initialDate: mProvider.birthday,
      firstDate: DateTime(1970),
      lastDate: DateTime.now(),
      locale: Locale('zh'),
    );
    if (picker != null) {
      mProvider.birthday = picker.toLocal();
    }
  }

  /// ????????????
  Widget _modifyButton() {
    return Container(
      padding: EdgeInsets.only(left: 40.0, right: 40.0, top: 20.0),
      width: double.infinity,
      child: ElevatedButton(
        child: Text(
          '????????????',
          style: TextStyle(
            fontSize: 18.0,
          ),
        ),
        onPressed: _modifyHandler,
      ),
    );
  }

  /// ????????????
  void _modifyHandler() {
    mProvider.modifyPersonalBasicInformation(
      onStart: startLoading,
      onSuccess: _successHandler,
      onFailed: _failureHandler,
    );
  }

  /// ????????????
  void _successHandler(dynamic data) {
    finishLoading();
    mProvider.callback?.call(data);
    RouteWrapper.popSafety(context);
  }

  /// ????????????
  void _failureHandler(dynamic data) {
    finishLoading();
    mProvider.callback?.call(data);
    RouteWrapper.popSafety(context);
  }
}
