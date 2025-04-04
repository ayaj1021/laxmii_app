// class GetCashFlowResponse {
//   final bool? status;
//   final List<CashFlowData>? cashflow;

//   GetCashFlowResponse({
//     this.status,
//     this.cashflow,
//   });

//   GetCashFlowResponse copyWith({
//     bool? status,
//     List<CashFlowData>? cashflow,
//   }) =>
//       GetCashFlowResponse(
//         status: status ?? this.status,
//         cashflow: cashflow ?? this.cashflow,
//       );

//   factory GetCashFlowResponse.fromJson(Map<String, dynamic> json) =>
//       GetCashFlowResponse(
//         status: json["status"],
//         cashflow: json["cashflow"] == null
//             ? []
//             : List<CashFlowData>.from(
//                 json["cashflow"]!.map((x) => CashFlowData.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "status": status,
//         "cashflow": cashflow == null
//             ? []
//             : List<dynamic>.from(cashflow!.map((x) => x.toJson())),
//       };
// }

// class CashFlowData {
//   final April? march;
//   final April? april;
//   final April? may;
//   final April? june;
//   final April? july;
//   final April? august;
//   final April? september;
//   final April? october;
//   final April? november;
//   final April? december;
//   final April? january;
//   final February? february;

//   CashFlowData({
//     this.march,
//     this.april,
//     this.may,
//     this.june,
//     this.july,
//     this.august,
//     this.september,
//     this.october,
//     this.november,
//     this.december,
//     this.january,
//     this.february,
//   });

//   CashFlowData copyWith({
//     April? march,
//     April? april,
//     April? may,
//     April? june,
//     April? july,
//     April? august,
//     April? september,
//     April? october,
//     April? november,
//     April? december,
//     April? january,
//     February? february,
//   }) =>
//       CashFlowData(
//         march: march ?? this.march,
//         april: april ?? this.april,
//         may: may ?? this.may,
//         june: june ?? this.june,
//         july: july ?? this.july,
//         august: august ?? this.august,
//         september: september ?? this.september,
//         october: october ?? this.october,
//         november: november ?? this.november,
//         december: december ?? this.december,
//         january: january ?? this.january,
//         february: february ?? this.february,
//       );

//   factory CashFlowData.fromJson(Map<String, dynamic> json) => CashFlowData(
//         march: json["March"] == null ? null : April.fromJson(json["March"]),
//         april: json["April"] == null ? null : April.fromJson(json["April"]),
//         may: json["May"] == null ? null : April.fromJson(json["May"]),
//         june: json["June"] == null ? null : April.fromJson(json["June"]),
//         july: json["July"] == null ? null : April.fromJson(json["July"]),
//         august: json["August"] == null ? null : April.fromJson(json["August"]),
//         september: json["September"] == null
//             ? null
//             : April.fromJson(json["September"]),
//         october:
//             json["October"] == null ? null : April.fromJson(json["October"]),
//         november:
//             json["November"] == null ? null : April.fromJson(json["November"]),
//         december:
//             json["December"] == null ? null : April.fromJson(json["December"]),
//         january:
//             json["January"] == null ? null : April.fromJson(json["January"]),
//         february: json["February"] == null
//             ? null
//             : February.fromJson(json["February"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "March": march?.toJson(),
//         "April": april?.toJson(),
//         "May": may?.toJson(),
//         "June": june?.toJson(),
//         "July": july?.toJson(),
//         "August": august?.toJson(),
//         "September": september?.toJson(),
//         "October": october?.toJson(),
//         "November": november?.toJson(),
//         "December": december?.toJson(),
//         "January": january?.toJson(),
//         "February": february?.toJson(),
//       };
// }

// class April {
//   final int? invoice;
//   final double? expense;

//   April({
//     this.invoice,
//     this.expense,
//   });

//   April copyWith({
//     int? invoice,
//     double? expense,
//   }) =>
//       April(
//         invoice: invoice ?? this.invoice,
//         expense: expense ?? this.expense,
//       );

//   factory April.fromJson(Map<String, dynamic> json) => April(
//         invoice: json["invoice"],
//         expense: json["expense"]?.toDouble(),
//       );

//   Map<String, dynamic> toJson() => {
//         "invoice": invoice,
//         "expense": expense,
//       };
// }

// class February {
//   final int? invoice;
//   final num? expense;

//   February({
//     this.invoice,
//     this.expense,
//   });

//   February copyWith({
//     int? invoice,
//     num? expense,
//   }) =>
//       February(
//         invoice: invoice ?? this.invoice,
//         expense: expense ?? this.expense,
//       );

//   factory February.fromJson(Map<String, dynamic> json) => February(
//         invoice: json["invoice"],
//         expense: json["expense"],
//       );

//   Map<String, dynamic> toJson() => {
//         "invoice": invoice,
//         "expense": expense,
//       };
// }

// To parse this JSON data, do
//
//     final getCashFlowResponse = getCashFlowResponseFromJson(jsonString);

import 'dart:convert';

GetCashFlowResponse getCashFlowResponseFromJson(String str) =>
    GetCashFlowResponse.fromJson(json.decode(str));

String getCashFlowResponseToJson(GetCashFlowResponse data) =>
    json.encode(data.toJson());

class GetCashFlowResponse {
  final bool? status;
  final List<CashFlowData>? cashflow;

  GetCashFlowResponse({
    this.status,
    this.cashflow,
  });

  GetCashFlowResponse copyWith({
    bool? status,
    List<CashFlowData>? cashflow,
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
            : List<CashFlowData>.from(
                json["cashflow"]!.map((x) => CashFlowData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "cashflow": cashflow == null
            ? []
            : List<dynamic>.from(cashflow!.map((x) => x.toJson())),
      };
}

class CashFlowData {
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

  CashFlowData({
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

  CashFlowData copyWith({
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
      CashFlowData(
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

  factory CashFlowData.fromJson(Map<String, dynamic> json) => CashFlowData(
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
