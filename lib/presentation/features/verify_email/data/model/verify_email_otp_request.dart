
class VerifyEmailOtpRequest {
    final String email;
    final String otp;

    VerifyEmailOtpRequest({
        required this.email,
        required this.otp,
    });

    VerifyEmailOtpRequest copyWith({
        String? email,
        String? otp,
    }) => 
        VerifyEmailOtpRequest(
            email: email ?? this.email,
            otp: otp ?? this.otp,
        );

    factory VerifyEmailOtpRequest.fromJson(Map<String, dynamic> json) => VerifyEmailOtpRequest(
        email: json["email"],
        otp: json["otp"],
    );

    Map<String, dynamic> toJson() => {
        "email": email,
        "otp": otp,
    };
}
