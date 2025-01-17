class SignUpResponse {
    final bool status;
    final String message;

    SignUpResponse({
        required this.status,
        required this.message,
    });

    SignUpResponse copyWith({
        bool? status,
        String? message,
    }) => 
        SignUpResponse(
            status: status ?? this.status,
            message: message ?? this.message,
        );

    factory SignUpResponse.fromJson(Map<String, dynamic> json) => SignUpResponse(
        status: json["status"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
    };
}
