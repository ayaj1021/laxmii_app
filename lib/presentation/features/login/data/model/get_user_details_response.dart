class GetUserDetailsResponse {
  final bool? status;
  final String? userId;
  final String? fullName;
  final String? profilePicture;
  final String? currency;

  GetUserDetailsResponse({
    this.status,
    this.userId,
    this.fullName,
    this.profilePicture,
    this.currency,
  });

  GetUserDetailsResponse copyWith({
    bool? status,
    String? userId,
    String? fullName,
    String? profilePicture,
    String? currency,
  }) =>
      GetUserDetailsResponse(
        status: status ?? this.status,
        userId: userId ?? this.userId,
        fullName: fullName ?? this.fullName,
        profilePicture: profilePicture ?? this.profilePicture,
        currency: currency ?? this.currency,
      );

  factory GetUserDetailsResponse.fromJson(Map<String, dynamic> json) =>
      GetUserDetailsResponse(
        status: json["status"],
        userId: json["user_id"],
        fullName: json["fullName"],
        profilePicture: json["profilePicture"],
        currency: json["currency"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "user_id": userId,
        "fullName": fullName,
        "profilePicture": profilePicture,
        "currency": currency,
      };
}
