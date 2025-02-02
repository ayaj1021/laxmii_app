class GetInvoiceNumberResponse {
  final bool? status;
  final String? invoiceNumber;

  GetInvoiceNumberResponse({
    this.status,
    this.invoiceNumber,
  });

  GetInvoiceNumberResponse copyWith({
    bool? status,
    String? invoiceNumber,
  }) =>
      GetInvoiceNumberResponse(
        status: status ?? this.status,
        invoiceNumber: invoiceNumber ?? this.invoiceNumber,
      );

  factory GetInvoiceNumberResponse.fromJson(Map<String, dynamic> json) =>
      GetInvoiceNumberResponse(
        status: json["status"],
        invoiceNumber: json["invoiceNumber"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "invoiceNumber": invoiceNumber,
      };
}
