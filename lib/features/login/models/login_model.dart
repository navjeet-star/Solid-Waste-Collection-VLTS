import 'package:equatable/equatable.dart';
import 'profile_detail.dart';
import 'tokens_model.dart';

/// MVVM Domain/Data Model representing authentication response and user data.
class LoginModel extends Equatable {
  final String? loginId;
  final String? name;
  final String? emailId;
  final String? mobileNo;
  final String? roleId;
  final String? roleName;
  final String? userLevelId;
  final String? userLevel;
  final String? districtId;
  final String? district;
  final String? ulbId;
  final String? ulb;
  final String? wardId;
  final String? ward;
  final String? designation;
  final String? employeeId;
  final String? accessToken;
  final String? refreshToken;
  final String? code;
  final String? message;
  final TokensModel? tokens;
  final ProfileDetail? profileDetail;

  const LoginModel({
    this.code,
    this.message,
    this.tokens,
    this.profileDetail,
    this.loginId,
    this.name,
    this.emailId,
    this.mobileNo,
    this.roleId,
    this.roleName,
    this.userLevelId,
    this.userLevel,
    this.districtId,
    this.district,
    this.ulbId,
    this.ulb,
    this.wardId,
    this.ward,
    this.designation,
    this.employeeId,
    this.accessToken,
    this.refreshToken,
  });

  factory LoginModel.fromJson(dynamic json) {
    if (json is! Map<String, dynamic>) {
      return const LoginModel();
    }

    final tokens = json['Tokens'] != null ? TokensModel.fromJson(json['Tokens']) : null;
    final profile = json['ProfileDetail'] != null ? ProfileDetail.fromJson(json['ProfileDetail']) : null;

    return LoginModel(
      code: json['Code'] as String?,
      message: json['Message'] as String?,
      tokens: tokens,
      profileDetail: profile,
      loginId: profile?.loginID,
      name: profile?.name,
      emailId: profile?.emailID,
      mobileNo: profile?.mobileNo,
      roleId: profile?.roleID,
      roleName: profile?.roleName,
      userLevelId: profile?.userLevelID,
      userLevel: profile?.userLevel,
      districtId: profile?.districtID,
      district: profile?.district,
      ulbId: profile?.ulbid,
      ulb: profile?.ulb,
      wardId: profile?.wardID,
      ward: profile?.ward,
      designation: profile?.designation,
      employeeId: profile?.employeeID,
      accessToken: tokens?.accessToken,
      refreshToken: tokens?.refreshToken ?? profile?.refreshToken,
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Code'] = code;
    map['Message'] = message;
    if (tokens != null) {
      map['Tokens'] = tokens?.toJson();
    }
    if (profileDetail != null) {
      map['ProfileDetail'] = profileDetail?.toJson();
    }
    return map;
  }

  @override
  List<Object?> get props => [
        loginId,
        name,
        emailId,
        mobileNo,
        roleId,
        roleName,
        userLevelId,
        userLevel,
        districtId,
        district,
        ulbId,
        ulb,
        wardId,
        ward,
        designation,
        employeeId,
        accessToken,
        refreshToken,
        code,
        message,
        tokens,
        profileDetail,
      ];
}

/// Backwards compatibility alias for UserEntity
typedef UserEntity = LoginModel;

