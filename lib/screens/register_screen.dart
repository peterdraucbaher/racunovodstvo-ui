import 'package:flutter/material.dart';
import '../api/auth_service.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _userController = TextEditingController();
  final _passController = TextEditingController();

  void _handleRegister() async {
    bool success = await AuthService.register(_userController.text, _passController.text);
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Uporabnik ustvarjen!")));
      Navigator.pop(context); // Vrni se na login
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Napaka pri registraciji!")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Registracija")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _userController, decoration: InputDecoration(labelText: "Uporabniško ime")),
            TextField(controller: _passController, decoration: InputDecoration(labelText: "Geslo"), obscureText: true),
            SizedBox(height: 20),
            ElevatedButton(onPressed: _handleRegister, child: Text("Ustvari račun")),
          ],
        ),
      ),
    );
  }
}