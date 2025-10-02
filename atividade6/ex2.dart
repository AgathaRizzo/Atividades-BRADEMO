import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App com ThemeData',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.blue, // fundo azul
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue[900], // appbar azul escuro
          foregroundColor: Colors.white, // texto e icones brancos
        ),
        textTheme: TextTheme(
          bodyMedium: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'), // titulo
        centerTitle: true, 
      ),
      body: Center(
        child: Text(
          "Bem-vindo ao App Azul!", // escrita no centro
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}
