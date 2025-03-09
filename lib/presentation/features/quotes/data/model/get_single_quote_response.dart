class GetSingleQuoteResponse {
  final bool? status;
  final Quote? quote;

  GetSingleQuoteResponse({
    this.status,
    this.quote,
  });

  GetSingleQuoteResponse copyWith({
    bool? status,
    Quote? quote,
  }) =>
      GetSingleQuoteResponse(
        status: status ?? this.status,
        quote: quote ?? this.quote,
      );

  factory GetSingleQuoteResponse.fromJson(Map<String, dynamic> json) =>
      GetSingleQuoteResponse(
        status: json["status"],
        quote: json["quote"] == null ? null : Quote.fromJson(json["quote"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "quote": quote?.toJson(),
      };
}

class Quote {
  final String? id;
  final String? user;
  final String? customerName;
  final String? quoteNumber;
  final DateTime? issueDate;
  final DateTime? expiryDate;
  final List<SingleQuoteItems>? items;
  final num? totalAmount;
  final String? status;
  final DateTime? createdAt;
  final int? v;

  Quote({
    this.id,
    this.user,
    this.customerName,
    this.quoteNumber,
    this.issueDate,
    this.expiryDate,
    this.items,
    this.totalAmount,
    this.status,
    this.createdAt,
    this.v,
  });

  Quote copyWith({
    String? id,
    String? user,
    String? customerName,
    String? quoteNumber,
    DateTime? issueDate,
    DateTime? expiryDate,
    List<SingleQuoteItems>? items,
    num? totalAmount,
    String? status,
    DateTime? createdAt,
    int? v,
  }) =>
      Quote(
        id: id ?? this.id,
        user: user ?? this.user,
        customerName: customerName ?? this.customerName,
        quoteNumber: quoteNumber ?? this.quoteNumber,
        issueDate: issueDate ?? this.issueDate,
        expiryDate: expiryDate ?? this.expiryDate,
        items: items ?? this.items,
        totalAmount: totalAmount ?? this.totalAmount,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        v: v ?? this.v,
      );

  factory Quote.fromJson(Map<String, dynamic> json) => Quote(
        id: json["_id"],
        user: json["user"],
        customerName: json["customerName"],
        quoteNumber: json["quoteNumber"],
        issueDate: json["issueDate"] == null
            ? null
            : DateTime.parse(json["issueDate"]),
        expiryDate: json["expiryDate"] == null
            ? null
            : DateTime.parse(json["expiryDate"]),
        items: json["items"] == null
            ? []
            : List<SingleQuoteItems>.from(
                json["items"]!.map((x) => SingleQuoteItems.fromJson(x))),
        totalAmount: json["totalAmount"],
        status: json["status"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "user": user,
        "customerName": customerName,
        "quoteNumber": quoteNumber,
        "issueDate": issueDate?.toIso8601String(),
        "expiryDate": expiryDate?.toIso8601String(),
        "items": items == null
            ? []
            : List<dynamic>.from(items!.map((x) => x.toJson())),
        "totalAmount": totalAmount,
        "status": status,
        "createdAt": createdAt?.toIso8601String(),
        "__v": v,
      };
}

class SingleQuoteItems {
  final String? description;
  final num? quantity;
  final num? price;
  final String? id;

  SingleQuoteItems({
    this.description,
    this.quantity,
    this.price,
    this.id,
  });

  SingleQuoteItems copyWith({
    String? description,
    num? quantity,
    num? price,
    String? id,
  }) =>
      SingleQuoteItems(
        description: description ?? this.description,
        quantity: quantity ?? this.quantity,
        price: price ?? this.price,
        id: id ?? this.id,
      );

  factory SingleQuoteItems.fromJson(Map<String, dynamic> json) =>
      SingleQuoteItems(
        description: json["description"],
        quantity: json["quantity"],
        price: json["price"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "description": description,
        "quantity": quantity,
        "price": price,
        "_id": id,
      };
}
