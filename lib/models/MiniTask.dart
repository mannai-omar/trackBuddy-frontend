import 'dart:convert';

class MiniTask {
    String id;
    String title;
    String description;
    String status;
    String task;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    MiniTask({
        required this.id,
        required this.title,
        required this.description,
        required this.status,
        required this.task,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    factory MiniTask.fromRawJson(String str) => MiniTask.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory MiniTask.fromJson(Map<String, dynamic> json) => MiniTask(
        id: json["_id"],
        title: json["title"],
        description: json["description"],
        status: json["status"],
        task: json["task"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "description": description,
        "status": status,
        "task": task,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}
