class LoginResponse {
  final bool? status;
  final String? name;
  final String? email;
  final bool? isVerified;
  final String? accessToken;
  final String? refreshToken;
  final bool? profileSetup;

  LoginResponse({
    this.status,
    this.name,
    this.email,
    this.isVerified,
    this.accessToken,
    this.refreshToken,
    this.profileSetup,
  });

  LoginResponse copyWith({
    bool? status,
    String? name,
    String? email,
    bool? isVerified,
    String? accessToken,
    String? refreshToken,
    bool? profileSetup,
  }) =>
      LoginResponse(
        status: status ?? this.status,
        name: name ?? this.name,
        email: email ?? this.email,
        isVerified: isVerified ?? this.isVerified,
        accessToken: accessToken ?? this.accessToken,
        refreshToken: refreshToken ?? this.refreshToken,
        profileSetup: profileSetup ?? this.profileSetup,
      );

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        status: json["status"],
        name: json["name"],
        email: json["email"],
        isVerified: json["isVerified"],
        accessToken: json["accessToken"],
        refreshToken: json["refreshToken"],
        profileSetup: json["profileSetup"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "name": name,
        "email": email,
        "isVerified": isVerified,
        "accessToken": accessToken,
        "refreshToken": refreshToken,
        "profileSetup": profileSetup,
      };
}
