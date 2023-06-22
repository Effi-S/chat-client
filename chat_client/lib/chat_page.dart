import 'package:chat_client/websocket_service.dart';
import 'package:flutter/material.dart';
import 'message.dart';

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
        title: Text('Chat [${widget.username}]'),
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
