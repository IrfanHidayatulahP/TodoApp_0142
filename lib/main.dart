import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Activity',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'My Activity'), // Panggil class MyHomePage
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20), // Padding untuk sisi kiri
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Menyusun elemen di kiri
          children: [
            const SizedBox(height: 20), // Jarak dari atas
            const Text(
              'Tambah Todo List', // Teks di kiri
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10), // Jarak antara teks dan tombol
            Center(
              child: ElevatedButton(
                onPressed: () {
                },
                style: ElevatedButton.styleFrom( // Warna ikon putih agar kontras
                  minimumSize: const Size(200, 50), // Ukuran tombol (lebar x tinggi)
                ),
                child: const Icon(Icons.work, size: 30), // Ikon di tengah tombol
              ),
            ),
          ],
        ),
      ),
    );
  }
}