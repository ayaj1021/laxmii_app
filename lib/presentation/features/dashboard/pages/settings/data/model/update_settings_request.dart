import 'package:laxmii_app/presentation/features/dashboard/pages/settings/data/model/notifications_model.dart';

class UpdateSettingsRequest {
  final Notifications notifications;

  UpdateSettingsRequest({
    required this.notifications,
  });

  UpdateSettingsRequest copyWith({
    Notifications? notifications,
  }) =>
      UpdateSettingsRequest(
        notifications: notifications ?? this.notifications,
      );

  factory UpdateSettingsRequest.fromJson(Map<String, dynamic> json) =>
      UpdateSettingsRequest(
        notifications: Notifications.fromJson(json["notifications"]),
      );

  Map<String, dynamic> toJson() => {
        "notifications": notifications.toJson(),
      };
}
