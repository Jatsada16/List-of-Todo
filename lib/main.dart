import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pinkAccent),
        useMaterial3: true,
      ),
      home: const TodaApp(),
    );
  }
}

class TodaApp extends StatefulWidget {
  const TodaApp({
    super.key,
  });

  @override
  State<TodaApp> createState() => _TodaAppState();
}

class _TodaAppState extends State<TodaApp> {
  late TextEditingController _titleController;
  late TextEditingController _detailsController;
  final List<Map<String, String>> _myList = [];

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _detailsController = TextEditingController();
  }

  void addTodoHandle(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            title: const Text(
              "Add New Task",
              style: TextStyle(color: Colors.pinkAccent),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Colors.pinkAccent,
                        width: 2,
                      ),
                    ),
                    labelText: "Task Title",
                    labelStyle: const TextStyle(color: Colors.pinkAccent),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _detailsController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Colors.pinkAccent,
                        width: 2,
                      ),
                    ),
                    labelText: "Task Details",
                    labelStyle: const TextStyle(color: Colors.pinkAccent),
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    setState(() {
                      _myList.add({
                        'title': _titleController.text,
                        'details': _detailsController.text,
                      });
                    });
                    _titleController.clear();
                    _detailsController.clear();
                    Navigator.pop(context);
                  },
                  child: const Text("Save",
                      style: TextStyle(color: Colors.pinkAccent))),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel",
                      style: TextStyle(color: Colors.pinkAccent))),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo List"),
        backgroundColor: Colors.pinkAccent,
      ),
      body: _myList.isEmpty
          ? const Center(
              child: Text('No tasks added yet!',
                  style: TextStyle(color: Colors.pinkAccent, fontSize: 18)),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: _myList.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(color: Colors.pinkAccent, width: 2),
                  ),
                  child: ListTile(
                    title: Text(
                      _myList[index]['title'] ?? "",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(_myList[index]['details'] ?? ""),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addTodoHandle(context);
        },
        backgroundColor: Colors.pinkAccent,
        child: const Icon(Icons.add),
      ),
    );
  }
}
