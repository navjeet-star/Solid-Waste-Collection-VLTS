import 'Tokens.dart';
import 'ProfileDetail.dart';

import 'dart:convert';

/// Code : 200
/// Message : "Login successful"
/// Tokens : {"AccessToken":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.access_token","RefreshToken":"refresh_token_123456789"}
/// ProfileDetail : {"LoginID":"USER001","Name":"John Doe","MobileNo":"9876543210","RoleID":"1","RoleName":"Administrator","UserLevelID":"1","UserLevel":"State Level","DistrictID":"101","District":"Mathura","ULBID":"1001","ULB":"Mathura Municipal Corporation","WardID":"10","Ward":"Ward 10","Designation":"System Administrator","RefreshToken":"refresh_token_123456789","RefreshTokenCreationDateTime":"2026-11-20T10:30:00","EmailID":"john.doe@example.com","EmployeeID":"EMP001"}

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  String? _code;
  String? _message;
  Tokens? _tokens;
  ProfileDetail? _profileDetail;

  LoginModel({
    String? code,
    String? message,
    Tokens? tokens,
    ProfileDetail? profileDetail,
  }) {
    _code = code;
    _message = message;
    _tokens = tokens;
    _profileDetail = profileDetail;
  }

  LoginModel.fromJson(dynamic json) {
    _code = json['Code'];
    _message = json['Message'];
    _tokens = json['Tokens'] != null ? Tokens.fromJson(json['Tokens']) : null;
    _profileDetail = json['ProfileDetail'] != null
        ? ProfileDetail.fromJson(json['ProfileDetail'])
        : null;
  }

  LoginModel copyWith({
    String? code,
    String? message,
    Tokens? tokens,
    ProfileDetail? profileDetail,
  }) => LoginModel(
    code: code ?? _code,
    message: message ?? _message,
    tokens: tokens ?? _tokens,
    profileDetail: profileDetail ?? _profileDetail,
  );

  String? get code => _code;

  String? get message => _message;

  Tokens? get tokens => _tokens;

  ProfileDetail? get profileDetail => _profileDetail;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Code'] = _code;
    map['Message'] = _message;
    if (_tokens != null) {
      map['Tokens'] = _tokens?.toJson();
    }
    if (_profileDetail != null) {
      map['ProfileDetail'] = _profileDetail?.toJson();
    }
    return map;
  }
}
