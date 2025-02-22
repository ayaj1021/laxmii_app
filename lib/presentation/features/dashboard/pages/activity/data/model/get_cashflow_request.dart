class GetCashFlowRequest {
  final String queryBy;

  GetCashFlowRequest({
    required this.queryBy,
  });

  GetCashFlowRequest copyWith({
    String? queryBy,
  }) =>
      GetCashFlowRequest(
        queryBy: queryBy ?? this.queryBy,
      );

  factory GetCashFlowRequest.fromJson(Map<String, dynamic> json) =>
      GetCashFlowRequest(
        queryBy: json["queryBy"],
      );

  Map<String, dynamic> toJson() => {
        "queryBy": queryBy,
      };
}
