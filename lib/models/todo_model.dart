class TodoModel {
  final String id;
  final String date; // 임의로 지정된 날짜
  final String todo;
  late String content; // 상세 정보
  final String regDate; // todo를 만든 날짜
  late String updateDate; // todo 수정 날짜

  bool checked;

  TodoModel({
    required this.id,
    required this.date,
    required this.todo,
    required this.regDate,
    this.checked = false,
  });

  TodoModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        date = json['date'],
        todo = json['todo'],
        regDate = json['regDate'],
        checked = json['checked'],
        content = json['content'],
        updateDate = json['updateDaste'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'todo': todo,
      'content': content,
      'checked': checked,
      'regDate': regDate,
      'updateDate': updateDate,
    };
  }
}
