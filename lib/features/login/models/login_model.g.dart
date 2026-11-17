// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginModel _$LoginModelFromJson(Map<String, dynamic> json) => LoginModel(
      code: json['Code'] as String?,
      message: json['Message'] as String?,
      tokens: json['Tokens'] == null
          ? null
          : TokensModel.fromJson(json['Tokens'] as Map<String, dynamic>),
      profileDetail: json['ProfileDetail'] == null
          ? null
          : ProfileDetail.fromJson(
              json['ProfileDetail'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LoginModelToJson(LoginModel instance) =>
    <String, dynamic>{
      'Code': instance.code,
      'Message': instance.message,
      'Tokens': instance.tokens?.toJson(),
      'ProfileDetail': instance.profileDetail?.toJson(),
    };
