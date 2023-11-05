import 'package:json_annotation/json_annotation.dart';
import "favorite.dart";
part 'favorites.g.dart';

@JsonSerializable()
class Favorites {
  Favorites();

  late List<Favorite> favorites;
  
  factory Favorites.fromJson(Map<String,dynamic> json) => _$FavoritesFromJson(json);
  Map<String, dynamic> toJson() => _$FavoritesToJson(this);
}
