import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_todo/models/todo_model.dart';
import 'package:simple_todo/widgets/todo_row_widget.dart';

class TodoListWidget extends StatefulWidget {
  late SharedPreferences pref;
  late Map<String, dynamic> todos;
  late List<String> todosKeys;
  late String pickDate;

  TodoListWidget({
    super.key,
    required this.todos,
    required this.pref,
    required this.todosKeys,
    required this.pickDate,
  });

  @override
  State<TodoListWidget> createState() => _TodoListWidgetState();
}

class _TodoListWidgetState extends State<TodoListWidget> {
  final fieldText = TextEditingController();
  late Map<String, dynamic> todosFillter;
  late List<String> todoFiltersKeys;

  @override
  void initState() {
    super.initState();
    todosFillter = {};
    todoFiltersKeys = [];

    initFillterTodo();
  }

  void initFillterTodo() {
    todosFillter = {};

    widget.todos.forEach((key, value) {
      if (value is TodoModel) {
        if (widget.pickDate == value.date) {
          todosFillter[key] = value;
        }
      }
    });

    todoFiltersKeys = todosFillter.keys.toList();
  }

  static const String prefTable = 'todo';

  final _mainColor = const Color(0xFFE75480);

  void clearText() => fieldText.clear();

  // update check
  void onToggleCheck({required String key, required TodoModel updateData}) {
    TodoModel temp = updateData;

    temp.checked = !temp.checked;

    widget.todos.update(key, (value) => temp);

    widget.pref.remove(prefTable);
    widget.pref.setString(prefTable, jsonEncode(widget.todos));

    setState(() {});
  }

  void onDelete({required String key}) {
    widget.todos.remove(key);

    widget.todosKeys = widget.todos.keys.toList();

    widget.pref.remove(prefTable);

    if (widget.todos.isNotEmpty) {
      widget.pref.setString(prefTable, jsonEncode(widget.todos));
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    initFillterTodo();

    return Column(
      children: [
        if (todosFillter.isNotEmpty)
          Container(
            height: 600,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(3),
              ),
            ),
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemCount: todosFillter.length,
              itemBuilder: (context, index) {
                return TodoRowWidget(
                  todoRow: todosFillter[todoFiltersKeys[index]],
                  onToggleCheck: onToggleCheck,
                  onDelete: onDelete,
                );
              },
              separatorBuilder: (context, index) => const SizedBox(
                height: 10,
              ),
            ),
          )
        else
          const Center()
      ],
    );
  }
}
