import 'package:flutter/material.dart';
import 'package:simple_todo/models/todo_model.dart';
import 'package:simple_todo/widgets/todo_detail_modal_widget.dart';

class TodoRowWidget extends StatefulWidget {
  final TodoModel todoRow;
  final Function onUpdate;

  const TodoRowWidget({
    super.key,
    required this.todoRow,
    required this.onUpdate,
  });

  @override
  State<TodoRowWidget> createState() => _TodoRowWidgetState();
}

class _TodoRowWidgetState extends State<TodoRowWidget> {
  void onCheck() {
    widget.todoRow.checked = !widget.todoRow.checked;

    widget.onUpdate(
      key: widget.todoRow.id,
      updateData: widget.todoRow,
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
              child: TextButton(
                onPressed: () {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (context) {
                      return TodoDetailModalWidget(
                        todoRow: widget.todoRow,
                        onUpdate: widget.onUpdate,
                      );
                    },
                  );
                },
                style: TextButton.styleFrom(
                  alignment: Alignment.bottomLeft,
                ),
                child: Text(
                  widget.todoRow.todo,
                  overflow: TextOverflow.fade,
                  maxLines: 1,
                  softWrap: false,
                  style: widget.todoRow.checked
                      ? const TextStyle(
                          fontSize: 14,
                          height: 1,
                          decoration: TextDecoration.lineThrough,
                          decorationThickness: 3,
                          color: Colors.grey,
                        )
                      : const TextStyle(
                          fontSize: 14,
                          height: 1,
                          color: Colors.black,
                        ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
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
