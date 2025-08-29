import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_4/model/todo_item.dart';
import 'package:flutter_application_4/pages/random_page.dart';
import 'package:flutter_application_4/widget/todo_list_view.dart';

class HomePage extends StatelessWidget {
  late final List<TodoItem> allItens;

  HomePage() {
    allItens = List.generate(30, (index) {
      return TodoItem(
        title: "Item ${index}",
        description: "Description ${index}",
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
      ),
      body: Center(
        child: TodoListView(todos: allItens,)        
      ),
    );
  }


  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: Center(
  //       child: ElevatedButton(
  //         onPressed: () {
  //           //
  //           Navigator.push(
  //             context,
  //             MaterialPageRoute(builder: (context) => RandomPage()),
  //           );
  //           //
  //         },
  //         child: Text("Random", style: TextStyle(fontSize: 36)),
  //       ),
  //     ),
  //   );
  // }
}
