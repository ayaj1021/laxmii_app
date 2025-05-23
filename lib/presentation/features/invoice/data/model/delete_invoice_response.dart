class DeleteInvoiceResponse {
  final bool? status;
  final String? message;

  DeleteInvoiceResponse({this.status, this.message});

  factory DeleteInvoiceResponse.fromJson(Map<String, dynamic> json) {
    return DeleteInvoiceResponse(
      status: json['status'] as bool?,
      message: json['message'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
    };
  }
}
