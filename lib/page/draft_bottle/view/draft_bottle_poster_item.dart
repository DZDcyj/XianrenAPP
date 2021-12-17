///
/// draft_bottle_poster_item
///
/// created by DZDcyj at 2021/12/17
///
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DraftBottlePosterItem extends StatelessWidget {
  DraftBottlePosterItem({
    @required this.content,
  });

  final String content;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10.0, right: 10.0),
      constraints: BoxConstraints(minHeight: 100),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
        border: Border.all(color: Colors.blue),
      ),
      child: Row(
        children: [
          Image.asset('assets/letter.png'),
          SizedBox(width: 20.0),
          Text(content, style: TextStyle(fontSize: 16.0)),
        ],
      ),
    );
  }
}
