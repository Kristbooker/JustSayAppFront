// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'likes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Likes _$LikesFromJson(Map<String, dynamic> json) => Likes()
  ..likes = (json['likes'] as List<dynamic>)
      .map((e) => Like.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$LikesToJson(Likes instance) => <String, dynamic>{
      'likes': instance.likes,
    };
