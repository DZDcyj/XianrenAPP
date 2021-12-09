///
/// post_entity
///
/// created by DZDcyj at 2021/12/9
///
import 'bean.dart';

/// 单个帖子实体
class PostEntity implements ToJson {
  int id;
  String title;
  String date;
  String phoneNumber;
  String anonymousName;

  PostEntity.fromJson(Map<String, dynamic> json) {
    id = json['mid'];
    title = json['mtitle'];
    date = json['mdate'];
    phoneNumber = json['phonenumber'];
    anonymousName = json['anonymname'];
  }

  Map<String, dynamic> toJson() {
    return {
      'mid': id ?? -1,
      'mtitle': title ?? '',
      'mdate': date,
      'phonenumber': phoneNumber,
      'anonymname': anonymousName,
    };
  }
}

class PostListEntity implements ToJson {
  List<PostEntity> posts;

  Map<String, dynamic> toJson() {
    return {
      'list': posts,
    };
  }

  PostListEntity.fromJson(Map<String, dynamic> json) {
    posts ??= [];
    if (json['list']?.isNotEmpty ?? false) {
      for (var post in json['list']) {
        posts.add(PostEntity.fromJson(post));
      }
    }
  }
}
