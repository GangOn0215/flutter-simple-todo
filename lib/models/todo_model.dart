class TodoModel {
  final String id;
  final String regDate; // todo를 만든 날짜

  String date; // 임의로 지정된 날짜
  String? content; // 상세 정보
  String? updateDate; // todo 수정 날짜
  String todo;
  bool checked;

  TodoModel({
    required this.id,
    required this.regDate,
    this.date = '',
    this.todo = '',
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
