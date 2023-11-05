// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorites.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Favorites _$FavoritesFromJson(Map<String, dynamic> json) => Favorites()
  ..favorites = (json['favorites'] as List<dynamic>)
      .map((e) => Favorite.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$FavoritesToJson(Favorites instance) => <String, dynamic>{
      'favorites': instance.favorites,
    };
