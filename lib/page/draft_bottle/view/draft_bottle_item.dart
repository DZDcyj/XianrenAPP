///
/// draft_bottles_item
///
/// created by DZDcyj at 2021/12/16
///
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DraftBottleItem extends StatelessWidget {
  DraftBottleItem({
    @required this.content,
    @required this.id,
  });

  final String content;
  final int id;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
        border: Border.all(color: Colors.grey),
      ),
      child: ElevatedButton(
        onPressed: () => Fluttertoast.showToast(msg: '这是一个漂流瓶，id 为 $id'),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith(
            (states) => states.contains(MaterialState.pressed) ? Colors.grey : Colors.white,
          ),
          foregroundColor: MaterialStateProperty.resolveWith(
            (states) => states.contains(MaterialState.pressed) ? Colors.white : Colors.grey,
          ),
        ),
        child: Row(
          children: [
            _icon(),
            SizedBox(width: 20.0),
            _title(),
          ],
        ),
      ),
    );
  }

  /// 漂流瓶图标
  Widget _icon() {
    return Image.asset('assets/draft-bottle.png');
  }

  /// 内容部分
  Widget _title() {
    return Container(
      alignment: Alignment.centerLeft,
      constraints: BoxConstraints(minHeight: 50.0),
      child: Text(
        content,
        style: TextStyle(fontSize: 24.0),
      ),
    );
  }
}
