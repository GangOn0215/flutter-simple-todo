import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_todo/models/todo_model.dart';
import 'package:simple_todo/utils/common.dart';
import 'package:simple_todo/widgets/todo_list_widget.dart';
import 'package:uuid/uuid.dart';

class Todoscreen extends StatefulWidget {
  const Todoscreen({super.key});

  @override
  State<Todoscreen> createState() => _TodoscreenState();
}

class _TodoscreenState extends State<Todoscreen> {
  final _mainDarkColor = const Color(0XFF282B30);
  final _mainBackground = const Color(0XFF1E2124);
  final _mainDiscordColor = const Color(0XFF7289da);
  final _mainColor = const Color(0xFFE75480);
  final fieldText = TextEditingController();
  final uuid = const Uuid();
  late String pickDate;

  bool isModal = false;

  late Map<String, dynamic> todos;
  late List<String> todoKeys;
  late final SharedPreferences pref; // 내부 저장
  static const String prefTable = 'todo';

  void clearText() => fieldText.clear();

  Future initPref() async {
    pref = await SharedPreferences.getInstance();

    var prefTodo = pref.getString('todo');

    if (prefTodo != null) {
      Map<String, dynamic> jsonTodos = jsonDecode(prefTodo);

      jsonTodos.forEach((key, value) {
        todos[key] = TodoModel.fromJson(value);
      });

      todoKeys = todos.keys.toList();
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();

    todos = {};
    todoKeys = [];
    pickDate = getCurrentDate();
    initPref();
  }

  void onSubmitTodo(String value) {
    String uniId = uuid.v4();
    clearText();

    if (value == '') {
      return;
    }

    TodoModel todo = TodoModel(
      id: uniId,
      date: pickDate,
      todo: value,
      regDate: getCurrentDateTime(),
    );

    if (todos.isEmpty) {
      todos = {};
      todoKeys = [];
    }

    setState(() {
      todos[uniId] = todo;
      todoKeys.add(uniId);
    });

    String jsonTodos = jsonEncode(todos);

    pref.setString(prefTable, jsonTodos);
  }

  void onReset() {
    pref.remove(prefTable);
    todos = {};
    todoKeys = [];

    Navigator.of(context).pop();
    setState(() {});
  }

  void onClickNextDay() {
    setState(() {
      pickDate = setDateTomorrow(pickDate);
    });
  }

  void onClickPrevDay() {
    setState(() {
      pickDate = setDateYesterday(pickDate);
    });
  }

  void onClickDeleteAll() {
    isModal = !isModal;

    setState(() {});
  }

  Future _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      locale: const Locale('ko', 'KR'),
      context: context,
      initialDate: DateTime.parse(pickDate),
      firstDate: DateTime(2023),
      lastDate: DateTime(2025),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.dark(
              primary: _mainColor,
              onSurface: _mainColor,
              onPrimary: Colors.black,
            ),
            dialogBackgroundColor: Colors.black54,
            textTheme: const TextTheme(
              titleMedium: TextStyle(color: Colors.white),
              titleLarge: TextStyle(color: Colors.white),
            ),
          ),
          child: child!,
        );
      },
    );
    if (selected != null) {
      setState(() {
        // pickDate = (DateFormat.yMMMd()).format(selected);
        pickDate = getCurrentDateToSelected(selected);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // 키보드 나올때 앱 자체가 말려올라가는거 방지
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: onClickPrevDay,
              icon: const Icon(
                Icons.arrow_back_ios_new_outlined,
              ),
            ),
            TextButton(
              onPressed: () => _selectDate(context),
              child: Text(
                pickDate,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
            IconButton(
              onPressed: onClickNextDay,
              icon: const Icon(
                Icons.arrow_forward_ios_outlined,
              ),
            ),
          ],
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
                onPressed: () => _asyncConfirmDialog(context),
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
            const SizedBox(
              height: 20,
            ),
            todos.isNotEmpty
                ? TodoListWidget(
                    pref: pref,
                    todos: todos,
                    todosKeys: todoKeys,
                    pickDate: pickDate,
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  Future<void> _asyncConfirmDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            '삭제',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: const Text('전체 삭제 하시겠습니까? 🌸'),
          actions: <Widget>[
            ElevatedButton(
              onPressed: onReset,
              style: ElevatedButton.styleFrom(
                backgroundColor: _mainBackground,
              ),
              child: const Text('확인'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: _mainBackground,
              ),
              child: const Text('취소'),
            ),
          ],
        );
      },
    );
  }
}
