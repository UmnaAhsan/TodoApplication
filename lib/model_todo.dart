class ToDo {
  String? id;
  String? todoText;
  bool isDone;

  ToDo({required this.id, required this.todoText, this.isDone = false});

  static List<ToDo> todoList() {
    return [
      ToDo(id: "1", todoText: "Morning exercise", isDone: true),
      ToDo(id: "2", todoText: "check mail",),
      ToDo(id: "3", todoText: "dinner",),
      ToDo(id: "4", todoText: "games",),
    ];
  }
}
