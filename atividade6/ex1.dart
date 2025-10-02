import 'package:flutter/material.dart';

void main() {
  runApp(MyGridApp());
}

class MyGridApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Exemplo GridView",
      debugShowCheckedModeBanner: false,
      home: GridPage(),
    );
  }
}

class GridPage extends StatelessWidget {

  final List<String> imagens = [
    "https://www.moto.com.br/assets/motos_mais_buscadas/Versys650.webp",
    "https://suzukimotos.com.br/storage/images/uploads/modelos/2025-07-02-17-25-06-zfsafs.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Galeria de Imagens"),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: imagens.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // quantidade de colunas
            crossAxisSpacing: 10, // espaço horizontal
            mainAxisSpacing: 10, // espaço vertical
            childAspectRatio: 3 / 4, // proporção largura/altura
          ),
          itemBuilder: (context, index) {
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  imagens[index],
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
