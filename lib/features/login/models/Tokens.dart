import 'dart:convert';

/// AccessToken : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.access_token"
/// RefreshToken : "refresh_token_123456789"

Tokens tokensFromJson(String str) => Tokens.fromJson(json.decode(str));
String tokensToJson(Tokens data) => json.encode(data.toJson());
class Tokens {
  Tokens({
      String? accessToken, 
      String? refreshToken,}){
    _accessToken = accessToken;
    _refreshToken = refreshToken;
}

  Tokens.fromJson(dynamic json) {
    _accessToken = json['AccessToken'];
    _refreshToken = json['RefreshToken'];
  }
  String? _accessToken;
  String? _refreshToken;
Tokens copyWith({  String? accessToken,
  String? refreshToken,
}) => Tokens(  accessToken: accessToken ?? _accessToken,
  refreshToken: refreshToken ?? _refreshToken,
);
  String? get accessToken => _accessToken;
  String? get refreshToken => _refreshToken;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['AccessToken'] = _accessToken;
    map['RefreshToken'] = _refreshToken;
    return map;
  }

}