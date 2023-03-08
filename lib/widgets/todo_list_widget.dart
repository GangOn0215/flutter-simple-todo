import 'package:flutter/material.dart';
import 'package:simple_todo/models/todo_model.dart';
import 'package:uuid/uuid.dart';

class TodoListWidget extends StatefulWidget {
  const TodoListWidget({super.key});

  @override
  State<TodoListWidget> createState() => _TodoListWidgetState();
}

class _TodoListWidgetState extends State<TodoListWidget> {
  final _mainColor = const Color(0xFFE75480);
  bool isCheck = false;
  int lastIdx = 0;
  final fieldText = TextEditingController();
  final uuid = const Uuid();
  late Map<String, TodoModel> todos;

  void onToggleCheck(String key) {
    setState(() {
      TodoModel temp = todos[key]!;

      temp.checked = !temp.checked;

      todos.update(key, (value) => temp);
    });
  }

  void clearText() {
    fieldText.clear();
  }

  @override
  void initState() {
    super.initState();

    todos = {};
  }

  void onSubmitTodo(String value) {
    if (value == '') {
      return;
    }

    var uniId = uuid.v4();
    TodoModel todo = TodoModel(
      id: uniId,
      date: DateTime.now().toString(),
      todo: value,
    );

    clearText();

    setState(() {
      todos[uniId] = todo;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 50,
      ),
      child: Column(
        children: [
          TextField(
            onSubmitted: onSubmitTodo,
            controller: fieldText,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.fromLTRB(1, 15, 5, -1),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: _mainColor),
              ),
            ),
          ),
          for (MapEntry todoRow in todos.entries)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Row(
                    children: [
                      Transform.scale(
                        scale: 0.3,
                        child: const Icon(
                          Icons.square,
                          color: Colors.deepOrange,
                          size: 20,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        todoRow.value.todo,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => onToggleCheck(todoRow.key),
                  icon: Icon(
                    todoRow.value.checked
                        ? Icons.check_box_rounded
                        : Icons.check_box_outline_blank_rounded,
                  ),
                  color: Colors.deepOrange,
                )
              ],
            )
        ],
      ),
    );
  }
}
