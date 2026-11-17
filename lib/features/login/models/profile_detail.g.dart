// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileDetail _$ProfileDetailFromJson(Map<String, dynamic> json) =>
    ProfileDetail(
      loginID: json['LoginID'] as String?,
      name: json['Name'] as String?,
      mobileNo: json['MobileNo'] as String?,
      roleID: json['RoleID'] as String?,
      roleName: json['RoleName'] as String?,
      userLevelID: json['UserLevelID'] as String?,
      userLevel: json['UserLevel'] as String?,
      districtID: json['DistrictID'] as String?,
      district: json['District'] as String?,
      ulbid: json['ULBID'] as String?,
      ulb: json['ULB'] as String?,
      wardID: json['WardID'] as String?,
      ward: json['Ward'] as String?,
      designation: json['Designation'] as String?,
      refreshToken: json['RefreshToken'] as String?,
      refreshTokenCreationDateTime:
          json['RefreshTokenCreationDateTime'] as String?,
      emailID: json['EmailID'] as String?,
      employeeID: json['EmployeeID'] as String?,
    );

Map<String, dynamic> _$ProfileDetailToJson(ProfileDetail instance) =>
    <String, dynamic>{
      'LoginID': instance.loginID,
      'Name': instance.name,
      'MobileNo': instance.mobileNo,
      'RoleID': instance.roleID,
      'RoleName': instance.roleName,
      'UserLevelID': instance.userLevelID,
      'UserLevel': instance.userLevel,
      'DistrictID': instance.districtID,
      'District': instance.district,
      'ULBID': instance.ulbid,
      'ULB': instance.ulb,
      'WardID': instance.wardID,
      'Ward': instance.ward,
      'Designation': instance.designation,
      'RefreshToken': instance.refreshToken,
      'RefreshTokenCreationDateTime': instance.refreshTokenCreationDateTime,
      'EmailID': instance.emailID,
      'EmployeeID': instance.employeeID,
    };
