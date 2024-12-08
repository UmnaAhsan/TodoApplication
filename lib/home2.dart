import 'package:deletetodo/model_todo.dart';
import 'package:deletetodo/todo_item.dart';
import 'package:flutter/material.dart';

class Home2 extends StatefulWidget {
  final todosList = ToDo.todoList();

  @override
  State<Home2> createState() => _Home2State();
}

class _Home2State extends State<Home2> {
  bool isSelected = false;

  final todosList = ToDo.todoList();
  List<ToDo> _foundToDo = [];
  final _todoController = TextEditingController();

  @override
  void initState() {
    _foundToDo = todosList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 236, 222, 222),
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Column(
            children: [
              // Search bar
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: (value) => _runFilter(value),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Search',
                  ),
                ),
              ),
              // List of Todos
              Expanded(
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "All Todos",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold,fontFamily: 'FontMain'),
                      ),
                    ),
                    const SizedBox(height: 10),
                    for (ToDo todo in _foundToDo.reversed)
                      ToDoItem(
                        todo: todo,
                        onToDoChanged: _handleTodoChange,
                        onDeleteItem: _deleteTodoItem,
                      ),
                  ],
                ),
              ),
            ],
          ),
          // Add New Todo
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _todoController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Add new todo item",
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  InkWell(
                    onTap: () {
                      _addTodoItem(_todoController.text);
                    },
                    child: Icon(Icons.add, size: 30),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: const Color.fromARGB(255, 124, 77, 133),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Icon(Icons.menu),
          Text(
            "Todo List",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,fontFamily: 'FontMain'),
          ),
          Icon(Icons.person),
        ],
      ),
    );
  }

  void _addTodoItem(String toDo) {
    if (toDo.isNotEmpty) {
      setState(() {
        todosList.add(ToDo(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          todoText: toDo,
        ));
        _todoController.clear();
      });
    }
  }

  void _deleteTodoItem(String id) {
    setState(() {
      todosList.removeWhere((item) => item.id == id);
    });
  }

  void _handleTodoChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _runFilter(String enteredKeyword) {
    List<ToDo> results = [];
    if (enteredKeyword.isEmpty) {
      results = todosList;
    } else {
      results = todosList
          .where((item) => item.todoText!
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      _foundToDo = results;
    });
  }
}
