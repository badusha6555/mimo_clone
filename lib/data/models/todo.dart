class Model {
  final String? id;
  final String? emoji;
  final String title;
  final String tasks;
  bool isDone;

  Model({
    this.id,
    this.emoji,
    required this.title,
    required this.tasks,
    this.isDone = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'emoji': emoji,
      'name': title,
      'description': tasks,
      'isDone': isDone,
    };
  }

  factory Model.fromMap(Map<String, dynamic> map, String descriptionId) {
    return Model(
      id: descriptionId,
      emoji: map['emoji'] ?? "",
      title: map['name'] ?? "",
      tasks: map['description'] ?? "",
      isDone: map['isDone'] ?? false,
    );
  }
}
