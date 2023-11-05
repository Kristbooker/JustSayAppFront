// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User()
  ..id = json['id'] as num
  ..userName = json['userName'] as String
  ..firstName = json['firstName'] as String
  ..lastName = json['lastName'] as String
  ..password = json['password'] as String
  ..bio = json['bio'] as String
  ..proImg = json['proImg'] as String;

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'userName': instance.userName,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'password': instance.password,
      'bio': instance.bio,
      'proImg': instance.proImg,
    };
