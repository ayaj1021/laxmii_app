class GetYearActivityResponse {
  final April? march;
  final April? april;
  final April? may;
  final April? june;
  final April? july;
  final April? august;
  final April? september;
  final April? october;
  final April? november;
  final April? december;
  final April? january;

  GetYearActivityResponse({
    this.march,
    this.april,
    this.may,
    this.june,
    this.july,
    this.august,
    this.september,
    this.october,
    this.november,
    this.december,
    this.january,
  });

  GetYearActivityResponse copyWith({
    April? march,
    April? april,
    April? may,
    April? june,
    April? july,
    April? august,
    April? september,
    April? october,
    April? november,
    April? december,
    April? january,
  }) =>
      GetYearActivityResponse(
        march: march ?? this.march,
        april: april ?? this.april,
        may: may ?? this.may,
        june: june ?? this.june,
        july: july ?? this.july,
        august: august ?? this.august,
        september: september ?? this.september,
        october: october ?? this.october,
        november: november ?? this.november,
        december: december ?? this.december,
        january: january ?? this.january,
      );

  factory GetYearActivityResponse.fromJson(Map<String, dynamic> json) =>
      GetYearActivityResponse(
        march: json["March"] == null ? null : April.fromJson(json["March"]),
        april: json["April"] == null ? null : April.fromJson(json["April"]),
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
      );

  Map<String, dynamic> toJson() => {
        "March": march?.toJson(),
        "April": april?.toJson(),
        "May": may?.toJson(),
        "June": june?.toJson(),
        "July": july?.toJson(),
        "August": august?.toJson(),
        "September": september?.toJson(),
        "October": october?.toJson(),
        "November": november?.toJson(),
        "December": december?.toJson(),
        "January": january?.toJson(),
      };
}

class April {
  final int? invoice;
  final double? expense;

  April({
    this.invoice,
    this.expense,
  });

  April copyWith({
    int? invoice,
    double? expense,
  }) =>
      April(
        invoice: invoice ?? this.invoice,
        expense: expense ?? this.expense,
      );

  factory April.fromJson(Map<String, dynamic> json) => April(
        invoice: json["invoice"],
        expense: json["expense"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "invoice": invoice,
        "expense": expense,
      };
}
