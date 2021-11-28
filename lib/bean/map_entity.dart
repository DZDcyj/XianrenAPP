///
/// map_entity
///
/// created by DZDcyj at 2021/11/28
///
import 'bean.dart';

/// Map 实体类
class MapEntity implements ToJson {
  Map<String, dynamic> content;

  MapEntity.fromJson(Map<String, dynamic> json) {
    content = json;
  }

  Map<String, dynamic> toJson() => content;
}
