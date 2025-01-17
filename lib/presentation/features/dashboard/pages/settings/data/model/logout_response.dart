
class LogoutResponse {
    final bool? status;
    final String? message;

    LogoutResponse({
        this.status,
        this.message,
    });

    LogoutResponse copyWith({
        bool? status,
        String? message,
    }) => 
        LogoutResponse(
            status: status ?? this.status,
            message: message ?? this.message,
        );

    factory LogoutResponse.fromJson(Map<String, dynamic> json) => LogoutResponse(
        status: json["status"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
    };
}
