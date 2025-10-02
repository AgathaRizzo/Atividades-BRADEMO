import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isBlue = true; // controla qual tema está ativo

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App com ThemeData Dinâmico',
      theme: isBlue
          ? ThemeData(
              scaffoldBackgroundColor: Colors.blue,
              appBarTheme: AppBarTheme(
                backgroundColor: Colors.blue[900], //azul
                foregroundColor: Colors.white, //branco
              ),
              textTheme: TextTheme(
                bodyMedium: TextStyle(color: Colors.white, fontSize: 18),
              ),
            )
          : ThemeData(
              scaffoldBackgroundColor: Colors.yellow,
              appBarTheme: AppBarTheme(
                backgroundColor: Colors.amber[800],
                foregroundColor: Colors.black,
              ),
              textTheme: TextTheme(
                bodyMedium: TextStyle(color: Colors.black, fontSize: 18),
              ),
            ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(isBlue ? "Tema Azul" : "Tema Amarelo"),
          centerTitle: true,
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                isBlue = !isBlue; // troca o tema
              });
            },
            child: Text("Trocar Tema"),
          ),
        ),
      ),
    );
  }
}
