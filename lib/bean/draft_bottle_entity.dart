///
/// draft_bottle_entity
///
/// created by DZDcyj at 2021/12/15
///
import 'bean.dart';

class DraftBottleEntity implements ToJson {
  List<String> comments;
  int id;
  String content;

  @override
  Map<String, dynamic> toJson() {
    return {
      'comments': comments,
      'id': id,
      'content': content,
    };
  }

  DraftBottleEntity.fromJson(Map<String, dynamic> json) {
    comments = List<String>.from(json['comments'] ?? []);
    id = json['id'];
    content = json['content'];
  }
}

class DraftBottleListEntity extends ToJson {
  List<DraftBottleEntity> bottles;

  @override
  Map<String, dynamic> toJson() {
    return {
      'list': bottles,
    };
  }

  DraftBottleListEntity.fromJson(Map<String, dynamic> json) {
    bottles ??= [];
    bottles.clear();
    if (json['list']?.isNotEmpty ?? false) {
      for (var bottle in json['list']) {
        bottles.add(DraftBottleEntity.fromJson(bottle));
      }
    }
  }
}
