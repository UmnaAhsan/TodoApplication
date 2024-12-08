import 'package:deletetodo/model_todo.dart';
import 'package:flutter/material.dart';

class ToDoItem extends StatelessWidget {
  final ToDo todo;
  final onToDoChanged;
  final onDeleteItem;
  const ToDoItem(
      {super.key,
      required this.todo,
      required this.onDeleteItem,
      required this.onToDoChanged});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: ListTile(
          onTap: () {
            onToDoChanged(todo);
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          tileColor: const Color.fromARGB(255, 124, 77, 133),
          leading: Icon(
            todo.isDone
                ? Icons.check_box
                : Icons.check_box_outline_blank_outlined,
            color: Colors.white,
          ),
          title: Text(
            todo.todoText!,
            style: TextStyle(
                decoration: todo.isDone ? TextDecoration.lineThrough : null,
                color: Colors.black,
                fontFamily: 'FontMain'),
          ),
          trailing: InkWell(
              onTap: () {},
              child: IconButton(
                  onPressed: () {
                    onDeleteItem(todo.id);
                  },
                  icon: Icon(
                    Icons.delete,
                    color: Colors.black,
                  ))),
        ),
      ),
    );
  }
}
