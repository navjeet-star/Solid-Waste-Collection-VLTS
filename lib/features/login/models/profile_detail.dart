class ProfileDetail {
  String? loginID;
  String? name;
  String? mobileNo;
  String? roleID;
  String? roleName;
  String? userLevelID;
  String? userLevel;
  String? districtID;
  String? district;
  String? ulbid;
  String? ulb;
  String? wardID;
  String? ward;
  String? designation;
  String? refreshToken;
  String? refreshTokenCreationDateTime;
  String? emailID;
  String? employeeID;

  ProfileDetail({
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

  ProfileDetail.fromJson(dynamic json) {
    if (json is Map) {
      loginID = json['LoginID'] as String?;
      name = json['Name'] as String?;
      mobileNo = json['MobileNo'] as String?;
      roleID = json['RoleID'] as String?;
      roleName = json['RoleName'] as String?;
      userLevelID = json['UserLevelID'] as String?;
      userLevel = json['UserLevel'] as String?;
      districtID = json['DistrictID'] as String?;
      district = json['District'] as String?;
      ulbid = json['ULBID'] as String?;
      ulb = json['ULB'] as String?;
      wardID = json['WardID'] as String?;
      ward = json['Ward'] as String?;
      designation = json['Designation'] as String?;
      refreshToken = json['RefreshToken'] as String?;
      refreshTokenCreationDateTime = json['RefreshTokenCreationDateTime'] as String?;
      emailID = json['EmailID'] as String?;
      employeeID = json['EmployeeID'] as String?;
    }
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['LoginID'] = loginID;
    map['Name'] = name;
    map['MobileNo'] = mobileNo;
    map['RoleID'] = roleID;
    map['RoleName'] = roleName;
    map['UserLevelID'] = userLevelID;
    map['UserLevel'] = userLevel;
    map['DistrictID'] = districtID;
    map['District'] = district;
    map['ULBID'] = ulbid;
    map['ULB'] = ulb;
    map['WardID'] = wardID;
    map['Ward'] = ward;
    map['Designation'] = designation;
    map['RefreshToken'] = refreshToken;
    map['RefreshTokenCreationDateTime'] = refreshTokenCreationDateTime;
    map['EmailID'] = emailID;
    map['EmployeeID'] = employeeID;
    return map;
  }
}

