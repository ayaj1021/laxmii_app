class AddReportToFavoriteRequest {
  final String service;

  AddReportToFavoriteRequest({
    required this.service,
  });

  AddReportToFavoriteRequest copyWith({
    String? service,
  }) =>
      AddReportToFavoriteRequest(
        service: service ?? this.service,
      );

  factory AddReportToFavoriteRequest.fromJson(Map<String, dynamic> json) =>
      AddReportToFavoriteRequest(
        service: json["service"],
      );

  Map<String, dynamic> toJson() => {
        "service": service,
      };
}
