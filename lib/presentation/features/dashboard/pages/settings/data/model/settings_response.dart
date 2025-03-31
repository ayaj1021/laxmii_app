import 'package:laxmii_app/presentation/features/dashboard/pages/settings/data/model/notifications_model.dart';

class SettingsResponse {
  final bool? status;
  final Settings? settings;

  SettingsResponse({
    this.status,
    this.settings,
  });

  SettingsResponse copyWith({
    bool? status,
    Settings? settings,
  }) =>
      SettingsResponse(
        status: status ?? this.status,
        settings: settings ?? this.settings,
      );

  factory SettingsResponse.fromJson(Map<String, dynamic> json) =>
      SettingsResponse(
        status: json["status"],
        settings: json["settings"] == null
            ? null
            : Settings.fromJson(json["settings"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "settings": settings?.toJson(),
      };
}

class Settings {
  final Notifications? notifications;
  final String? id;
  final String? user;
  final bool? shopifyConnected;
  final String? shop;
  final String? accessToken;
  final bool? dataImported;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  Settings({
    this.notifications,
    this.id,
    this.user,
    this.shopifyConnected,
    this.shop,
    this.accessToken,
    this.dataImported,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  Settings copyWith({
    Notifications? notifications,
    String? id,
    String? user,
    bool? shopifyConnected,
    String? shop,
    String? accessToken,
    bool? dataImported,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
  }) =>
      Settings(
        notifications: notifications ?? this.notifications,
        id: id ?? this.id,
        user: user ?? this.user,
        shopifyConnected: shopifyConnected ?? this.shopifyConnected,
        shop: shop ?? this.shop,
        accessToken: accessToken ?? this.accessToken,
        dataImported: dataImported ?? this.dataImported,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        v: v ?? this.v,
      );

  factory Settings.fromJson(Map<String, dynamic> json) => Settings(
        notifications: json["notifications"] == null
            ? null
            : Notifications.fromJson(json["notifications"]),
        id: json["_id"],
        user: json["user"],
        shopifyConnected: json["shopifyConnected"],
        shop: json["shop"],
        accessToken: json["accessToken"],
        dataImported: json["dataImported"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "notifications": notifications?.toJson(),
        "_id": id,
        "user": user,
        "shopifyConnected": shopifyConnected,
        "shop": shop,
        "accessToken": accessToken,
        "dataImported": dataImported,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}
