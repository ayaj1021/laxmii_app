class GetAllReportsResponse {
  final bool? status;
  final List<String>? modelsWithData;

  GetAllReportsResponse({
    this.status,
    this.modelsWithData,
  });

  GetAllReportsResponse copyWith({
    bool? status,
    List<String>? modelsWithData,
  }) =>
      GetAllReportsResponse(
        status: status ?? this.status,
        modelsWithData: modelsWithData ?? this.modelsWithData,
      );

  factory GetAllReportsResponse.fromJson(Map<String, dynamic> json) =>
      GetAllReportsResponse(
        status: json["status"],
        modelsWithData: json["modelsWithData"] == null
            ? []
            : List<String>.from(json["modelsWithData"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "modelsWithData": modelsWithData == null
            ? []
            : List<dynamic>.from(modelsWithData!.map((x) => x)),
      };
}
