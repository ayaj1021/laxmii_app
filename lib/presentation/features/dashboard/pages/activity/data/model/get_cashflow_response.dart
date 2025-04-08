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

class CashflowResponse {
  final bool? status;
  final List<MonthlyCashflow>? cashflow;

  CashflowResponse({this.status, this.cashflow});

  factory CashflowResponse.fromJson(Map<String, dynamic> json) {
    return CashflowResponse(
      status: json['status'],
      cashflow: (json['cashflow'] as List<dynamic>?)
          ?.map((e) => MonthlyCashflow.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class MonthlyCashflow {
  final Map<String, MonthlyData>? monthData;

  MonthlyCashflow({this.monthData});

  factory MonthlyCashflow.fromJson(Map<String, dynamic> json) {
    final mapped = <String, MonthlyData>{};
    json.forEach((key, value) {
      mapped[key] = MonthlyData.fromJson(value);
    });
    return MonthlyCashflow(monthData: mapped);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    monthData?.forEach((key, value) {
      data[key] = value.toJson();
    });
    return data;
  }
}

class MonthlyData {
  final int? invoice;
  final int? expense;
  final int? shopify;

  MonthlyData({this.invoice, this.expense, this.shopify});

  factory MonthlyData.fromJson(Map<String, dynamic> json) {
    return MonthlyData(
      invoice: json['invoice'],
      expense: json['expense'],
      shopify: json['shopify'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'invoice': invoice,
      'expense': expense,
      'shopify': shopify,
    };
  }
}

class GetCashFlowResponse {
  final bool? status;
  final List<MonthlyCashflow>? cashflow;
  final List<CashFlowWeekData>? cashWeekflow;

  GetCashFlowResponse({
    this.status,
    this.cashflow,
    this.cashWeekflow,
  });

  GetCashFlowResponse copyWith(
          {bool? status,
          List<MonthlyCashflow>? cashflow,
          List<CashFlowWeekData>? cashWeekflow}) =>
      GetCashFlowResponse(
        status: status ?? this.status,
        cashflow: cashflow ?? this.cashflow,
        cashWeekflow: cashWeekflow ?? this.cashWeekflow,
      );

  factory GetCashFlowResponse.fromJson(Map<String, dynamic> json) =>
      GetCashFlowResponse(
        status: json["status"],
        // cashflow: json["cashflow"] == null
        //     ? []
        //     : List<CashFlowData>.from(
        //         json["cashflow"]!.map((x) => CashFlowData.fromJson(x))),

        cashflow: (json['cashflow'] as List<dynamic>?)
            ?.map((e) => MonthlyCashflow.fromJson(e as Map<String, dynamic>))
            .toList(),

        cashWeekflow: (json['cashflow'] as List<dynamic>?)
            ?.map((e) => CashFlowWeekData.fromJson(e as Map<String, dynamic>))
            .toList(),
        // cashWeekflow: json["cashflow"] == null
        //     ? []
        //     : List<CashFlowWeekData>.from(
        //         json["cashflow"]!.map((x) => CashFlowWeekData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        'cashflow': cashflow?.map((e) => e.toJson()).toList(),
        // "cashflow": cashflow == null
        //     ? []
        //     : List<dynamic>.from(cashflow!.map((x) => x.toJson())),
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

class WeeklyCashflowResponse {
  final bool? status;
  final List<CashFlowWeekData>? cashflow;

  WeeklyCashflowResponse({this.status, this.cashflow});

  factory WeeklyCashflowResponse.fromJson(Map<String, dynamic> json) {
    return WeeklyCashflowResponse(
      status: json['status'],
      cashflow: (json['cashflow'] as List<dynamic>?)
          ?.map((item) => CashFlowWeekData.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'cashflow': cashflow?.map((e) => e.toJson()).toList(),
      };
}

class CashFlowWeekData {
  final Map<String, CashflowValue>? weekData;

  CashFlowWeekData({this.weekData});

  factory CashFlowWeekData.fromJson(Map<String, dynamic> json) {
    final map = <String, CashflowValue>{};
    json.forEach((key, value) {
      map[key] = CashflowValue.fromJson(value);
    });
    return CashFlowWeekData(weekData: map);
  }

  Map<String, dynamic> toJson() =>
      weekData?.map(
        (key, value) => MapEntry(key, value.toJson()),
      ) ??
      {};
}

class CashflowValue {
  final int? invoice;
  final int? expense;
  final int? shopify;

  CashflowValue({this.invoice, this.expense, this.shopify});

  factory CashflowValue.fromJson(Map<String, dynamic> json) {
    return CashflowValue(
      invoice: json['invoice'],
      expense: json['expense'],
      shopify: json['shopify'],
    );
  }

  Map<String, dynamic> toJson() => {
        'invoice': invoice,
        'expense': expense,
        'shopify': shopify,
      };
}
