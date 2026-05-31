import 'package:flutter/material.dart';
import '../api/auth_service.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _userController = TextEditingController();
  final _passController = TextEditingController();

  void _handleLogin() async {
    bool success = await AuthService.login(_userController.text, _passController.text);
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Prijava uspešna!")));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Napaka pri prijavi!")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Prijava v Računovodstvo")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _userController, decoration: InputDecoration(labelText: "Uporabniško ime")),
            TextField(controller: _passController, decoration: InputDecoration(labelText: "Geslo"), obscureText: true),
            SizedBox(height: 20),
            ElevatedButton(onPressed: _handleLogin, child: Text("Prijava")),
            TextButton(onPressed: () => Navigator.pushNamed(context, '/register'), child: Text("Še nimaš računa? Registracija"))
          ],
        ),
      ),
    );
  }
}