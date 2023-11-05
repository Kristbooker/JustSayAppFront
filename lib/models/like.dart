import 'package:json_annotation/json_annotation.dart';
import "user.dart";
import "post.dart";
part 'like.g.dart';

@JsonSerializable()
class Like {
  Like();

  late num id;
  late User user;
  late Post post;
  late String time;
  
  factory Like.fromJson(Map<String,dynamic> json) => _$LikeFromJson(json);
  Map<String, dynamic> toJson() => _$LikeToJson(this);
}
