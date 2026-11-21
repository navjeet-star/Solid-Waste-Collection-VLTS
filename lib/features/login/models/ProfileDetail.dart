import 'dart:convert';

/// LoginID : "USER001"
/// Name : "John Doe"
/// MobileNo : "9876543210"
/// RoleID : "1"
/// RoleName : "Administrator"
/// UserLevelID : "1"
/// UserLevel : "State Level"
/// DistrictID : "101"
/// District : "Mathura"
/// ULBID : "1001"
/// ULB : "Mathura Municipal Corporation"
/// WardID : "10"
/// Ward : "Ward 10"
/// Designation : "System Administrator"
/// RefreshToken : "refresh_token_123456789"
/// RefreshTokenCreationDateTime : "2026-11-20T10:30:00"
/// EmailID : "john.doe@example.com"
/// EmployeeID : "EMP001"

ProfileDetail profileDetailFromJson(String str) => ProfileDetail.fromJson(json.decode(str));
String profileDetailToJson(ProfileDetail data) => json.encode(data.toJson());
class ProfileDetail {
  ProfileDetail({
      String? loginID, 
      String? name, 
      String? mobileNo, 
      String? roleID, 
      String? roleName, 
      String? userLevelID, 
      String? userLevel, 
      String? districtID, 
      String? district, 
      String? ulbid, 
      String? ulb, 
      String? wardID, 
      String? ward, 
      String? designation, 
      String? refreshToken, 
      String? refreshTokenCreationDateTime, 
      String? emailID, 
      String? employeeID,}){
    _loginID = loginID;
    _name = name;
    _mobileNo = mobileNo;
    _roleID = roleID;
    _roleName = roleName;
    _userLevelID = userLevelID;
    _userLevel = userLevel;
    _districtID = districtID;
    _district = district;
    _ulbid = ulbid;
    _ulb = ulb;
    _wardID = wardID;
    _ward = ward;
    _designation = designation;
    _refreshToken = refreshToken;
    _refreshTokenCreationDateTime = refreshTokenCreationDateTime;
    _emailID = emailID;
    _employeeID = employeeID;
}

  ProfileDetail.fromJson(dynamic json) {
    _loginID = json['LoginID'];
    _name = json['Name'];
    _mobileNo = json['MobileNo'];
    _roleID = json['RoleID'];
    _roleName = json['RoleName'];
    _userLevelID = json['UserLevelID'];
    _userLevel = json['UserLevel'];
    _districtID = json['DistrictID'];
    _district = json['District'];
    _ulbid = json['ULBID'];
    _ulb = json['ULB'];
    _wardID = json['WardID'];
    _ward = json['Ward'];
    _designation = json['Designation'];
    _refreshToken = json['RefreshToken'];
    _refreshTokenCreationDateTime = json['RefreshTokenCreationDateTime'];
    _emailID = json['EmailID'];
    _employeeID = json['EmployeeID'];
  }
  String? _loginID;
  String? _name;
  String? _mobileNo;
  String? _roleID;
  String? _roleName;
  String? _userLevelID;
  String? _userLevel;
  String? _districtID;
  String? _district;
  String? _ulbid;
  String? _ulb;
  String? _wardID;
  String? _ward;
  String? _designation;
  String? _refreshToken;
  String? _refreshTokenCreationDateTime;
  String? _emailID;
  String? _employeeID;
ProfileDetail copyWith({  String? loginID,
  String? name,
  String? mobileNo,
  String? roleID,
  String? roleName,
  String? userLevelID,
  String? userLevel,
  String? districtID,
  String? district,
  String? ulbid,
  String? ulb,
  String? wardID,
  String? ward,
  String? designation,
  String? refreshToken,
  String? refreshTokenCreationDateTime,
  String? emailID,
  String? employeeID,
}) => ProfileDetail(  loginID: loginID ?? _loginID,
  name: name ?? _name,
  mobileNo: mobileNo ?? _mobileNo,
  roleID: roleID ?? _roleID,
  roleName: roleName ?? _roleName,
  userLevelID: userLevelID ?? _userLevelID,
  userLevel: userLevel ?? _userLevel,
  districtID: districtID ?? _districtID,
  district: district ?? _district,
  ulbid: ulbid ?? _ulbid,
  ulb: ulb ?? _ulb,
  wardID: wardID ?? _wardID,
  ward: ward ?? _ward,
  designation: designation ?? _designation,
  refreshToken: refreshToken ?? _refreshToken,
  refreshTokenCreationDateTime: refreshTokenCreationDateTime ?? _refreshTokenCreationDateTime,
  emailID: emailID ?? _emailID,
  employeeID: employeeID ?? _employeeID,
);
  String? get loginID => _loginID;
  String? get name => _name;
  String? get mobileNo => _mobileNo;
  String? get roleID => _roleID;
  String? get roleName => _roleName;
  String? get userLevelID => _userLevelID;
  String? get userLevel => _userLevel;
  String? get districtID => _districtID;
  String? get district => _district;
  String? get ulbid => _ulbid;
  String? get ulb => _ulb;
  String? get wardID => _wardID;
  String? get ward => _ward;
  String? get designation => _designation;
  String? get refreshToken => _refreshToken;
  String? get refreshTokenCreationDateTime => _refreshTokenCreationDateTime;
  String? get emailID => _emailID;
  String? get employeeID => _employeeID;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['LoginID'] = _loginID;
    map['Name'] = _name;
    map['MobileNo'] = _mobileNo;
    map['RoleID'] = _roleID;
    map['RoleName'] = _roleName;
    map['UserLevelID'] = _userLevelID;
    map['UserLevel'] = _userLevel;
    map['DistrictID'] = _districtID;
    map['District'] = _district;
    map['ULBID'] = _ulbid;
    map['ULB'] = _ulb;
    map['WardID'] = _wardID;
    map['Ward'] = _ward;
    map['Designation'] = _designation;
    map['RefreshToken'] = _refreshToken;
    map['RefreshTokenCreationDateTime'] = _refreshTokenCreationDateTime;
    map['EmailID'] = _emailID;
    map['EmployeeID'] = _employeeID;
    return map;
  }

}