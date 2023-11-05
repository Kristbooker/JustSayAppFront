// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comment _$CommentFromJson(Map<String, dynamic> json) => Comment()
  ..id = json['id'] as num
  ..user = User.fromJson(json['user'] as Map<String, dynamic>)
  ..post = Post.fromJson(json['post'] as Map<String, dynamic>)
  ..content = json['content'] as String
  ..time = json['time'] as String;

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      'id': instance.id,
      'user': instance.user,
      'post': instance.post,
      'content': instance.content,
      'time': instance.time,
    };
