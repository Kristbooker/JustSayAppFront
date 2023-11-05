import 'package:json_annotation/json_annotation.dart';
import "user.dart";
import "post.dart";
part 'comment.g.dart';

@JsonSerializable()
class Comment {
  Comment();

  late num id;
  late User user;
  late Post post;
  late String content;
  late String time;
  
  factory Comment.fromJson(Map<String,dynamic> json) => _$CommentFromJson(json);
  Map<String, dynamic> toJson() => _$CommentToJson(this);
}
