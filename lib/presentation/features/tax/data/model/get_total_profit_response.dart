class GetTotalProfitResponse {
  final bool? status;
  final int? salesTotal;
  final int? expenseTotal;
  final int? profit;

  GetTotalProfitResponse({
    this.status,
    this.salesTotal,
    this.expenseTotal,
    this.profit,
  });

  GetTotalProfitResponse copyWith({
    bool? status,
    int? salesTotal,
    int? expenseTotal,
    int? profit,
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
        expenseTotal: json["expenseTotal"],
        profit: json["profit"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "salesTotal": salesTotal,
        "expenseTotal": expenseTotal,
        "profit": profit,
      };
}
