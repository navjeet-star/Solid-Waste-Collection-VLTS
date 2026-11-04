class AuthParams {
  AuthParams({
      this.loginID, 
      this.password, 
      this.salt,});

  AuthParams.fromJson(dynamic json) {
    loginID = json['LoginID'];
    password = json['Password'];
    salt = json['Salt'];
  }
  String? loginID;
  String? password;
  String? salt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['LoginID'] = loginID;
    map['Password'] = password;
    map['Salt'] = salt;
    return map;
  }

}