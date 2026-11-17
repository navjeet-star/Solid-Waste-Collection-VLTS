// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tokens_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TokensModel _$TokensModelFromJson(Map<String, dynamic> json) => TokensModel(
      accessToken: json['AccessToken'] as String?,
      refreshToken: json['RefreshToken'] as String?,
    );

Map<String, dynamic> _$TokensModelToJson(TokensModel instance) =>
    <String, dynamic>{
      'AccessToken': instance.accessToken,
      'RefreshToken': instance.refreshToken,
    };
