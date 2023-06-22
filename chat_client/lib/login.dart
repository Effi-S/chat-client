import 'package:chat_client/chat_page.dart';
import 'package:chat_client/error_dialog.dart';
import 'package:chat_client/websocket_service.dart';
import 'package:flutter/material.dart';

import 'package:chat_client/message.dart';
import 'package:chat_client/message_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();

  final WebSocketService webSocketService = WebSocketService();
  final MessageService messageService = MessageService();

  @override
  void initState() {
    super.initState();
    webSocketService.subscribe();
  }

  @override
  void dispose() {
    webSocketService.disconnect();
    super.dispose();
  }

  void _login() async {
    String username = _usernameController.text;
    if (username.isNotEmpty) {
      List<Message> messages = await messageService.loadMessages();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChatPage(
            username: username,
            messages: messages,
            webSocketService: webSocketService,
          ),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => ErrorDialog(
          message: 'Please enter a username.',
          onRetry: () => Navigator.pop(context),
        ),
      );
    }
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
