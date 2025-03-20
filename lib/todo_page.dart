import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
        _taskController.clear();
        _dateController.clear();
      });

      // Tampilkan notifikasi
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Data berhasil ditambahkan!'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  Future<void> _selectDateTime(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        DateTime finalDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        setState(() {
          _dateController.text = DateFormat('dd-MM-yyyy HH:mm').format(finalDateTime);
        });
      }
    }
  }

  void _updateTaskStatus(int index, bool value) {
    setState(() {
      listTugas[index]['done'] = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Page'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Form(
                key: _key,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Task Date:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    const Text("Select a date and time", style: TextStyle(fontSize: 14)),
                    TextFormField(
                      controller: _dateController,
                      decoration: InputDecoration(
                        hintText: "Pilih tanggal dan waktu",
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.calendar_today, color: Colors.blue),
                          onPressed: () => _selectDateTime(context),
                        ),
                      ),
                      readOnly: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Tanggal tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _taskController,
                      decoration: InputDecoration(
                        labelText: "Task",
                        labelStyle: const TextStyle(color: Colors.purple),
                        hintText: "Masukkan nama tugas",
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.purple),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Task tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  onPressed: addData,
                  child: const Text('Submit', style: TextStyle(color: Colors.white)),
                ),
              ),
              const SizedBox(height: 16),
              const Text("List Tasks", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Expanded(
                child: ListView.builder(
                  itemCount: listTugas.length,
                  itemBuilder: (context, index) {
                    return Card(
                      color: Colors.grey[200],
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        title: Text(
                          listTugas[index]['task'] ?? '',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Deadline: ${listTugas[index]['date']}"),
                            Text(
                              listTugas[index]['done'] ? "Done" : "Not Done",
                              style: TextStyle(
                                color: listTugas[index]['done'] ? Colors.green : Colors.red,
                              ),
                            ),
                          ],
                        ),
                        trailing: Checkbox(
                          activeColor: Colors.purple,
                          value: listTugas[index]['done'],
                          onChanged: (bool? value) {
                            _updateTaskStatus(index, value!);
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
