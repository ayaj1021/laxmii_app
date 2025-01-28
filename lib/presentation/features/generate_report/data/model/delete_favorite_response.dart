class DeleteFavoriteReportResponse {
  final bool? status;
  final String? message;
  final List<String>? favServices;

  DeleteFavoriteReportResponse({
    this.status,
    this.message,
    this.favServices,
  });

  DeleteFavoriteReportResponse copyWith({
    bool? status,
    String? message,
    List<String>? favServices,
  }) =>
      DeleteFavoriteReportResponse(
        status: status ?? this.status,
        message: message ?? this.message,
        favServices: favServices ?? this.favServices,
      );

  factory DeleteFavoriteReportResponse.fromJson(Map<String, dynamic> json) =>
      DeleteFavoriteReportResponse(
        status: json["status"],
        message: json["message"],
        favServices: json["favServices"] == null
            ? []
            : List<String>.from(json["favServices"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "favServices": favServices == null
            ? []
            : List<dynamic>.from(favServices!.map((x) => x)),
      };
}
