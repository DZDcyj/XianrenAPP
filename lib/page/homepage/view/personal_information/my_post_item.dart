///
/// my_post_item
///
/// created by DZDcyj at 2021/12/14
///
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xianren_app/constants/constants.dart';
import 'package:xianren_app/router/router.dart';
import 'package:xianren_app/router/router_constant.dart';

class MyPostItem extends StatelessWidget {
  MyPostItem({
    @required this.id,
    @required this.anonymousName,
    @required this.title,
    @required this.date,
    this.onDeleteCallback,
  });

  final int id;
  final String anonymousName;
  final String title;
  final String date;
  final DataCallback onDeleteCallback;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
        border: Border.all(color: Colors.grey),
      ),
      child: ElevatedButton(
        onPressed: () => RouteWrapper.pushNamed(context, routerNamePostDetail, arguments: [id]),
        onLongPress: () => onDeleteCallback?.call(id),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith(
            (states) => states.contains(MaterialState.pressed) ? Colors.grey : Colors.white,
          ),
          foregroundColor: MaterialStateProperty.resolveWith(
            (states) => states.contains(MaterialState.pressed) ? Colors.white : Colors.grey,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _name(),
            SizedBox(height: 1.0, child: Container(color: Colors.grey)),
            _title(),
            _date(),
          ],
        ),
      ),
    );
  }

  /// 标题部分
  Widget _title() {
    return Container(
      alignment: Alignment.centerLeft,
      constraints: BoxConstraints(minHeight: 50.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 24.0),
      ),
    );
  }

  /// 日期部分
  Widget _date() {
    return Container(
      alignment: Alignment.bottomRight,
      child: Text(date),
    );
  }

  /// 匿名者部分
  Widget _name() {
    return Container(
      alignment: Alignment.bottomLeft,
      child: Text(anonymousName),
    );
  }
}
