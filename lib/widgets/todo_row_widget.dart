import 'package:flutter/material.dart';
import 'package:simple_todo/models/todo_model.dart';

class TodoRowWidget extends StatefulWidget {
  final TodoModel todoRow;
  final onToggleCheck;

  const TodoRowWidget({
    super.key,
    required this.todoRow,
    this.onToggleCheck,
  });

  @override
  State<TodoRowWidget> createState() => _TodoRowWidgetState();
}

class _TodoRowWidgetState extends State<TodoRowWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
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
            SizedBox(
              width: 210,
              child: Text(
                widget.todoRow.todo,
                overflow: TextOverflow.fade,
                maxLines: 1,
                softWrap: false,
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
        IconButton(
          onPressed: () => widget.onToggleCheck(
            widget.todoRow.id,
            widget.todoRow,
          ),
          icon: Icon(
            widget.todoRow.checked
                ? Icons.check_box_rounded
                : Icons.check_box_outline_blank_rounded,
          ),
          color: Colors.deepOrange,
        )
      ],
    );
  }
}
