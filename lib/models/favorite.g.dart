// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Favorite _$FavoriteFromJson(Map<String, dynamic> json) => Favorite()
  ..id = json['id'] as num
  ..user = User.fromJson(json['user'] as Map<String, dynamic>)
  ..post = Post.fromJson(json['post'] as Map<String, dynamic>);

Map<String, dynamic> _$FavoriteToJson(Favorite instance) => <String, dynamic>{
      'id': instance.id,
      'user': instance.user,
      'post': instance.post,
    };
