import 'package:json_annotation/json_annotation.dart';
import 'package:vlts_swc/core/network/base_api_response.dart';
import 'profile_detail.dart';
import 'tokens_model.dart';

part 'login_model.g.dart';

/// MVVM Domain/Data Model representing authentication response and user data.
@JsonSerializable(explicitToJson: true)
class LoginModel extends BaseApiResponse {
  @JsonKey(name: 'Tokens')
  final TokensModel? tokens;

  @JsonKey(name: 'ProfileDetail')
  final ProfileDetail? profileDetail;

  const LoginModel({
    super.code,
    super.message,
    this.tokens,
    this.profileDetail,
  });

  // Convenience getters delegating to nested profile & token objects
  String? get loginId => profileDetail?.loginID;
  String? get name => profileDetail?.name;
  String? get emailId => profileDetail?.emailID;
  String? get mobileNo => profileDetail?.mobileNo;
  String? get roleId => profileDetail?.roleID;
  String? get roleName => profileDetail?.roleName;
  String? get userLevelId => profileDetail?.userLevelID;
  String? get userLevel => profileDetail?.userLevel;
  String? get districtId => profileDetail?.districtID;
  String? get district => profileDetail?.district;
  String? get ulbId => profileDetail?.ulbid;
  String? get ulb => profileDetail?.ulb;
  String? get wardId => profileDetail?.wardID;
  String? get ward => profileDetail?.ward;
  String? get designation => profileDetail?.designation;
  String? get employeeId => profileDetail?.employeeID;
  String? get accessToken => tokens?.accessToken;
  String? get refreshToken => tokens?.refreshToken ?? profileDetail?.refreshToken;

  factory LoginModel.fromJson(Map<String, dynamic> json) =>
      _$LoginModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoginModelToJson(this);

  @override
  List<Object?> get props => [code, message, tokens, profileDetail];
}
