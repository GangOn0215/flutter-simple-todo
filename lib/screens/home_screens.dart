import 'package:flutter/material.dart';
import 'package:simple_todo/widgets/todo_list_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final _mainDarkColor = const Color(0XFF282B30);
  final _mainBackground = const Color(0XFF1E2124);
  final _mainDiscordColor = const Color(0XFF7289da);
  final _mainColor = const Color(0xFFE75480);

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
      ),
      body: const TodoListWidget(),
    );
  }
}
