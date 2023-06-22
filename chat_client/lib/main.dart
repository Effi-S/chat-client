import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:chat_client/websocket_service.dart';
import 'package:chat_client/message_service.dart';
import 'package:chat_client/error_dialog.dart';

import 'message.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat Client',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final WebSocketChannel channel =
      IOWebSocketChannel.connect('ws://localhost:8080/stomp');
  final WebSocketService webSocketService = WebSocketService();
  final MessageService messageService = MessageService();

  @override
  void initState() {
    super.initState();
    webSocketService.connect(channel);
    webSocketService.subscribe();
  }

  @override
  void dispose() {
    webSocketService.disconnect();
    channel.sink.close();
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

class ChatPage extends StatefulWidget {
  final String username;
  final List<Message> messages;
  final WebSocketService webSocketService;

  const ChatPage({
    Key? key,
    required this.username,
    required this.messages,
    required this.webSocketService,
  }) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  void _sendMessage() {
    String messageText = _messageController.text;
    if (messageText.isNotEmpty) {
      widget.webSocketService.send(
        {'message': messageText, 'username': widget.username},
      );
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: widget.messages.length,
              itemBuilder: (context, index) {
                Message message = widget.messages[index];
                return ListTile(
                  title: Text(message.username),
                  subtitle: Text(message.text),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      hintText: 'Message',
                    ),
                  ),
                ),
                const SizedBox(width: 16.0),
                ElevatedButton(
                  onPressed: _sendMessage,
                  child: const Text('Send'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
