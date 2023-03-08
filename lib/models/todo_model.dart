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
}
