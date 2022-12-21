class ToDoModel {
  int? userID;
  int? id;
  String? title;
  bool? completed;

  ToDoModel({
    this.userID,
    this.id,
    this.title,
    this.completed
  });

  factory ToDoModel.fromJson(Map<String, dynamic> json) => ToDoModel(
    userID: json["userId"],
    id: json["id"],
    title: json["title"],
    completed: json["completed"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userID,
    "id": id,
    "title": title,
    "completed": completed,
  };
}