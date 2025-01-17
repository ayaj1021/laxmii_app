
class CreateTaskRequest {
    final String title;
    final String priority;

    CreateTaskRequest({
        required this.title,
        required this.priority,
    });

    CreateTaskRequest copyWith({
        String? title,
        String? priority,
    }) => 
        CreateTaskRequest(
            title: title ?? this.title,
            priority: priority ?? this.priority,
        );

    factory CreateTaskRequest.fromJson(Map<String, dynamic> json) => CreateTaskRequest(
        title: json["title"],
        priority: json["priority"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "priority": priority,
    };
}
