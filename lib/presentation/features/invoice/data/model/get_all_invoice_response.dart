
class GetAllInvoiceResponse {
    final bool? status;
    final List<Invoice>? invoices;

    GetAllInvoiceResponse({
        this.status,
        this.invoices,
    });

    GetAllInvoiceResponse copyWith({
        bool? status,
        List<Invoice>? invoices,
    }) => 
        GetAllInvoiceResponse(
            status: status ?? this.status,
            invoices: invoices ?? this.invoices,
        );

    factory GetAllInvoiceResponse.fromJson(Map<String, dynamic> json) => GetAllInvoiceResponse(
        status: json["status"],
        invoices: json["invoices"] == null ? [] : List<Invoice>.from(json["invoices"]!.map((x) => Invoice.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "invoices": invoices == null ? [] : List<dynamic>.from(invoices!.map((x) => x.toJson())),
    };
}

class Invoice {
    final String? id;
    final String? user;
    final String? customerName;
    final String? invoiceNumber;
    final DateTime? issueDate;
    final DateTime? dueDate;
    final List<Item>? items;
    final int? totalAmount;
    final String? status;
    final DateTime? createdAt;
    final int? v;

    Invoice({
        this.id,
        this.user,
        this.customerName,
        this.invoiceNumber,
        this.issueDate,
        this.dueDate,
        this.items,
        this.totalAmount,
        this.status,
        this.createdAt,
        this.v,
    });

    Invoice copyWith({
        String? id,
        String? user,
        String? customerName,
        String? invoiceNumber,
        DateTime? issueDate,
        DateTime? dueDate,
        List<Item>? items,
        int? totalAmount,
        String? status,
        DateTime? createdAt,
        int? v,
    }) => 
        Invoice(
            id: id ?? this.id,
            user: user ?? this.user,
            customerName: customerName ?? this.customerName,
            invoiceNumber: invoiceNumber ?? this.invoiceNumber,
            issueDate: issueDate ?? this.issueDate,
            dueDate: dueDate ?? this.dueDate,
            items: items ?? this.items,
            totalAmount: totalAmount ?? this.totalAmount,
            status: status ?? this.status,
            createdAt: createdAt ?? this.createdAt,
            v: v ?? this.v,
        );

    factory Invoice.fromJson(Map<String, dynamic> json) => Invoice(
        id: json["_id"],
        user: json["user"],
        customerName: json["customerName"],
        invoiceNumber: json["invoiceNumber"],
        issueDate: json["issueDate"] == null ? null : DateTime.parse(json["issueDate"]),
        dueDate: json["dueDate"] == null ? null : DateTime.parse(json["dueDate"]),
        items: json["items"] == null ? [] : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
        totalAmount: json["totalAmount"],
        status: json["status"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "user": user,
        "customerName": customerName,
        "invoiceNumber": invoiceNumber,
        "issueDate": issueDate?.toIso8601String(),
        "dueDate": dueDate?.toIso8601String(),
        "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
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
