class TokensModel {
  String? accessToken;
  String? refreshToken;

  TokensModel({
    this.accessToken,
    this.refreshToken,
  });

  TokensModel.fromJson(dynamic json) {
    if (json is Map) {
      accessToken = json['AccessToken'] as String?;
      refreshToken = json['RefreshToken'] as String?;
    }
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['AccessToken'] = accessToken;
    map['RefreshToken'] = refreshToken;
    return map;
  }
}

