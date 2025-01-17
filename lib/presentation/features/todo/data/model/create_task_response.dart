
class CreateTaskResponse {
    final bool? status;
    final String? message;
    final Task? task;

    CreateTaskResponse({
        this.status,
        this.message,
        this.task,
    });

    CreateTaskResponse copyWith({
        bool? status,
        String? message,
        Task? task,
    }) => 
        CreateTaskResponse(
            status: status ?? this.status,
            message: message ?? this.message,
            task: task ?? this.task,
        );

    factory CreateTaskResponse.fromJson(Map<String, dynamic> json) => CreateTaskResponse(
        status: json["status"],
        message: json["message"],
        task: json["task"] == null ? null : Task.fromJson(json["task"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "task": task?.toJson(),
    };
}

class Task {
    final String? user;
    final String? title;
    final String? priority;
    final bool? completed;
    final DateTime? date;
    final String? time;
    final String? id;
    final int? v;

    Task({
        this.user,
        this.title,
        this.priority,
        this.completed,
        this.date,
        this.time,
        this.id,
        this.v,
    });

    Task copyWith({
        String? user,
        String? title,
        String? priority,
        bool? completed,
        DateTime? date,
        String? time,
        String? id,
        int? v,
    }) => 
        Task(
            user: user ?? this.user,
            title: title ?? this.title,
            priority: priority ?? this.priority,
            completed: completed ?? this.completed,
            date: date ?? this.date,
            time: time ?? this.time,
            id: id ?? this.id,
            v: v ?? this.v,
        );

    factory Task.fromJson(Map<String, dynamic> json) => Task(
        user: json["user"],
        title: json["title"],
        priority: json["priority"],
        completed: json["completed"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        time: json["time"],
        id: json["_id"],
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "user": user,
        "title": title,
        "priority": priority,
        "completed": completed,
        "date": date?.toIso8601String(),
        "time": time,
        "_id": id,
        "__v": v,
    };
}
