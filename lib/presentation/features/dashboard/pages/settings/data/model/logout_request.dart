class LogoutRequest {
  final String refreshToken;

  LogoutRequest({
    required this.refreshToken,
  });

  LogoutRequest copyWith({
    String? refreshToken,
  }) =>
      LogoutRequest(
        refreshToken: refreshToken ?? this.refreshToken,
      );

  factory LogoutRequest.fromJson(Map<String, dynamic> json) => LogoutRequest(
        refreshToken: json["refreshToken"],
      );

  Map<String, dynamic> toJson() => {
        "refreshToken": refreshToken,
      };
}
