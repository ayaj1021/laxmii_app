
class GetAccessTokenRequest {
    final String token;

    GetAccessTokenRequest({
        required this.token,
    });

    GetAccessTokenRequest copyWith({
        String? token,
    }) => 
        GetAccessTokenRequest(
            token: token ?? this.token,
        );

    factory GetAccessTokenRequest.fromJson(Map<String, dynamic> json) => GetAccessTokenRequest(
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "token": token,
    };
}
