class GetAccessTokenResponse {
  final bool? status;
  final String? accessToken;

  GetAccessTokenResponse({
    this.status,
    this.accessToken,
  });

  GetAccessTokenResponse copyWith({
    bool? status,
    String? accessToken,
  }) =>
      GetAccessTokenResponse(
        status: status ?? this.status,
        accessToken: accessToken ?? this.accessToken,
      );

  factory GetAccessTokenResponse.fromJson(Map<String, dynamic> json) =>
      GetAccessTokenResponse(
        status: json["status"],
        accessToken: json["accessToken"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "accessToken": accessToken,
      };
}
