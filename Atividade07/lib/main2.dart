import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(home: TratamentoErrosExemplo()));
}

class TratamentoErrosExemplo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TratamentoErrosExemploState();
  }
}

class TratamentoErrosExemploState extends State<TratamentoErrosExemplo> {
  String resultado = "Clique no botão para fazer a requisição";

  Future<void> buscarDadosComErro() async {
    try {
      setState(() {
        resultado = "Buscando dados...";
      });

      var url = Uri.https('jsonplaceholder.typicode.com', 'posts/9999999');
      var response = await http.get(url);

      if (response.statusCode == 200) {
        setState(() {
          resultado = "Sucesso! Dados recebidos:\n${response.body}";
        });
      } else {
        throw Exception("Erro: código ${response.statusCode}");
      }
    } catch (e) {
      setState(() {
        resultado = "Erro capturado: $e";
      });
    } finally {
      print("Finalizando operação...");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Atividade 2 - Tratamento de Erros")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              resultado,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await buscarDadosComErro();
              },
              child: Text("Executar Requisição com Erro"),
            ),
          ],
        ),
      ),
    );
  }
}
