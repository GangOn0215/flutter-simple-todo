import 'package:flutter/material.dart';
import 'package:simple_todo/models/todo_model.dart';

class TodoRowWidget extends StatefulWidget {
  final TodoModel todoRow;
  final Function onToggleCheck;
  final Function onDelete;

  const TodoRowWidget({
    super.key,
    required this.todoRow,
    required this.onToggleCheck,
    required this.onDelete,
  });

  @override
  State<TodoRowWidget> createState() => _TodoRowWidgetState();
}

class _TodoRowWidgetState extends State<TodoRowWidget> {
  void onCheck() {
    widget.onToggleCheck(
      key: widget.todoRow.id,
      updateData: widget.todoRow,
    );
  }

  void onDelete() {
    widget.onDelete(
      key: widget.todoRow.id,
    );
  }

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
                color: Colors.deepPurple,
                size: 20,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            SizedBox(
              width: 200,
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
        SizedBox(
          width: 45,
          child: Row(
            children: [
              commonButton(
                onCheck,
                widget.todoRow.checked
                    ? Icons.check_box_rounded
                    : Icons.check_box_outline_blank_rounded,
                Colors.pink,
              ),
              const SizedBox(
                width: 5,
              ),
              if (widget.todoRow.checked)
                commonButton(
                  onDelete,
                  Icons.delete,
                  Colors.black.withOpacity(0.7),
                )
              else
                Container()
            ],
          ),
        ),
      ],
    );
  }

  IconButton commonButton(var onPress, IconData icon, Color color) {
    return IconButton(
      iconSize: 18,
      padding: EdgeInsets.zero, // 패딩 0
      constraints: const BoxConstraints(), // 패딩 0 적용하게 해줌
      onPressed: onPress,
      icon: Icon(icon),
      color: color,
    );
  }
}
