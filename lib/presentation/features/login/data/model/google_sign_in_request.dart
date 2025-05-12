class GoogleSignInRequest {
  final String idToken;

  GoogleSignInRequest({
    required this.idToken,
  });

  GoogleSignInRequest copyWith({
    String? idToken,
  }) =>
      GoogleSignInRequest(
        idToken: idToken ?? this.idToken,
      );

  factory GoogleSignInRequest.fromJson(Map<String, dynamic> json) =>
      GoogleSignInRequest(
        idToken: json["idToken"],
      );

  Map<String, dynamic> toJson() => {
        "idToken": idToken,
      };
}
