class UpdateTaskRequest {
  final String priority;
  final bool completed;

  UpdateTaskRequest({
    required this.priority,
    required this.completed,
  });

  UpdateTaskRequest copyWith({
    String? priority,
    bool? completed,
  }) =>
      UpdateTaskRequest(
        priority: priority ?? this.priority,
        completed: completed ?? this.completed,
      );

  factory UpdateTaskRequest.fromJson(Map<String, dynamic> json) =>
      UpdateTaskRequest(
        priority: json["priority"],
        completed: json["completed"],
      );

  Map<String, dynamic> toJson() => {
        "priority": priority,
        "completed": completed,
      };
}
