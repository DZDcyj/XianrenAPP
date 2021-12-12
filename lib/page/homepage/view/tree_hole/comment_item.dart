///
/// comment_item
///
/// created by DZDcyj at 2021/12/11
///
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommentItem extends StatelessWidget {
  CommentItem({
    @required this.anonymousName,
    @required this.date,
    @required this.body,
  });

  final String anonymousName;
  final String date;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
      padding: EdgeInsets.only(left: 10.0, right: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
        border: Border.all(color: Colors.grey),
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
    );
  }

  /// 标题部分
  Widget _title() {
    return Container(
      alignment: Alignment.centerLeft,
      constraints: BoxConstraints(minHeight: 50.0),
      child: Text(
        body,
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
