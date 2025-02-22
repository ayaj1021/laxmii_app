class GetAllQuotesReponse {
  final bool? status;
  final List<Quote>? quote;

  GetAllQuotesReponse({
    this.status,
    this.quote,
  });

  GetAllQuotesReponse copyWith({
    bool? status,
    List<Quote>? quote,
  }) =>
      GetAllQuotesReponse(
        status: status ?? this.status,
        quote: quote ?? this.quote,
      );

  factory GetAllQuotesReponse.fromJson(Map<String, dynamic> json) =>
      GetAllQuotesReponse(
        status: json["status"],
        quote: json["quote"] == null
            ? []
            : List<Quote>.from(json["quote"]!.map((x) => Quote.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "quote": quote == null
            ? []
            : List<dynamic>.from(quote!.map((x) => x.toJson())),
      };
}

class Quote {
  final String? id;
  final String? user;
  final String? customerName;
  final String? quoteNumber;
  final DateTime? issueDate;
  final DateTime? expiryDate;
  final List<Item>? items;
  final int? totalAmount;
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
    List<Item>? items,
    int? totalAmount,
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
            : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
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

class Item {
  final String? description;
  final int? quantity;
  final int? price;
  final String? id;

  Item({
    this.description,
    this.quantity,
    this.price,
    this.id,
  });

  Item copyWith({
    String? description,
    int? quantity,
    int? price,
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
