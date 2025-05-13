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

// class MonthlyCashflow {
//   final MonthData? june;
//   final MonthData? july;
//   final MonthData? august;
//   final MonthData? september;
//   final MonthData? october;
//   final MonthData? november;
//   final MonthData? december;
//   final MonthData? january;
//   final MonthData? february;
//   final MonthData? march;
//   final MonthData? april;
//   final MonthData? may;

//   MonthlyCashflow({
//     this.june,
//     this.july,
//     this.august,
//     this.september,
//     this.october,
//     this.november,
//     this.december,
//     this.january,
//     this.february,
//     this.march,
//     this.april,
//     this.may,
//   });

//   MonthlyCashflow copyWith({
//     MonthData? june,
//     MonthData? july,
//     MonthData? august,
//     MonthData? september,
//     MonthData? october,
//     MonthData? november,
//     MonthData? december,
//     MonthData? january,
//     MonthData? february,
//     MonthData? march,
//     MonthData? april,
//     MonthData? may,
//   }) =>
//       MonthlyCashflow(
//         june: june ?? this.june,
//         july: july ?? this.july,
//         august: august ?? this.august,
//         september: september ?? this.september,
//         october: october ?? this.october,
//         november: november ?? this.november,
//         december: december ?? this.december,
//         january: january ?? this.january,
//         february: february ?? this.february,
//         march: march ?? this.march,
//         april: april ?? this.april,
//         may: may ?? this.may,
//       );

//   factory MonthlyCashflow.fromJson(Map<String, dynamic> json) =>
//       MonthlyCashflow(
//         june: json["June"] == null ? null : MonthData.fromJson(json["June"]),
//         july: json["July"] == null ? null : MonthData.fromJson(json["July"]),
//         august:
//             json["August"] == null ? null : MonthData.fromJson(json["August"]),
//         september: json["September"] == null
//             ? null
//             : MonthData.fromJson(json["September"]),
//         october: json["October"] == null
//             ? null
//             : MonthData.fromJson(json["October"]),
//         november: json["November"] == null
//             ? null
//             : MonthData.fromJson(json["November"]),
//         december: json["December"] == null
//             ? null
//             : MonthData.fromJson(json["December"]),
//         january: json["January"] == null
//             ? null
//             : MonthData.fromJson(json["January"]),
//         february: json["February"] == null
//             ? null
//             : MonthData.fromJson(json["February"]),
//         march: json["March"] == null ? null : MonthData.fromJson(json["March"]),
//         april: json["April"] == null ? null : MonthData.fromJson(json["April"]),
//         may: json["May"] == null ? null : MonthData.fromJson(json["May"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "June": june?.toJson(),
//         "July": july?.toJson(),
//         "August": august?.toJson(),
//         "September": september?.toJson(),
//         "October": october?.toJson(),
//         "November": november?.toJson(),
//         "December": december?.toJson(),
//         "January": january?.toJson(),
//         "February": february?.toJson(),
//         "March": march?.toJson(),
//         "April": april?.toJson(),
//         "May": may?.toJson(),
//       };
// }

// class April {
//   final int? invoice;
//   final int? expense;
//   final double? shopify;

//   April({
//     this.invoice,
//     this.expense,
//     this.shopify,
//   });

//   April copyWith({
//     int? invoice,
//     int? expense,
//     double? shopify,
//   }) =>
//       April(
//         invoice: invoice ?? this.invoice,
//         expense: expense ?? this.expense,
//         shopify: shopify ?? this.shopify,
//       );

//   factory April.fromJson(Map<String, dynamic> json) => April(
//         invoice: json["invoice"],
//         expense: json["expense"],
//         shopify: json["shopify"]?.toDouble(),
//       );

//   Map<String, dynamic> toJson() => {
//         "invoice": invoice,
//         "expense": expense,
//         "shopify": shopify,
//       };
// }

class MonthData {
  final num? invoice;
  final num? expense;
  final num? shopify;

  MonthData({
    this.invoice,
    this.expense,
    this.shopify,
  });

  MonthData copyWith({
    num? invoice,
    num? expense,
    num? shopify,
  }) =>
      MonthData(
        invoice: invoice ?? this.invoice,
        expense: expense ?? this.expense,
        shopify: shopify ?? this.shopify,
      );

  factory MonthData.fromJson(Map<String, dynamic> json) => MonthData(
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

// class May {
//   final double? invoice;
//   final int? expense;
//   final int? shopify;

//   May({
//     this.invoice,
//     this.expense,
//     this.shopify,
//   });

//   May copyWith({
//     double? invoice,
//     int? expense,
//     int? shopify,
//   }) =>
//       May(
//         invoice: invoice ?? this.invoice,
//         expense: expense ?? this.expense,
//         shopify: shopify ?? this.shopify,
//       );

//   factory May.fromJson(Map<String, dynamic> json) => May(
//         invoice: json["invoice"]?.toDouble(),
//         expense: json["expense"],
//         shopify: json["shopify"],
//       );

//   Map<String, dynamic> toJson() => {
//         "invoice": invoice,
//         "expense": expense,
//         "shopify": shopify,
//       };
// }
