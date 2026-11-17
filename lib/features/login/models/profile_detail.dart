import 'package:json_annotation/json_annotation.dart';

part 'profile_detail.g.dart';

@JsonSerializable()
class ProfileDetail {
  @JsonKey(name: 'LoginID')
  final String? loginID;

  @JsonKey(name: 'Name')
  final String? name;

  @JsonKey(name: 'MobileNo')
  final String? mobileNo;

  @JsonKey(name: 'RoleID')
  final String? roleID;

  @JsonKey(name: 'RoleName')
  final String? roleName;

  @JsonKey(name: 'UserLevelID')
  final String? userLevelID;

  @JsonKey(name: 'UserLevel')
  final String? userLevel;

  @JsonKey(name: 'DistrictID')
  final String? districtID;

  @JsonKey(name: 'District')
  final String? district;

  @JsonKey(name: 'ULBID')
  final String? ulbid;

  @JsonKey(name: 'ULB')
  final String? ulb;

  @JsonKey(name: 'WardID')
  final String? wardID;

  @JsonKey(name: 'Ward')
  final String? ward;

  @JsonKey(name: 'Designation')
  final String? designation;

  @JsonKey(name: 'RefreshToken')
  final String? refreshToken;

  @JsonKey(name: 'RefreshTokenCreationDateTime')
  final String? refreshTokenCreationDateTime;

  @JsonKey(name: 'EmailID')
  final String? emailID;

  @JsonKey(name: 'EmployeeID')
  final String? employeeID;

  const ProfileDetail({
    this.loginID,
    this.name,
    this.mobileNo,
    this.roleID,
    this.roleName,
    this.userLevelID,
    this.userLevel,
    this.districtID,
    this.district,
    this.ulbid,
    this.ulb,
    this.wardID,
    this.ward,
    this.designation,
    this.refreshToken,
    this.refreshTokenCreationDateTime,
    this.emailID,
    this.employeeID,
  });

  factory ProfileDetail.fromJson(Map<String, dynamic> json) =>
      _$ProfileDetailFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileDetailToJson(this);
}
