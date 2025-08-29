import 'package:flutter/material.dart';
import 'package:flutter_application_4/pages/show_item_page.dart';
import '../model/todo_item.dart';

class TodoListView extends StatelessWidget {
  final List<TodoItem> todos;

  const TodoListView({required this.todos});
  
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(todos[index].title),
          onTap: () => Navigator.push(
            context,
            // Repassando para a nova página
            MaterialPageRoute(
              builder: (context) => ShowItemPage(todo: todos[index]),
            ),
          ),
        );
      },
    );
  }
}
