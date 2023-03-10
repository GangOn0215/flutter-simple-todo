import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_todo/models/todo_model.dart';
import 'package:simple_todo/utils/common.dart';
import 'package:simple_todo/widgets/todo_list_widget.dart';
import 'package:uuid/uuid.dart';

class TodoWidget extends StatefulWidget {
  const TodoWidget({super.key});

  @override
  State<TodoWidget> createState() => _TodoWidgetState();
}

class _TodoWidgetState extends State<TodoWidget> {
  final _mainDarkColor = const Color(0XFF282B30);
  final _mainBackground = const Color(0XFF1E2124);
  final _mainDiscordColor = const Color(0XFF7289da);
  final _mainColor = const Color(0xFFE75480);

  final fieldText = TextEditingController();
  final uuid = const Uuid();
  late Map<String, dynamic> todos;
  late final SharedPreferences pref;
  static const String prefTable = 'todo';

  void clearText() => fieldText.clear();

  Future initPref() async {
    pref = await SharedPreferences.getInstance();

    // pref.setString('todo', '');
    var prefTodo = pref.getString('todo');

    if (prefTodo != null) {
      Map<String, dynamic> jsonTodos = jsonDecode(prefTodo);

      jsonTodos.forEach((key, value) {
        todos[key] = TodoModel.fromJson(value);
      });

      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();

    todos = {};
    initPref();
  }

  void onSubmitTodo(String value) {
    if (value == '') {
      return;
    }

    String uniId = uuid.v4();
    final dateformat = DateFormat('yyyy-MM-dd hh:mm');
    // print(dateformat.format(DateTime.now().toUtc()));

    TodoModel todo = TodoModel(
      id: uniId,
      date: getCurrentDate(),
      todo: value,
    );

    clearText();

    setState(() {
      todos[uniId] = todo;
    });

    String jsonTodos = jsonEncode(todos);

    pref.setString(prefTable, jsonTodos);
  }

  void onReset() {
    todos = {};
    pref.remove(prefTable);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          '2023-03-09',
          style: TextStyle(fontSize: 16),
        ),
        backgroundColor: _mainDarkColor,
        leading: Icon(
          Icons.checklist_rounded,
          color: _mainColor,
        ),
        actions: [
          Row(
            children: [
              IconButton(
                onPressed: onReset,
                icon: Icon(
                  Icons.delete_forever,
                  color: _mainColor,
                ),
              )
            ],
          )
        ],
      ),
      body: Padding(
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
            todos.isNotEmpty
                ? TodoListWidget(
                    todos: todos,
                    pref: pref,
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  )
          ],
        ),
      ),
    );
  }
}
