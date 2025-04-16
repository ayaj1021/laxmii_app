class SetPinResponse {
  final bool? status;
  final String? message;
  final String? pin;
  final bool? pinSet;

  SetPinResponse({
    this.status,
    this.message,
    this.pin,
    this.pinSet,
  });

  SetPinResponse copyWith({
    bool? status,
    String? message,
    String? pin,
    bool? pinSet,
  }) =>
      SetPinResponse(
        status: status ?? this.status,
        message: message ?? this.message,
        pin: pin ?? this.pin,
        pinSet: pinSet ?? this.pinSet,
      );

  factory SetPinResponse.fromJson(Map<String, dynamic> json) => SetPinResponse(
        status: json["status"],
        message: json["message"],
        pin: json["pin"],
        pinSet: json["pinSet"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "pin": pin,
        "pinSet": pinSet,
      };
}
