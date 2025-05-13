// class GetWeekCashFlowResponse {
//   final bool? status;
//   final List<WeeklyCashflowData>? cashflow;

//   GetWeekCashFlowResponse({
//     this.status,
//     this.cashflow,
//   });

//   GetWeekCashFlowResponse copyWith({
//     bool? status,
//     List<WeeklyCashflowData>? cashflow,
//   }) =>
//       GetWeekCashFlowResponse(
//         status: status ?? this.status,
//         cashflow: cashflow ?? this.cashflow,
//       );

//   factory GetWeekCashFlowResponse.fromJson(Map<String, dynamic> json) =>
//       GetWeekCashFlowResponse(
//         status: json["status"],
//         cashflow: json["cashflow"] == null
//             ? []
//             : List<WeeklyCashflowData>.from(
//                 json["cashflow"]!.map((x) => WeeklyCashflowData.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "status": status,
//         "cashflow": cashflow == null
//             ? []
//             : List<dynamic>.from(cashflow!.map((x) => x.toJson())),
//       };
// }

// class WeeklyCashflowData {
//   final Week? week1;
//   final Week? week2;
//   final Week? week3;
//   final Week? week4;
//   final Week? week5;

//   WeeklyCashflowData({
//     this.week1,
//     this.week2,
//     this.week3,
//     this.week4,
//     this.week5,
//   });

//   WeeklyCashflowData copyWith({
//     Week? week1,
//     Week? week2,
//     Week? week3,
//     Week? week4,
//     Week? week5,
//   }) =>
//       WeeklyCashflowData(
//         week1: week1 ?? this.week1,
//         week2: week2 ?? this.week2,
//         week3: week3 ?? this.week3,
//         week4: week4 ?? this.week4,
//         week5: week5 ?? this.week5,
//       );

//   factory WeeklyCashflowData.fromJson(Map<String, dynamic> json) =>
//       WeeklyCashflowData(
//         week1: json["Week 1"] == null ? null : Week.fromJson(json["Week 1"]),
//         week2: json["Week 2"] == null ? null : Week.fromJson(json["Week 2"]),
//         week3: json["Week 3"] == null ? null : Week.fromJson(json["Week 3"]),
//         week4: json["Week 4"] == null ? null : Week.fromJson(json["Week 4"]),
//         week5: json["Week 5"] == null ? null : Week.fromJson(json["Week 5"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "Week 1": week1?.toJson(),
//         "Week 2": week2?.toJson(),
//         "Week 3": week3?.toJson(),
//         "Week 4": week4?.toJson(),
//         "Week 5": week5?.toJson(),
//       };
// }

// class Week {
//   final Day? monday;
//   final Day? tuesday;
//   final Day? wednesday;
//   final Day? thursday;
//   final Day? friday;
//   final Day? saturday;
//   final Day? sunday;

//   Week({
//     this.monday,
//     this.tuesday,
//     this.wednesday,
//     this.thursday,
//     this.friday,
//     this.saturday,
//     this.sunday,
//   });

//   Week copyWith({
//     Day? monday,
//     Day? tuesday,
//     Day? wednesday,
//     Day? thursday,
//     Day? friday,
//     Day? saturday,
//     Day? sunday,
//   }) =>
//       Week(
//         monday: monday ?? this.monday,
//         tuesday: tuesday ?? this.tuesday,
//         wednesday: wednesday ?? this.wednesday,
//         thursday: thursday ?? this.thursday,
//         friday: friday ?? this.friday,
//         saturday: saturday ?? this.saturday,
//         sunday: sunday ?? this.sunday,
//       );

//   factory Week.fromJson(Map<String, dynamic> json) => Week(
//         monday: json["Monday"] == null ? null : Day.fromJson(json["Monday"]),
//         tuesday: json["Tuesday"] == null ? null : Day.fromJson(json["Tuesday"]),
//         wednesday:
//             json["Wednesday"] == null ? null : Day.fromJson(json["Wednesday"]),
//         thursday:
//             json["Thursday"] == null ? null : Day.fromJson(json["Thursday"]),
//         friday: json["Friday"] == null ? null : Day.fromJson(json["Friday"]),
//         saturday:
//             json["Saturday"] == null ? null : Day.fromJson(json["Saturday"]),
//         sunday: json["Sunday"] == null ? null : Day.fromJson(json["Sunday"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "Monday": monday?.toJson(),
//         "Tuesday": tuesday?.toJson(),
//         "Wednesday": wednesday?.toJson(),
//         "Thursday": thursday?.toJson(),
//         "Friday": friday?.toJson(),
//         "Saturday": saturday?.toJson(),
//         "Sunday": sunday?.toJson(),
//       };
// }

// class Day {
//   final int? invoice;
//   final int? expense;
//   final int? shopify;

//   Day({
//     this.invoice,
//     this.expense,
//     this.shopify,
//   });

//   Day copyWith({
//     int? invoice,
//     int? expense,
//     int? shopify,
//   }) =>
//       Day(
//         invoice: invoice ?? this.invoice,
//         expense: expense ?? this.expense,
//         shopify: shopify ?? this.shopify,
//       );

//   factory Day.fromJson(Map<String, dynamic> json) => Day(
//         invoice: json["invoice"],
//         expense: json["expense"],
//         shopify: json["shopify"],
//       );

//   Map<String, dynamic> toJson() => {
//         "invoice": invoice,
//         "expense": expense,
//         "shopify": shopify,
//       };
// }

class GetWeekCashFlowResponse {
  final bool? status;
  final List<WeeklyCashflowData>? cashflow;

  GetWeekCashFlowResponse({
    this.status,
    this.cashflow,
  });

  GetWeekCashFlowResponse copyWith({
    bool? status,
    List<WeeklyCashflowData>? cashflow,
  }) =>
      GetWeekCashFlowResponse(
        status: status ?? this.status,
        cashflow: cashflow ?? this.cashflow,
      );

  factory GetWeekCashFlowResponse.fromJson(Map<String, dynamic> json) =>
      GetWeekCashFlowResponse(
        status: json["status"],
        cashflow: json["cashflow"] == null
            ? []
            : List<WeeklyCashflowData>.from(
                json["cashflow"]!.map((x) => WeeklyCashflowData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "cashflow": cashflow == null
            ? []
            : List<dynamic>.from(cashflow!.map((x) => x.toJson())),
      };
}

class WeeklyCashflowData {
  final Week? week1;
  final Week? week2;
  final Week3? week3;
  final Week? week4;
  final Week? week5;
  final String? currentWeek;

  WeeklyCashflowData({
    this.week1,
    this.week2,
    this.week3,
    this.week4,
    this.week5,
    this.currentWeek,
  });

  WeeklyCashflowData copyWith({
    Week? week1,
    Week? week2,
    Week3? week3,
    Week? week4,
    Week? week5,
    String? currentWeek,
  }) =>
      WeeklyCashflowData(
        week1: week1 ?? this.week1,
        week2: week2 ?? this.week2,
        week3: week3 ?? this.week3,
        week4: week4 ?? this.week4,
        week5: week5 ?? this.week5,
        currentWeek: currentWeek ?? this.currentWeek,
      );

  factory WeeklyCashflowData.fromJson(Map<String, dynamic> json) =>
      WeeklyCashflowData(
        week1: json["Week 1"] == null ? null : Week.fromJson(json["Week 1"]),
        week2: json["Week 2"] == null ? null : Week.fromJson(json["Week 2"]),
        week3: json["Week 3"] == null ? null : Week3.fromJson(json["Week 3"]),
        week4: json["Week 4"] == null ? null : Week.fromJson(json["Week 4"]),
        week5: json["Week 5"] == null ? null : Week.fromJson(json["Week 5"]),
        currentWeek: json["currentWeek"],
      );

  Map<String, dynamic> toJson() => {
        "Week 1": week1?.toJson(),
        "Week 2": week2?.toJson(),
        "Week 3": week3?.toJson(),
        "Week 4": week4?.toJson(),
        "Week 5": week5?.toJson(),
        "currentWeek": currentWeek,
      };
}

class Week {
  final Day? monday;
  final Day? tuesday;
  final Day? wednesday;
  final Day? thursday;
  final Day? friday;
  final Day? saturday;
  final Day? sunday;

  Week({
    this.monday,
    this.tuesday,
    this.wednesday,
    this.thursday,
    this.friday,
    this.saturday,
    this.sunday,
  });

  Week copyWith({
    Day? monday,
    Day? tuesday,
    Day? wednesday,
    Day? thursday,
    Day? friday,
    Day? saturday,
    Day? sunday,
  }) =>
      Week(
        monday: monday ?? this.monday,
        tuesday: tuesday ?? this.tuesday,
        wednesday: wednesday ?? this.wednesday,
        thursday: thursday ?? this.thursday,
        friday: friday ?? this.friday,
        saturday: saturday ?? this.saturday,
        sunday: sunday ?? this.sunday,
      );

  factory Week.fromJson(Map<String, dynamic> json) => Week(
        monday: json["Monday"] == null ? null : Day.fromJson(json["Monday"]),
        tuesday: json["Tuesday"] == null ? null : Day.fromJson(json["Tuesday"]),
        wednesday:
            json["Wednesday"] == null ? null : Day.fromJson(json["Wednesday"]),
        thursday:
            json["Thursday"] == null ? null : Day.fromJson(json["Thursday"]),
        friday: json["Friday"] == null ? null : Day.fromJson(json["Friday"]),
        saturday:
            json["Saturday"] == null ? null : Day.fromJson(json["Saturday"]),
        sunday: json["Sunday"] == null ? null : Day.fromJson(json["Sunday"]),
      );

  Map<String, dynamic> toJson() => {
        "Monday": monday?.toJson(),
        "Tuesday": tuesday?.toJson(),
        "Wednesday": wednesday?.toJson(),
        "Thursday": thursday?.toJson(),
        "Friday": friday?.toJson(),
        "Saturday": saturday?.toJson(),
        "Sunday": sunday?.toJson(),
      };
}

class Day {
  final int? invoice;
  final int? expense;
  final int? shopify;

  Day({
    this.invoice,
    this.expense,
    this.shopify,
  });

  Day copyWith({
    int? invoice,
    int? expense,
    int? shopify,
  }) =>
      Day(
        invoice: invoice ?? this.invoice,
        expense: expense ?? this.expense,
        shopify: shopify ?? this.shopify,
      );

  factory Day.fromJson(Map<String, dynamic> json) => Day(
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

class Week3 {
  final Monday? monday;
  final Day? tuesday;
  final Day? wednesday;
  final Day? thursday;
  final Day? friday;
  final Day? saturday;
  final Day? sunday;

  Week3({
    this.monday,
    this.tuesday,
    this.wednesday,
    this.thursday,
    this.friday,
    this.saturday,
    this.sunday,
  });

  Week3 copyWith({
    Monday? monday,
    Day? tuesday,
    Day? wednesday,
    Day? thursday,
    Day? friday,
    Day? saturday,
    Day? sunday,
  }) =>
      Week3(
        monday: monday ?? this.monday,
        tuesday: tuesday ?? this.tuesday,
        wednesday: wednesday ?? this.wednesday,
        thursday: thursday ?? this.thursday,
        friday: friday ?? this.friday,
        saturday: saturday ?? this.saturday,
        sunday: sunday ?? this.sunday,
      );

  factory Week3.fromJson(Map<String, dynamic> json) => Week3(
        monday: json["Monday"] == null ? null : Monday.fromJson(json["Monday"]),
        tuesday: json["Tuesday"] == null ? null : Day.fromJson(json["Tuesday"]),
        wednesday:
            json["Wednesday"] == null ? null : Day.fromJson(json["Wednesday"]),
        thursday:
            json["Thursday"] == null ? null : Day.fromJson(json["Thursday"]),
        friday: json["Friday"] == null ? null : Day.fromJson(json["Friday"]),
        saturday:
            json["Saturday"] == null ? null : Day.fromJson(json["Saturday"]),
        sunday: json["Sunday"] == null ? null : Day.fromJson(json["Sunday"]),
      );

  Map<String, dynamic> toJson() => {
        "Monday": monday?.toJson(),
        "Tuesday": tuesday?.toJson(),
        "Wednesday": wednesday?.toJson(),
        "Thursday": thursday?.toJson(),
        "Friday": friday?.toJson(),
        "Saturday": saturday?.toJson(),
        "Sunday": sunday?.toJson(),
      };
}

class Monday {
  final double? invoice;
  final int? expense;
  final int? shopify;

  Monday({
    this.invoice,
    this.expense,
    this.shopify,
  });

  Monday copyWith({
    double? invoice,
    int? expense,
    int? shopify,
  }) =>
      Monday(
        invoice: invoice ?? this.invoice,
        expense: expense ?? this.expense,
        shopify: shopify ?? this.shopify,
      );

  factory Monday.fromJson(Map<String, dynamic> json) => Monday(
        invoice: json["invoice"]?.toDouble(),
        expense: json["expense"],
        shopify: json["shopify"],
      );

  Map<String, dynamic> toJson() => {
        "invoice": invoice,
        "expense": expense,
        "shopify": shopify,
      };
}
