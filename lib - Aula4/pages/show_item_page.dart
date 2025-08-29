import 'package:flutter/material.dart';
import '../model/todo_item.dart';

class ShowItemPage extends StatelessWidget {
  // Declara o campo que mantém o TodoItem
  final TodoItem todo;

  // Requere Todo no construtor.
  const ShowItemPage({required this.todo});
  
  @override
  Widget build(BuildContext context) {
    // Usa o Todo para criar o UI
    return Scaffold(
      appBar: AppBar(title: Text(todo.title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(todo.description),
      ),
    );
  }
}
