class DeleteReportFavoriteRequest {
  final String service;

  DeleteReportFavoriteRequest({
    required this.service,
  });

  DeleteReportFavoriteRequest copyWith({
    String? service,
  }) =>
      DeleteReportFavoriteRequest(
        service: service ?? this.service,
      );

  factory DeleteReportFavoriteRequest.fromJson(Map<String, dynamic> json) =>
      DeleteReportFavoriteRequest(
        service: json["service"],
      );

  Map<String, dynamic> toJson() => {
        "service": service,
      };
}
