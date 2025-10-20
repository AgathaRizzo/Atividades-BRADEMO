import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: AsyncAwaitExemplo()));
}

class AsyncAwaitExemplo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AsyncAwaitExemploState();
  }
}

class AsyncAwaitExemploState extends State<AsyncAwaitExemplo> {
  String resultado = "Clique no botão para iniciar";

  Future<void> buscarPedido() async {
    setState(() {
      resultado = "Buscando pedido do usuário...";
    });

    await Future.delayed(Duration(seconds: 2));

    setState(() {
      resultado = "Pedido pronto: Large Latte ☕";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Atividade 1 - Async/Await")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              resultado,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await buscarPedido();
              },
              child: Text("Executar Operação Assíncrona"),
            ),
          ],
        ),
      ),
    );
  }
}
