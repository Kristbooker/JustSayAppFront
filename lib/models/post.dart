import 'package:json_annotation/json_annotation.dart';
import "user.dart";
part 'post.g.dart';

@JsonSerializable()
class Post {
  Post();

  late num id;
  late User user;
  late String content;
  late String time;
  
  factory Post.fromJson(Map<String,dynamic> json) => _$PostFromJson(json);

  get comments => null;
  Map<String, dynamic> toJson() => _$PostToJson(this);
}
