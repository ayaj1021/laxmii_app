class GetGraphDetailsRequest {
  final String type;
  final String queryBy;
  final DateTime date;

  GetGraphDetailsRequest({
    required this.type,
    required this.queryBy,
    required this.date,
  });

  GetGraphDetailsRequest copyWith({
    String? type,
    String? queryBy,
    DateTime? date,
  }) =>
      GetGraphDetailsRequest(
        type: type ?? this.type,
        queryBy: queryBy ?? this.queryBy,
        date: date ?? this.date,
      );

  factory GetGraphDetailsRequest.fromJson(Map<String, dynamic> json) =>
      GetGraphDetailsRequest(
        type: json["type"],
        queryBy: json["queryBy"],
        date: DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "queryBy": queryBy,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
      };
}
