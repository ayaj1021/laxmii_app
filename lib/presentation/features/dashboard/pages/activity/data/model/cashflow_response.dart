class GetCashFlowResponse {
  final bool? status;
  final List<CashflowResponseData>? cashflow;

  GetCashFlowResponse({
    this.status,
    this.cashflow,
  });

  GetCashFlowResponse copyWith({
    bool? status,
    List<CashflowResponseData>? cashflow,
  }) =>
      GetCashFlowResponse(
        status: status ?? this.status,
        cashflow: cashflow ?? this.cashflow,
      );

  factory GetCashFlowResponse.fromJson(Map<String, dynamic> json) =>
      GetCashFlowResponse(
        status: json["status"],
        cashflow: json["cashflow"] == null
            ? []
            : List<CashflowResponseData>.from(
                json["cashflow"]!.map((x) => CashflowResponseData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "cashflow": cashflow == null
            ? []
            : List<dynamic>.from(cashflow!.map((x) => x.toJson())),
      };
}

class CashflowResponseData {
  final April? may;
  final April? june;
  final April? july;
  final April? august;
  final April? september;
  final April? october;
  final April? november;
  final April? december;
  final April? january;
  final April? february;
  final April? march;
  final April? april;

  CashflowResponseData({
    this.may,
    this.june,
    this.july,
    this.august,
    this.september,
    this.october,
    this.november,
    this.december,
    this.january,
    this.february,
    this.march,
    this.april,
  });

  CashflowResponseData copyWith({
    April? may,
    April? june,
    April? july,
    April? august,
    April? september,
    April? october,
    April? november,
    April? december,
    April? january,
    April? february,
    April? march,
    April? april,
  }) =>
      CashflowResponseData(
        may: may ?? this.may,
        june: june ?? this.june,
        july: july ?? this.july,
        august: august ?? this.august,
        september: september ?? this.september,
        october: october ?? this.october,
        november: november ?? this.november,
        december: december ?? this.december,
        january: january ?? this.january,
        february: february ?? this.february,
        march: march ?? this.march,
        april: april ?? this.april,
      );

  factory CashflowResponseData.fromJson(Map<String, dynamic> json) =>
      CashflowResponseData(
        may: json["May"] == null ? null : April.fromJson(json["May"]),
        june: json["June"] == null ? null : April.fromJson(json["June"]),
        july: json["July"] == null ? null : April.fromJson(json["July"]),
        august: json["August"] == null ? null : April.fromJson(json["August"]),
        september: json["September"] == null
            ? null
            : April.fromJson(json["September"]),
        october:
            json["October"] == null ? null : April.fromJson(json["October"]),
        november:
            json["November"] == null ? null : April.fromJson(json["November"]),
        december:
            json["December"] == null ? null : April.fromJson(json["December"]),
        january:
            json["January"] == null ? null : April.fromJson(json["January"]),
        february:
            json["February"] == null ? null : April.fromJson(json["February"]),
        march: json["March"] == null ? null : April.fromJson(json["March"]),
        april: json["April"] == null ? null : April.fromJson(json["April"]),
      );

  Map<String, dynamic> toJson() => {
        "May": may?.toJson(),
        "June": june?.toJson(),
        "July": july?.toJson(),
        "August": august?.toJson(),
        "September": september?.toJson(),
        "October": october?.toJson(),
        "November": november?.toJson(),
        "December": december?.toJson(),
        "January": january?.toJson(),
        "February": february?.toJson(),
        "March": march?.toJson(),
        "April": april?.toJson(),
      };
}

class April {
  final int? invoice;
  final int? expense;
  final int? shopify;

  April({
    this.invoice,
    this.expense,
    this.shopify,
  });

  April copyWith({
    int? invoice,
    int? expense,
    int? shopify,
  }) =>
      April(
        invoice: invoice ?? this.invoice,
        expense: expense ?? this.expense,
        shopify: shopify ?? this.shopify,
      );

  factory April.fromJson(Map<String, dynamic> json) => April(
        invoice: json["invoice"],
        expense: json["expense"],
        shopify: json["shopify"],
      );

  Map<String, dynamic> toJson() => {
        "invoice": invoice,
        "expense": expense,
        "shopify": shopify,
      };
}
