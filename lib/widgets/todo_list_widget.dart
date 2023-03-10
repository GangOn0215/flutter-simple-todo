import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_todo/models/todo_model.dart';

class TodoListWidget extends StatefulWidget {
  late Map<String, dynamic> todos;
  late SharedPreferences pref;
  TodoListWidget({
    super.key,
    required this.todos,
    required this.pref,
  });

  @override
  State<TodoListWidget> createState() => _TodoListWidgetState();
}

class _TodoListWidgetState extends State<TodoListWidget> {
  final fieldText = TextEditingController();
  late List<String> todoKeys;

  @override
  void initState() {
    super.initState();

    todoKeys = widget.todos.keys.toList();
  }

  static const String prefTable = 'todo';

  final _mainColor = const Color(0xFFE75480);

  void clearText() => fieldText.clear();

  // update check
  void onToggleCheck(String key) {
    TodoModel temp = widget.todos[key]!;

    temp.checked = !temp.checked;

    widget.todos.update(key, (value) => temp);

    widget.pref.remove(prefTable);
    widget.pref.setString(prefTable, jsonEncode(widget.todos));

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        widget.todos.isNotEmpty
            ? Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(3),
                  ),
                ),
                height: 600,
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Row(
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
                                widget.todos[todoKeys[index]].todo,
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () => onToggleCheck(todoKeys[index]),
                          icon: Icon(
                            widget.todos[todoKeys[index]].checked
                                ? Icons.check_box_rounded
                                : Icons.check_box_outline_blank_rounded,
                          ),
                          color: Colors.deepOrange,
                        )
                      ],
                    );
                  },
                ),
              )
            : const Center(
                child: CircularProgressIndicator(),
              )
      ],
    );
  }
}
