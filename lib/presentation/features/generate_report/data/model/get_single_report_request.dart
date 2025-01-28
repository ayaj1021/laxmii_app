class GetSingleReportRequest {
  final String type;
  final String period;
  final DateTime startDate;
  final DateTime endDate;

  GetSingleReportRequest({
    required this.type,
    required this.period,
    required this.startDate,
    required this.endDate,
  });

  GetSingleReportRequest copyWith({
    String? type,
    String? period,
    DateTime? startDate,
    DateTime? endDate,
  }) =>
      GetSingleReportRequest(
        type: type ?? this.type,
        period: period ?? this.period,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
      );

  factory GetSingleReportRequest.fromJson(Map<String, dynamic> json) =>
      GetSingleReportRequest(
        type: json["type"],
        period: json["period"],
        startDate: DateTime.parse(json["startDate"]),
        endDate: DateTime.parse(json["endDate"]),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "period": period,
        "startDate":
            "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "endDate":
            "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
      };
}
