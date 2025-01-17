
class LoginResponse {
    final bool? status;
    final String? name;
    final String? email;
    final String? accessToken;
    final String? refreshToken;

    LoginResponse({
        this.status,
        this.name,
        this.email,
        this.accessToken,
        this.refreshToken,
    });

    LoginResponse copyWith({
        bool? status,
        String? name,
        String? email,
        String? accessToken,
        String? refreshToken,
    }) => 
        LoginResponse(
            status: status ?? this.status,
            name: name ?? this.name,
            email: email ?? this.email,
            accessToken: accessToken ?? this.accessToken,
            refreshToken: refreshToken ?? this.refreshToken,
        );

    factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        status: json["status"],
        name: json["name"],
        email: json["email"],
        accessToken: json["accessToken"],
        refreshToken: json["refreshToken"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "name": name,
        "email": email,
        "accessToken": accessToken,
        "refreshToken": refreshToken,
    };
}
