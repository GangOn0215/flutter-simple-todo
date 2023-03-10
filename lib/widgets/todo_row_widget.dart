import 'package:flutter/material.dart';
import 'package:simple_todo/models/todo_model.dart';

class TodoRowWidget extends StatefulWidget {
  const TodoRowWidget({super.key});

  @override
  State<TodoRowWidget> createState() => _TodoRowWidgetState();
}

class _TodoRowWidgetState extends State<TodoRowWidget> {
  late final TodoModel todoRow;
  @override
  Widget build(BuildContext context) {
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
                todoRow.todo,
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            todoRow.checked
                ? Icons.check_box_rounded
                : Icons.check_box_outline_blank_rounded,
          ),
          color: Colors.deepOrange,
        )
      ],
    );
  }
}