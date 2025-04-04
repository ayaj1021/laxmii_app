class UpdateProfileRequest {
  final String businessName;
  final String phoneNumber;
  final String address;
  final String accountName;
  final String accountNumber;
  final String bankName;

  UpdateProfileRequest({
    required this.businessName,
    required this.phoneNumber,
    required this.address,
    required this.accountName,
    required this.accountNumber,
    required this.bankName,
  });

  UpdateProfileRequest copyWith({
    String? businessName,
    String? phoneNumber,
    String? address,
    String? accountName,
    String? accountNumber,
    String? bankName,
  }) =>
      UpdateProfileRequest(
        businessName: businessName ?? this.businessName,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        address: address ?? this.address,
        accountName: accountName ?? this.accountName,
        accountNumber: accountNumber ?? this.accountNumber,
        bankName: bankName ?? this.bankName,
      );

  factory UpdateProfileRequest.fromJson(Map<String, dynamic> json) =>
      UpdateProfileRequest(
        businessName: json["businessName"],
        phoneNumber: json["phoneNumber"],
        address: json["address"],
        accountName: json["accountName"],
        accountNumber: json["accountNumber"],
        bankName: json["bankName"],
      );

  Map<String, dynamic> toJson() => {
        "businessName": businessName,
        "phoneNumber": phoneNumber,
        "address": address,
        "accountName": accountName,
        "accountNumber": accountNumber,
        "bankName": bankName,
      };
}
