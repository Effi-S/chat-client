import 'package:chat_client/chat_page.dart';
import 'package:chat_client/error_dialog.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();

  void _login() async {
    String username = _usernameController.text;
    if (username.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => ErrorDialog(
          message: 'Please enter a username.',
          onRetry: () => Navigator.pop(context),
        ),
      );
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatPage(username: username),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  hintText: 'Username',
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _login,
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
