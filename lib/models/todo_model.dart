class TodoModel {
  final String id;
  final String date;
  final String todo;
  bool checked;

  TodoModel({
    required this.id,
    required this.date,
    required this.todo,
    this.checked = false,
  });

  TodoModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        date = json['date'],
        todo = json['todo'],
        checked = json['checked'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'todo': todo,
      'checked': checked,
    };
  }
}
