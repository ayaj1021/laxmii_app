class GetSingleSalesResponse {
  final bool? status;
  final List<String>? headers;
  final List<SingleSalesData>? data;

  GetSingleSalesResponse({
    this.status,
    this.headers,
    this.data,
  });

  GetSingleSalesResponse copyWith({
    bool? status,
    List<String>? headers,
    List<SingleSalesData>? data,
  }) =>
      GetSingleSalesResponse(
        status: status ?? this.status,
        headers: headers ?? this.headers,
        data: data ?? this.data,
      );

  factory GetSingleSalesResponse.fromJson(Map<String, dynamic> json) =>
      GetSingleSalesResponse(
        status: json["status"],
        headers: json["headers"] == null
            ? []
            : List<String>.from(json["headers"]!.map((x) => x)),
        data: json["data"] == null
            ? []
            : List<SingleSalesData>.from(
                json["data"]!.map((x) => SingleSalesData.fromJson(x))),
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

class SingleSalesData {
  final DateTime? date;
  final String? inventory;
  final String? customer;
  final int? amount;

  SingleSalesData({
    this.date,
    this.inventory,
    this.customer,
    this.amount,
  });

  SingleSalesData copyWith({
    DateTime? date,
    String? inventory,
    String? customer,
    int? amount,
  }) =>
      SingleSalesData(
        date: date ?? this.date,
        inventory: inventory ?? this.inventory,
        customer: customer ?? this.customer,
        amount: amount ?? this.amount,
      );

  factory SingleSalesData.fromJson(Map<String, dynamic> json) =>
      SingleSalesData(
        date: json["Date"] == null ? null : DateTime.parse(json["Date"]),
        inventory: json["Inventory"],
        customer: json["Customer"],
        amount: json["Amount"],
      );

  Map<String, dynamic> toJson() => {
        "Date":
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "Inventory": inventory,
        "Customer": customer,
        "Amount": amount,
      };
}
