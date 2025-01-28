class GetAllFavoriteResponse {
  final bool? status;
  final List<String>? favServices;

  GetAllFavoriteResponse({
    this.status,
    this.favServices,
  });

  GetAllFavoriteResponse copyWith({
    bool? status,
    List<String>? favServices,
  }) =>
      GetAllFavoriteResponse(
        status: status ?? this.status,
        favServices: favServices ?? this.favServices,
      );

  factory GetAllFavoriteResponse.fromJson(Map<String, dynamic> json) =>
      GetAllFavoriteResponse(
        status: json["status"],
        favServices: json["favServices"] == null
            ? []
            : List<String>.from(json["favServices"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "favServices": favServices == null
            ? []
            : List<dynamic>.from(favServices!.map((x) => x)),
      };
}
