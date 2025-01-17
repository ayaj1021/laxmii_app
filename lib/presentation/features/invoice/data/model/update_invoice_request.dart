class UpdateInvoiceRequest {
  final String status;

  UpdateInvoiceRequest({
    required this.status,
  });

  UpdateInvoiceRequest copyWith({
    String? status,
  }) =>
      UpdateInvoiceRequest(
        status: status ?? this.status,
      );

  factory UpdateInvoiceRequest.fromJson(Map<String, dynamic> json) =>
      UpdateInvoiceRequest(
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
      };
}
