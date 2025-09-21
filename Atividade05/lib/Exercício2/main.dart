import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      home: MainApp(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<StatefulWidget> createState() {
    return MainAppState();
  }
}

class MainAppState extends State<MainApp> {
  int _selectedIndex = 0;
  bool _fabExpanded = false;

  final List<String> _tabs = const ["TAB: 0", "TAB: 1", "TAB: 2", "TAB: 3", "TAB: 4"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "BottomAppBar with FAB",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          _tabs[_selectedIndex],
          style: const TextStyle(fontSize: 26),
        ),
      ),
      floatingActionButton: _buildFab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 6,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _buildNavItem(Icons.menu, "This", 0),
              _buildNavItem(Icons.layers, "Is", 1),
              const SizedBox(width: 40),
              _buildNavItem(Icons.grid_view, "Bottom", 2),
              _buildNavItem(Icons.error, "Bar", 3),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String text, int index) {
    bool isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
          _fabExpanded = false;
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            icon,
            color: isSelected ? Colors.blue : Colors.grey,
          ),
          Text(
            text,
            style: TextStyle(
              color: isSelected ? Colors.blue : Colors.grey,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFab() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (_fabExpanded) ...<Widget>[
          _fabOption(Icons.message, "Mensagem", "msg_tag"),
          const SizedBox(height: 10),
          _fabOption(Icons.mail, "Nova Mensagem", "mail_tag"),
          const SizedBox(height: 10),
          _fabOption(Icons.phone, "Nova Chamada", "phone_tag"),
          const SizedBox(height: 10),
        ],
        FloatingActionButton(
          heroTag: 'main_fab',
          backgroundColor: Colors.blue,
          onPressed: () {
            setState(() {
              _fabExpanded = !_fabExpanded;
            });
          },
          child: Icon(_fabExpanded ? Icons.close : Icons.add),
        ),
      ],
    );
  }

  Widget _fabOption(IconData icon, String tooltip, String heroTag) {
    return FloatingActionButton(
      mini: true,
      heroTag: heroTag,
      backgroundColor: Colors.white,
      onPressed: () {
        setState(() {
          _fabExpanded = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Selecionado: $tooltip")),
        );
      },
      child: Icon(icon, color: Colors.blue),
      tooltip: tooltip,
    );
  }
}