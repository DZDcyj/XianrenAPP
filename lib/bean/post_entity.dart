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

/// 帖子详细信息
class PostDetailEntity implements ToJson {
  int id;
  String phoneNumber;
  String date;
  String title;
  String anonymousName;
  String body;

  @override
  Map<String, dynamic> toJson() {
    return {
      'mid': id,
      'phonenumber': phoneNumber,
      'mdate': date,
      'mtitle': title,
      'anonymname': title,
      'mbody': body,
    };
  }

  PostDetailEntity.fromJson(Map<String, dynamic> jsonData) {
    var json = jsonData['articledetails'];
    id = json['mid'];
    phoneNumber = json['phonenumber'];
    date = json['mdate'];
    title = json['mtitle'];
    anonymousName = json['anonymname'];
    body = json['mbody'];
  }
}

/// 帖子列表实体
class PostListEntity implements ToJson {
  List<PostEntity> posts;

  Map<String, dynamic> toJson() {
    return {
      'list': posts,
    };
  }

  PostListEntity.fromJson(Map<String, dynamic> json) {
    posts ??= [];
    posts.clear();
    if (json['list']?.isNotEmpty ?? false) {
      for (var post in json['list']) {
        posts.add(PostEntity.fromJson(post));
      }
    }
  }
}

/// 评论列表实体
class CommentListEntity implements ToJson {
  List<CommentEntity> comments;

  @override
  Map<String, dynamic> toJson() {
    return {
      'list': comments,
    };
  }

  CommentListEntity.fromJson(Map<String, dynamic> json) {
    comments ??= [];
    if (json['list']?.isNotEmpty ?? false) {
      for (var comment in json['list']) {
        comments.add(CommentEntity.fromJson(comment));
      }
    }
  }
}

/// 评论实体
class CommentEntity implements ToJson {
  String anonymousName;
  String phoneNumber;
  int postId;
  int commentId;
  String date;
  String body;

  @override
  Map<String, dynamic> toJson() {
    return {
      'anonymname': anonymousName,
      'cid': commentId,
      'mid': postId,
      'phonenumber': phoneNumber,
      'cdate': date,
      'cbody': body,
    };
  }

  CommentEntity.fromJson(Map<String, dynamic> json) {
    anonymousName = json['anonymname'];
    commentId = json['cid'];
    postId = json['mid'];
    phoneNumber = json['phonenumber'];
    date = json['cdate'];
    body = json['cbody'];
  }
}
