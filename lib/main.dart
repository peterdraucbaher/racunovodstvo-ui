import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // DODAJ TO
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

Future<void> login(String username, String password) async {
  final url = Uri.parse('http://localhost:8080/api/auth/login');
  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'username': username, 'password': password}),
  );

  if (response.statusCode == 200) {
    String token = response.body; // To je tvoj JWT
    print("Uspešna prijava, token: $token");
    // Token shrani v RAM (npr. v singleton razred)
  } else {
    print("Napaka pri prijavi: ${response.statusCode}");
  }
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const BunkerPage(),
    );
  }
}

class BunkerPage extends StatefulWidget {
  const BunkerPage({super.key});

  @override
  State<BunkerPage> createState() => _BunkerPageState();
}

class _BunkerPageState extends State<BunkerPage> {
  String _odgovor = "Vpiši besedo in pritisni gumb";
  // To je "posoda" za besedilo
  final TextEditingController _controller = TextEditingController();

  Future<void> _klicBunkerja() async {
    try {
      // Vzamemo besedilo iz polja
      String vnos = _controller.text;
      final url = Uri.parse('http://127.0.0.1:8080/pozdrav?beseda=$vnos');
      final response = await http.get(url);

      setState(() {
        _odgovor = response.body;
      });
    } catch (e) {
      setState(() {
        _odgovor = "Napaka: Bunker ni dosegljiv!";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Bunker Interface")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _controller, // Povežemo polje z našo posodo
              decoration: const InputDecoration(labelText: 'Vpiši svojo besedo'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _klicBunkerja,
              child: const Text("Pošlji v Bunker"),
            ),
            const SizedBox(height: 20),
            Text(_odgovor, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}