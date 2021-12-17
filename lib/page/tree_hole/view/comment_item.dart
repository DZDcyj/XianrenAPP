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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: _title()),
          _date(),
        ],
      ),
    );
  }

  /// 标题部分
  Widget _title() {
    return Text(
      '$anonymousName: $body',
      style: TextStyle(fontSize: 16.0),
    );
  }

  /// 日期部分
  Widget _date() {
    return Text(
      date,
      style: TextStyle(fontSize: 16.0),
    );
  }
}
