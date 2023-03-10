import 'package:simple_todo/models/todo_model.dart';

class TodoMapModel {
  final String id;
  final TodoModel todoRow;

  TodoMapModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        todoRow = json['todoRow'];
}
