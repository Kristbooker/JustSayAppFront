// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'like.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Like _$LikeFromJson(Map<String, dynamic> json) => Like()
  ..id = json['id'] as num
  ..user = User.fromJson(json['user'] as Map<String, dynamic>)
  ..post = Post.fromJson(json['post'] as Map<String, dynamic>)
  ..time = json['time'] as String;

Map<String, dynamic> _$LikeToJson(Like instance) => <String, dynamic>{
      'id': instance.id,
      'user': instance.user,
      'post': instance.post,
      'time': instance.time,
    };
