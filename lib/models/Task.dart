import 'dart:convert';

class Tasks {
    String? id;
    String title;
    String description;
    DateTime dueDate;
    String? status;
    String? creator;
    List<dynamic>? users;
    List<dynamic>? miniTasks;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;

    Tasks({
        this.id,
        required this.title,
        required this.description,
        required this.dueDate,
         this.status,
         this.creator,
         this.users,
         this.miniTasks,
         this.createdAt,
         this.updatedAt,
         this.v,
    });

    factory Tasks.fromRawJson(String str) => Tasks.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Tasks.fromJson(Map<String, dynamic> json) => Tasks(
        id: json["_id"],
        title: json["title"],
        description: json["description"],
        dueDate: DateTime.parse(json["dueDate"]),
        status: json["status"],
        creator: json["creator"],
        users: List<dynamic>.from(json["users"].map((x) => x)),
        miniTasks: List<dynamic>.from(json["miniTasks"].map((x) => x)),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "description": description,
        "dueDate": dueDate.toIso8601String(),
        "status": status,
        "creator": creator,
        "users": users != null ? List<dynamic>.from(users!.map((x) => x)) : null,
        "miniTasks": miniTasks != null ? List<dynamic>.from(miniTasks!.map((x) => x)) : null,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}
