import 'package:json_annotation/json_annotation.dart';

part 'tokens_model.g.dart';

@JsonSerializable()
class TokensModel {
  @JsonKey(name: 'AccessToken')
  final String? accessToken;

  @JsonKey(name: 'RefreshToken')
  final String? refreshToken;

  const TokensModel({
    this.accessToken,
    this.refreshToken,
  });

  factory TokensModel.fromJson(Map<String, dynamic> json) =>
      _$TokensModelFromJson(json);

  Map<String, dynamic> toJson() => _$TokensModelToJson(this);
}
