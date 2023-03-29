import 'package:flutter/material.dart';
import 'package:simple_todo/models/todo_model.dart';

class TodoDetailModalWidget extends StatefulWidget {
  final TodoModel todoRow;
  final Function onUpdate;

  const TodoDetailModalWidget({
    super.key,
    required this.todoRow,
    required this.onUpdate,
  });

  @override
  State<TodoDetailModalWidget> createState() => _TodoDetailModalWidgetState();
}

class _TodoDetailModalWidgetState extends State<TodoDetailModalWidget> {
  final fieldText = TextEditingController();
  late ScrollController _scrollController;
  final _mainDarkColor = const Color(0XFF282B30);
  final _mainBackground = const Color(0XFF1E2124);
  final _mainDiscordColor = const Color(0XFF7289da);
  final _mainColor = const Color(0xFFE75480);
  bool isEdit = false;

  void onModifyClick() {
    isEdit = !isEdit;

    setState(() {});
  }

  void onUpdate() {
    widget.todoRow.todo = fieldText.value.text;

    widget.onUpdate(
      key: widget.todoRow.id,
      updateData: widget.todoRow,
    );
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    fieldText.text = widget.todoRow.todo;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height / 3 +
              MediaQuery.of(context).viewInsets.bottom,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 50,
          ),
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
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
                    isEdit
                        ? SizedBox(
                            height: 15,
                            width:
                                (MediaQuery.of(context).size.width * 1) - 200,
                            child: TextField(
                              onSubmitted: (value) {
                                onUpdate();
                              },
                              controller: fieldText,
                              style: const TextStyle(fontSize: 14),
                              decoration: const InputDecoration(
                                contentPadding:
                                    EdgeInsets.fromLTRB(0, -30, 10, 10),
                                // contentPadding: EdgeInsets.all(10),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black54),
                                ),
                              ),
                            ),
                          )
                        : Text(
                            widget.todoRow.todo,
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
                      widget.todoRow.date,
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
                      widget.todoRow.regDate,
                    )
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    if (isEdit)
                      submitCancleButton(context)
                    else
                      SizedBox(
                        width: (MediaQuery.of(context).size.width * 1) - 100,
                        child: ElevatedButton(
                          onPressed: onModifyClick,
                          style: ElevatedButton.styleFrom(
                              backgroundColor: _mainDarkColor),
                          child: const Text(
                            'Modify',
                          ),
                        ),
                      )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Expanded submitCancleButton(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width: ((MediaQuery.of(context).size.width * 1) - 150) / 2,
            child: ElevatedButton(
              onPressed: onUpdate,
              style: ElevatedButton.styleFrom(backgroundColor: _mainDarkColor),
              child: const Text('OK'),
            ),
          ),
          SizedBox(
            width: ((MediaQuery.of(context).size.width * 1) - 150) / 2,
            child: ElevatedButton(
              onPressed: onModifyClick,
              style: ElevatedButton.styleFrom(backgroundColor: _mainDarkColor),
              child: const Text('Cancel'),
            ),
          )
        ],
      ),
    );
  }
}
