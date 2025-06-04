class MonthlyCashFlowResponse {
  final bool? status;
  final List<GetMonthlyCashflow>? cashflow;

  MonthlyCashFlowResponse({
    this.status,
    this.cashflow,
  });

  MonthlyCashFlowResponse copyWith({
    bool? status,
    List<GetMonthlyCashflow>? cashflow,
  }) =>
      MonthlyCashFlowResponse(
        status: status ?? this.status,
        cashflow: cashflow ?? this.cashflow,
      );

  factory MonthlyCashFlowResponse.fromJson(Map<String, dynamic> json) =>
      MonthlyCashFlowResponse(
        status: json["status"],
        cashflow: json["cashflow"] == null
            ? []
            : List<GetMonthlyCashflow>.from(
                json["cashflow"]!.map((x) => GetMonthlyCashflow.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "cashflow": cashflow == null
            ? []
            : List<dynamic>.from(cashflow!.map((x) => x.toJson())),
      };
}

class GetMonthlyCashflow {
  final Map<String, MonthData> monthData;

  GetMonthlyCashflow({required this.monthData});

  // factory MonthlyCashflow.fromJson(Map<String, dynamic> json) {
  //   final parsedMap = <String, MonthData>{};
  //   json.forEach((key, value) {
  //     parsedMap[key] = MonthData.fromJson(value);
  //   });
  //   return MonthlyCashflow(monthData: parsedMap);
  // }

  factory GetMonthlyCashflow.fromJson(Map<String, dynamic> json) {
    final parsedMap = <String, MonthData>{};

    json.forEach((key, value) {
      if (value is Map<String, dynamic>) {
        parsedMap[key] = MonthData.fromJson(value);
      }
    });

    return GetMonthlyCashflow(monthData: parsedMap);
  }

  Map<String, dynamic> toJson() {
    return monthData.map((key, value) => MapEntry(key, value.toJson()));
  }
}

class MonthData {
  final num? invoice;
  final num? expense;
  final num? shopify;
  final String? date;

  MonthData({
    this.invoice,
    this.expense,
    this.shopify,
    this.date,
  });

  MonthData copyWith({
    num? invoice,
    num? expense,
    num? shopify,
    String? date,
  }) =>
      MonthData(
        invoice: invoice ?? this.invoice,
        expense: expense ?? this.expense,
        shopify: shopify ?? this.shopify,
        date: date ?? this.date,
      );

  factory MonthData.fromJson(Map<String, dynamic> json) => MonthData(
        invoice: json["sales"],
        expense: json["expense"],
        shopify: json["shopify"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "sales": invoice,
        "expense": expense,
        "shopify": shopify,
        "date": date,
      };
}
