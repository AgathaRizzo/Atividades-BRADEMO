import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: TasksScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Task {
  final String title;
  final String date;
  bool isCompleted;

  Task({
    required this.title,
    required this.date,
    this.isCompleted = false,
  });
}

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  final List<Task> _allTasks = [
    Task(title: 'Task 2022-07-09', date: '18:08:31.734244'),
    Task(title: 'Task 2022-07-09', date: '18:08:22.210300'),
    Task(title: 'Task 2022-07-09', date: '18:08:32.629926'),
    Task(title: 'Task 2022-07-09', date: '18:08:33.073472'),
    Task(title: 'Task 2022-07-09', date: '18:08:33.934172'),
  ];

  List<Task> _displayedTasks = [];
  bool _showCompleted = false;

  @override
  void initState() {
    super.initState();
    _displayedTasks = _allTasks;
  }

  void _toggleTaskStatus(int index) {
    setState(() {
      _displayedTasks[index].isCompleted = !_displayedTasks[index].isCompleted;
      _updateDisplayedTasks();
    });
  }

  void _updateDisplayedTasks() {
    if (_showCompleted) {
      _displayedTasks = _allTasks.where((task) => task.isCompleted).toList();
    } else {
      _displayedTasks = _allTasks.where((task) => !task.isCompleted).toList();
    }
  }

  void _showAlertDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Informação"),
          content: const Text("Você está no App de Notas de Tarefas."),
          actions: <Widget>[
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    int uncompletedCount = _allTasks.where((task) => !task.isCompleted).length;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Kindacode.com',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Container(
        color: Colors.grey[200], // Cor de fundo levemente cinza
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    _showCompleted = !_showCompleted;
                    _updateDisplayedTasks();
                  });
                },
                child: Text(
                  _showCompleted ? "View Uncompleted Tasks" : "View Completed Tasks",
                  style: const TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'You have $uncompletedCount uncompleted tasks',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _displayedTasks.length,
                itemBuilder: (BuildContext context, int index) {
                  final task = _displayedTasks[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                    child: Card(
                      color: Colors.yellow[100],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    task.title,
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    task.date,
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                            Checkbox(
                              value: task.isCompleted,
                              onChanged: (bool? newValue) {
                                _toggleTaskStatus(index);
                              },
                              activeColor: Colors.blue,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAlertDialog,
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}