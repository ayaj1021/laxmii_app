class AiInsightsResponse {
  final bool? status;
  final AiInsights? aiInsights;

  AiInsightsResponse({
    this.status,
    this.aiInsights,
  });

  AiInsightsResponse copyWith({
    bool? status,
    AiInsights? aiInsights,
  }) =>
      AiInsightsResponse(
        status: status ?? this.status,
        aiInsights: aiInsights ?? this.aiInsights,
      );

  factory AiInsightsResponse.fromJson(Map<String, dynamic> json) =>
      AiInsightsResponse(
        status: json["status"],
        aiInsights: json["ai_insights"] == null
            ? null
            : AiInsights.fromJson(json["ai_insights"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "ai_insights": aiInsights?.toJson(),
      };
}

class AiInsights {
  final List<String>? summary;
  final List<String>? insights;
  final List<String>? recommendations;
  final List<String>? keyTakeaways;

  AiInsights({
    this.summary,
    this.insights,
    this.recommendations,
    this.keyTakeaways,
  });

  AiInsights copyWith({
    List<String>? summary,
    List<String>? insights,
    List<String>? recommendations,
    List<String>? keyTakeaways,
  }) =>
      AiInsights(
        summary: summary ?? this.summary,
        insights: insights ?? this.insights,
        recommendations: recommendations ?? this.recommendations,
        keyTakeaways: keyTakeaways ?? this.keyTakeaways,
      );

  factory AiInsights.fromJson(Map<String, dynamic> json) => AiInsights(
        summary: json["summary"] == null
            ? []
            : List<String>.from(json["summary"]!.map((x) => x)),
        insights: json["insights"] == null
            ? []
            : List<String>.from(json["insights"]!.map((x) => x)),
        recommendations: json["recommendations"] == null
            ? []
            : List<String>.from(json["recommendations"]!.map((x) => x)),
        keyTakeaways: json["key_takeaways"] == null
            ? []
            : List<String>.from(json["key_takeaways"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "summary":
            summary == null ? [] : List<dynamic>.from(summary!.map((x) => x)),
        "insights":
            insights == null ? [] : List<dynamic>.from(insights!.map((x) => x)),
        "recommendations": recommendations == null
            ? []
            : List<dynamic>.from(recommendations!.map((x) => x)),
        "key_takeaways": keyTakeaways == null
            ? []
            : List<dynamic>.from(keyTakeaways!.map((x) => x)),
      };
}
