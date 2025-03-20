import 'package:flutter/material.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final TextEditingController _taskController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  List<Map<String, dynamic>> listTugas = [];

  void addData() {
    if (_key.currentState!.validate()) {
      setState(() {
        listTugas.add({
          'task': _taskController.text,
          'date': _dateController.text,
          'done': false,
        });

        // Kosongkan input setelah submit
        _taskController.clear();
        _dateController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}