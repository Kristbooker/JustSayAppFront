import 'package:json_annotation/json_annotation.dart';
import "like.dart";
part 'likes.g.dart';

@JsonSerializable()
class Likes {
  Likes();

  late List<Like> likes;
  
  factory Likes.fromJson(Map<String,dynamic> json) => _$LikesFromJson(json);
  Map<String, dynamic> toJson() => _$LikesToJson(this);
}
