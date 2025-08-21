import 'package:flutter/material.dart';
import 'package:intro_flutter/my_homepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //programamos a tela aqui
    return MaterialApp(
      title: "Meu App Flutter",
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 146, 182, 248),
        appBar: AppBar(
          title: Text("Meu App"),
          backgroundColor: Colors.blueAccent,
        ),
        floatingActionButton: 
          FloatingActionButton(
            child: Icon(Icons.plus_one),
            onPressed: () {},
          ),
        body: MyHomepage()
      ),
    );
  }
}
