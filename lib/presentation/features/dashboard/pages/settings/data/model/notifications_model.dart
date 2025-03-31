class Notifications {
  bool? todoNotification;
  bool? taxOptimization;
  bool? inventoryAlerts;
  bool? performanceInsight;

  Notifications({
    this.todoNotification,
    this.taxOptimization,
    this.inventoryAlerts,
    this.performanceInsight,
  });

  Notifications copyWith({
    bool? todoNotification,
    bool? taxOptimization,
    bool? inventoryAlerts,
    bool? performanceInsight,
  }) =>
      Notifications(
        todoNotification: todoNotification ?? this.todoNotification,
        taxOptimization: taxOptimization ?? this.taxOptimization,
        inventoryAlerts: inventoryAlerts ?? this.inventoryAlerts,
        performanceInsight: performanceInsight ?? this.performanceInsight,
      );

  factory Notifications.fromJson(Map<String, dynamic> json) => Notifications(
        todoNotification: json["todoNotification"],
        taxOptimization: json["taxOptimization"],
        inventoryAlerts: json["inventoryAlerts"],
        performanceInsight: json["performanceInsight"],
      );

  Map<String, dynamic> toJson() => {
        "todoNotification": todoNotification,
        "taxOptimization": taxOptimization,
        "inventoryAlerts": inventoryAlerts,
        "performanceInsight": performanceInsight,
      };
}
