import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // Necessário para jsonEncode e jsonDecode

void main() {
  runApp(const MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  // Variáveis para armazenar o resultado da última requisição
  String resultDisplay = "Nenhuma requisição realizada.";
  // O ID 1 será usado como exemplo para GET, PUT e DELETE de item específico
  final String postId = '1';

  // --- MÉTODOS HTTP ---

  // 1. GET para uma Lista
  Future<void> getListPosts() async {
    setState(() => resultDisplay = "Carregando lista...");
    var url = Uri.https('jsonplaceholder.typicode.com', 'posts');
    try {
      var response = await http.get(url);
      
      if (response.statusCode == 200) {
        // Exibimos apenas os 3 primeiros posts para não sobrecarregar
        List<dynamic> data = jsonDecode(response.body);
        String preview = data
            .take(3) 
            .map((post) => "ID: ${post['id']}, Título: ${post['title'].substring(0, 15)}...")
            .join('\n');
            
        setState(() {
          resultDisplay = "GET (Lista) - Status: ${response.statusCode}\n\nTrês primeiros posts:\n$preview";
        });
      } else {
        setState(() {
          resultDisplay = "GET (Lista) falhou. Status: ${response.statusCode}";
        });
      }
    } catch (e) {
      setState(() {
        resultDisplay = "Erro ao fazer GET (Lista): $e";
      });
    }
  }

  // 2. GET para um item específico
  Future<void> getSinglePost() async {
    setState(() => resultDisplay = "Carregando item $postId...");
    var url = Uri.https('jsonplaceholder.typicode.com', 'posts/$postId');
    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        setState(() {
          resultDisplay = "GET (ID $postId) - Status: ${response.statusCode}\n\nTítulo: ${data['title']}\n\nCorpo: ${data['body']}";
        });
      } else {
        setState(() {
          resultDisplay = "GET (ID $postId) falhou. Status: ${response.statusCode}";
        });
      }
    } catch (e) {
      setState(() {
        resultDisplay = "Erro ao fazer GET (ID): $e";
      });
    }
  }

  // 3. POST (Criação)
  Future<void> createPost() async {
    setState(() => resultDisplay = "Enviando POST...");
    var url = Uri.https('jsonplaceholder.typicode.com', 'posts');
    try {
      var response = await http.post(
        url,
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(<String, dynamic>{
          'title': 'Novo Post Flutter',
          'body': 'Este é o corpo do novo post criado via Flutter.',
          'userId': 1,
        }),
      );

      if (response.statusCode == 201) { // 201 Created é o esperado
        setState(() {
          resultDisplay = "POST (Criado) - Status: ${response.statusCode}\n\nResposta: ${response.body}";
        });
      } else {
        setState(() {
          resultDisplay = "POST falhou. Status: ${response.statusCode}";
        });
      }
    } catch (e) {
      setState(() {
        resultDisplay = "Erro ao fazer POST: $e";
      });
    }
  }

  // 4. PUT (Atualização)
  Future<void> updatePost() async {
    setState(() => resultDisplay = "Enviando PUT...");
    var url = Uri.https('jsonplaceholder.typicode.com', 'posts/$postId');
    try {
      var response = await http.put(
        url,
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(<String, dynamic>{
          'id': int.parse(postId),
          'title': 'POST ID $postId ATUALIZADO PELO FLUTTER',
          'body': 'O corpo e o título foram completamente alterados via PUT.',
          'userId': 1,
        }),
      );

      if (response.statusCode == 200) {
        setState(() {
          resultDisplay = "PUT (Atualizado ID $postId) - Status: ${response.statusCode}\n\nResposta: ${response.body}";
        });
      } else {
        setState(() {
          resultDisplay = "PUT falhou. Status: ${response.statusCode}";
        });
      }
    } catch (e) {
      setState(() {
        resultDisplay = "Erro ao fazer PUT: $e";
      });
    }
  }

  // 5. DELETE
  Future<void> deletePost() async {
    setState(() => resultDisplay = "Enviando DELETE...");
    var url = Uri.https('jsonplaceholder.typicode.com', 'posts/$postId');
    try {
      var response = await http.delete(url);

      if (response.statusCode == 200) { 
        setState(() {
          resultDisplay = "DELETE (ID $postId) - Status: ${response.statusCode}\n\nRecurso deletado com sucesso!";
        });
      } else {
        setState(() {
          resultDisplay = "DELETE falhou. Status: ${response.statusCode}";
        });
      }
    } catch (e) {
      setState(() {
        resultDisplay = "Erro ao fazer DELETE: $e";
      });
    }
  }
  
  // --- INTERFACE (UI) MELHORADA ---

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('REST API com Flutter (jsonplaceholder)'),
        backgroundColor: Colors.indigo, // Cor de destaque na AppBar
        elevation: 4, 
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TÍTULO DA SEÇÃO
            const Text(
              'Escolha uma operação CRUD:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
            const SizedBox(height: 16),
            
            // BOTÕES DE AÇÃO (Usando Wrap para responsividade)
            Wrap(
              spacing: 12.0, 
              runSpacing: 12.0, 
              alignment: WrapAlignment.start, // Alinha à esquerda
              children: [
                _buildActionButton("GET (Lista)", Icons.list_alt, getListPosts, Colors.green.shade700),
                _buildActionButton("GET (ID 1)", Icons.search, getSinglePost, Colors.green),
                _buildActionButton("POST", Icons.add_circle, createPost, Colors.blue.shade700),
                _buildActionButton("PUT (ID 1)", Icons.update, updatePost, Colors.orange.shade700),
                _buildActionButton("DELETE (ID 1)", Icons.delete, deletePost, Colors.red.shade700),
              ],
            ),
            
            const SizedBox(height: 30),
            
            // RESULTADO DA REQUISIÇÃO
            const Text(
              'Resultado da Última Resposta:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const Divider(height: 10, color: Colors.indigo),
            
            // CARTÃO DE EXIBIÇÃO DO RESULTADO
            Card(
              elevation: 6, 
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                width: double.infinity, 
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100, 
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.indigo.shade100, width: 2),
                ),
                child: SelectableText(
                  resultDisplay,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 13,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  // Helper Widget para criar botões padronizados e coloridos
  Widget _buildActionButton(String label, IconData icon, VoidCallback onPressed, Color color) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white, 
        backgroundColor: color, 
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      ),
    );
  }
}