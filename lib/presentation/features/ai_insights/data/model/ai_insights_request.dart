class AiInsightsRequest {
  final String insightType;

  AiInsightsRequest({
    required this.insightType,
  });

  AiInsightsRequest copyWith({
    String? insightType,
  }) =>
      AiInsightsRequest(
        insightType: insightType ?? this.insightType,
      );

  factory AiInsightsRequest.fromJson(Map<String, dynamic> json) =>
      AiInsightsRequest(
        insightType: json["insightType"],
      );

  Map<String, dynamic> toJson() => {
        "insightType": insightType,
      };
}
