import 'package:json_annotation/json_annotation.dart';
import "user.dart";
import "post.dart";
part 'favorite.g.dart';

@JsonSerializable()
class Favorite {
  Favorite();

  late num id;
  late User user;
  late Post post;
  
  factory Favorite.fromJson(Map<String,dynamic> json) => _$FavoriteFromJson(json);
  Map<String, dynamic> toJson() => _$FavoriteToJson(this);
}
