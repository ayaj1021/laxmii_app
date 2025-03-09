class CreateQuotesResponse {
  final bool? status;
  final String? message;
  final Quote? quote;

  CreateQuotesResponse({
    this.status,
    this.message,
    this.quote,
  });

  CreateQuotesResponse copyWith({
    bool? status,
    String? message,
    Quote? quote,
  }) =>
      CreateQuotesResponse(
        status: status ?? this.status,
        message: message ?? this.message,
        quote: quote ?? this.quote,
      );

  factory CreateQuotesResponse.fromJson(Map<String, dynamic> json) =>
      CreateQuotesResponse(
        status: json["status"],
        message: json["message"],
        quote: json["quote"] == null ? null : Quote.fromJson(json["quote"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "quote": quote?.toJson(),
      };
}

class Quote {
  final String? user;
  final String? customerName;
  final String? quoteNumber;
  final DateTime? issueDate;
  final DateTime? expiryDate;
  final List<Item>? items;
  final num? totalAmount;
  final String? status;
  final String? id;
  final DateTime? createdAt;
  final int? v;

  Quote({
    this.user,
    this.customerName,
    this.quoteNumber,
    this.issueDate,
    this.expiryDate,
    this.items,
    this.totalAmount,
    this.status,
    this.id,
    this.createdAt,
    this.v,
  });

  Quote copyWith({
    String? user,
    String? customerName,
    String? quoteNumber,
    DateTime? issueDate,
    DateTime? expiryDate,
    List<Item>? items,
    num? totalAmount,
    String? status,
    String? id,
    DateTime? createdAt,
    int? v,
  }) =>
      Quote(
        user: user ?? this.user,
        customerName: customerName ?? this.customerName,
        quoteNumber: quoteNumber ?? this.quoteNumber,
        issueDate: issueDate ?? this.issueDate,
        expiryDate: expiryDate ?? this.expiryDate,
        items: items ?? this.items,
        totalAmount: totalAmount ?? this.totalAmount,
        status: status ?? this.status,
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        v: v ?? this.v,
      );

  factory Quote.fromJson(Map<String, dynamic> json) => Quote(
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
            : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
        totalAmount: json["totalAmount"],
        status: json["status"],
        id: json["_id"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
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
        "_id": id,
        "createdAt": createdAt?.toIso8601String(),
        "__v": v,
      };
}

class Item {
  final String? description;
  final num? quantity;
  final num? price;
  final String? id;

  Item({
    this.description,
    this.quantity,
    this.price,
    this.id,
  });

  Item copyWith({
    String? description,
    num? quantity,
    num? price,
    String? id,
  }) =>
      Item(
        description: description ?? this.description,
        quantity: quantity ?? this.quantity,
        price: price ?? this.price,
        id: id ?? this.id,
      );

  factory Item.fromJson(Map<String, dynamic> json) => Item(
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
