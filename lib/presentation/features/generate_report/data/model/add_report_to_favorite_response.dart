class AddReportToFavoriteResponse {
  final bool? status;
  final String? message;
  final List<String>? favServices;

  AddReportToFavoriteResponse({
    this.status,
    this.message,
    this.favServices,
  });

  AddReportToFavoriteResponse copyWith({
    bool? status,
    String? message,
    List<String>? favServices,
  }) =>
      AddReportToFavoriteResponse(
        status: status ?? this.status,
        message: message ?? this.message,
        favServices: favServices ?? this.favServices,
      );

  factory AddReportToFavoriteResponse.fromJson(Map<String, dynamic> json) =>
      AddReportToFavoriteResponse(
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
