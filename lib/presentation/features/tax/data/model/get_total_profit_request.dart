class GetTotalProfitRequest {
  final DateTime startDate;
  final DateTime endDate;

  GetTotalProfitRequest({
    required this.startDate,
    required this.endDate,
  });

  GetTotalProfitRequest copyWith({
    DateTime? startDate,
    DateTime? endDate,
  }) =>
      GetTotalProfitRequest(
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
      );

  factory GetTotalProfitRequest.fromJson(Map<String, dynamic> json) =>
      GetTotalProfitRequest(
        startDate: DateTime.parse(json["startDate"]),
        endDate: DateTime.parse(json["endDate"]),
      );

  Map<String, dynamic> toJson() => {
        "startDate":
            "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "endDate":
            "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
      };
}
