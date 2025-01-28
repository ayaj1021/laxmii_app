class GetSingleReportResponse {
  final bool? status;
  final List<String>? headers;
  final List<ReportData>? data;

  GetSingleReportResponse({
    this.status,
    this.headers,
    this.data,
  });

  GetSingleReportResponse copyWith({
    bool? status,
    List<String>? headers,
    List<ReportData>? data,
  }) =>
      GetSingleReportResponse(
        status: status ?? this.status,
        headers: headers ?? this.headers,
        data: data ?? this.data,
      );

  factory GetSingleReportResponse.fromJson(Map<String, dynamic> json) =>
      GetSingleReportResponse(
        status: json["status"],
        headers: json["headers"] == null
            ? []
            : List<String>.from(json["headers"]!.map((x) => x)),
        data: json["data"] == null
            ? []
            : List<ReportData>.from(
                json["data"]!.map((x) => ReportData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "headers":
            headers == null ? [] : List<dynamic>.from(headers!.map((x) => x)),
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class ReportData {
  final DateTime? date;
  final String? expenseType;
  final String? supplier;
  final int? amount;

  ReportData({
    this.date,
    this.expenseType,
    this.supplier,
    this.amount,
  });

  ReportData copyWith({
    DateTime? date,
    String? expenseType,
    String? supplier,
    int? amount,
  }) =>
      ReportData(
        date: date ?? this.date,
        expenseType: expenseType ?? this.expenseType,
        supplier: supplier ?? this.supplier,
        amount: amount ?? this.amount,
      );

  factory ReportData.fromJson(Map<String, dynamic> json) => ReportData(
        date: json["Date"] == null ? null : DateTime.parse(json["Date"]),
        expenseType: json["Expense Type"],
        supplier: json["Supplier"],
        amount: json["Amount"],
      );

  Map<String, dynamic> toJson() => {
        "Date":
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "Expense Type": expenseType,
        "Supplier": supplier,
        "Amount": amount,
      };
}
