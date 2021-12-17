///
/// draft_bottle_comment_item
///
/// created by DZDcyj at 2021/12/17
///
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DraftBottleCommentItem extends StatelessWidget {
  DraftBottleCommentItem({
    @required this.content,
  });

  final String content;

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
          Image.asset('assets/reply.png'),
          SizedBox(width: 20.0),
          Expanded(child: Text(content, style: TextStyle(fontSize: 16.0))),
        ],
      ),
    );
  }
}
