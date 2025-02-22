class GetQuoteNoResponse {
  final bool? status;
  final String? quoteNumber;

  GetQuoteNoResponse({
    this.status,
    this.quoteNumber,
  });

  GetQuoteNoResponse copyWith({
    bool? status,
    String? quoteNumber,
  }) =>
      GetQuoteNoResponse(
        status: status ?? this.status,
        quoteNumber: quoteNumber ?? this.quoteNumber,
      );

  factory GetQuoteNoResponse.fromJson(Map<String, dynamic> json) =>
      GetQuoteNoResponse(
        status: json["status"],
        quoteNumber: json["quoteNumber"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "quoteNumber": quoteNumber,
      };
}
