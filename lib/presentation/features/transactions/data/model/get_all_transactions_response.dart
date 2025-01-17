// To parse this JSON data, do
//
//     final getAllTransactionsResponse = getAllTransactionsResponseFromJson(jsonString);

import 'dart:convert';

GetAllTransactionsResponse getAllTransactionsResponseFromJson(String str) => GetAllTransactionsResponse.fromJson(json.decode(str));

String getAllTransactionsResponseToJson(GetAllTransactionsResponse data) => json.encode(data.toJson());

class GetAllTransactionsResponse {
    final bool? status;
    final List<Transaction>? transactions;

    GetAllTransactionsResponse({
        this.status,
        this.transactions,
    });

    GetAllTransactionsResponse copyWith({
        bool? status,
        List<Transaction>? transactions,
    }) => 
        GetAllTransactionsResponse(
            status: status ?? this.status,
            transactions: transactions ?? this.transactions,
        );

    factory GetAllTransactionsResponse.fromJson(Map<String, dynamic> json) => GetAllTransactionsResponse(
        status: json["status"],
        transactions: json["transactions"] == null ? [] : List<Transaction>.from(json["transactions"]!.map((x) => Transaction.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "transactions": transactions == null ? [] : List<dynamic>.from(transactions!.map((x) => x.toJson())),
    };
}

class Transaction {
    final String? id;
    final String? type;
    final String? transactionType;
    final String? expenseType;
    final int? amount;
    final String? supplierName;
    final DateTime? createdAt;
    final String? inventory;
    final String? customerName;

    Transaction({
        this.id,
        this.type,
        this.transactionType,
        this.expenseType,
        this.amount,
        this.supplierName,
        this.createdAt,
        this.inventory,
        this.customerName,
    });

    Transaction copyWith({
        String? id,
        String? type,
        String? transactionType,
        String? expenseType,
        int? amount,
        String? supplierName,
        DateTime? createdAt,
        String? inventory,
        String? customerName,
    }) => 
        Transaction(
            id: id ?? this.id,
            type: type ?? this.type,
            transactionType: transactionType ?? this.transactionType,
            expenseType: expenseType ?? this.expenseType,
            amount: amount ?? this.amount,
            supplierName: supplierName ?? this.supplierName,
            createdAt: createdAt ?? this.createdAt,
            inventory: inventory ?? this.inventory,
            customerName: customerName ?? this.customerName,
        );

    factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        id: json["_id"],
        type: json["type"],
        transactionType: json["transactionType"],
        expenseType: json["expenseType"],
        amount: json["amount"],
        supplierName: json["supplierName"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        inventory: json["inventory"],
        customerName: json["customerName"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "type": type,
        "transactionType": transactionType,
        "expenseType": expenseType,
        "amount": amount,
        "supplierName": supplierName,
        "createdAt": createdAt?.toIso8601String(),
        "inventory": inventory,
        "customerName": customerName,
    };
}
