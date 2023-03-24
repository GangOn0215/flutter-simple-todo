import 'package:flutter/material.dart';
import 'package:simple_todo/models/todo_model.dart';

class TodoDetailModalWidget extends StatelessWidget {
  final TodoModel todoRow;

  const TodoDetailModalWidget({
    super.key,
    required this.todoRow,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      padding: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 50,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Detail Modal',
                style: TextStyle(
                  color: Colors.pinkAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            children: [
              const SizedBox(
                width: 80,
                child: Text(
                  'Todo',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                todoRow.todo,
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const SizedBox(
                width: 80,
                child: Text(
                  'Date',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                todoRow.date,
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const SizedBox(
                width: 80,
                child: Text(
                  'RegDate',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                todoRow.regDate,
              )
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            children: [
              SizedBox(
                width: (MediaQuery.of(context).size.width * 1) - 100,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    'Modify',
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
