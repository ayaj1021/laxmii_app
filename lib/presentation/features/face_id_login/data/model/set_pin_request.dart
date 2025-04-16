class SetPinRequest {
  final String pin;

  SetPinRequest({
    required this.pin,
  });

  SetPinRequest copyWith({
    String? pin,
  }) =>
      SetPinRequest(
        pin: pin ?? this.pin,
      );

  factory SetPinRequest.fromJson(Map<String, dynamic> json) => SetPinRequest(
        pin: json["pin"],
      );

  Map<String, dynamic> toJson() => {
        "pin": pin,
      };
}
