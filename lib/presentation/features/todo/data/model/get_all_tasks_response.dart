class GetAllTasksResponse {
  final bool? status;
  final List<Task>? tasks;

  GetAllTasksResponse({
    this.status,
    this.tasks,
  });

  GetAllTasksResponse copyWith({
    bool? status,
    List<Task>? tasks,
  }) =>
      GetAllTasksResponse(
        status: status ?? this.status,
        tasks: tasks ?? this.tasks,
      );

  factory GetAllTasksResponse.fromJson(Map<String, dynamic> json) =>
      GetAllTasksResponse(
        status: json["status"],
        tasks: json["tasks"] == null
            ? []
            : List<Task>.from(json["tasks"]!.map((x) => Task.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "tasks": tasks == null
            ? []
            : List<dynamic>.from(tasks!.map((x) => x.toJson())),
      };
}

class Task {
  final String? id;
  final String? user;
  final String? title;
  final String? priority;
  final bool? completed;
  final DateTime? date;
  final String? time;
  final int? v;

  Task({
    this.id,
    this.user,
    this.title,
    this.priority,
    this.completed,
    this.date,
    this.time,
    this.v,
  });

  Task copyWith({
    String? id,
    String? user,
    String? title,
    String? priority,
    bool? completed,
    DateTime? date,
    String? time,
    int? v,
  }) =>
      Task(
        id: id ?? this.id,
        user: user ?? this.user,
        title: title ?? this.title,
        priority: priority ?? this.priority,
        completed: completed ?? this.completed,
        date: date ?? this.date,
        time: time ?? this.time,
        v: v ?? this.v,
      );

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        id: json["_id"],
        user: json["user"],
        title: json["title"],
        priority: json["priority"],
        completed: json["completed"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        time: json["time"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "user": user,
        "title": title,
        "priority": priority,
        "completed": completed,
        "date": date?.toIso8601String(),
        "time": time,
        "__v": v,
      };
}
