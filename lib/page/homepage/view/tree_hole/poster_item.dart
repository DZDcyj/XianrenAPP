///
/// poster_item
///
/// created by DZDcyj at 2021/12/11
///
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xianren_app/bean/bean.dart';

class PostItem extends StatelessWidget {
  PostItem({
    @required this.entity,
  });

  final PostDetailEntity entity;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: 100.0),
      child: Column(
        children: [
          _title(),
          Row(
            children: [
              Expanded(child: _poster()),
              _date(),
            ],
          ),
          _content(),
        ],
      ),
    );
  }

  /// 标题
  Widget _title() {
    return Container(
      alignment: Alignment.centerLeft,
      constraints: BoxConstraints(minHeight: 50.0),
      child: Text(
        entity?.title ?? '',
        style: TextStyle(fontSize: 24.0),
      ),
    );
  }

  /// 楼主
  Widget _poster() {
    return Row(
      children: [
        Icon(Icons.person),
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            entity?.anonymousName ?? '',
            style: TextStyle(fontSize: 18.0),
          ),
        ),
      ],
    );
  }

  /// 具体帖子内容
  Widget _content() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: Text(
        entity?.body ?? '',
        style: TextStyle(fontSize: 18.0),
      ),
    );
  }

  /// 日期
  Widget _date() {
    return Container(
      alignment: Alignment.bottomRight,
      child: Text('发表于 ${entity?.date ?? ''}'),
    );
  }
}
