class GetTotalProfitResponse {
  final bool? status;
  final num? salesTotal;
  final num? expenseTotal;
  final num? profit;

  GetTotalProfitResponse({
    this.status,
    this.salesTotal,
    this.expenseTotal,
    this.profit,
  });

  GetTotalProfitResponse copyWith({
    bool? status,
    num? salesTotal,
    num? expenseTotal,
    num? profit,
  }) =>
      GetTotalProfitResponse(
        status: status ?? this.status,
        salesTotal: salesTotal ?? this.salesTotal,
        expenseTotal: expenseTotal ?? this.expenseTotal,
        profit: profit ?? this.profit,
      );

  factory GetTotalProfitResponse.fromJson(Map<String, dynamic> json) =>
      GetTotalProfitResponse(
        status: json["status"],
        salesTotal: json["salesTotal"],
        expenseTotal: json["expenseTotal"] as num,
        profit: json["profit"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "salesTotal": salesTotal,
        "expenseTotal": expenseTotal,
        "profit": profit,
      };
}
