import 'package:json_annotation/json_annotation.dart';
import "comment.dart";
part 'comments.g.dart';

@JsonSerializable()
class Comments {
  Comments();

  late List<Comment> comments;
  
  factory Comments.fromJson(Map<String,dynamic> json) => _$CommentsFromJson(json);
  Map<String, dynamic> toJson() => _$CommentsToJson(this);
}
