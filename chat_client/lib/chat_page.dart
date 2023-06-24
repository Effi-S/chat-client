import 'package:chat_client/websocket_service.dart';
import 'package:flutter/material.dart';
import 'message.dart';
import 'message_service.dart';

class ChatPage extends StatefulWidget {
  final String username;

  const ChatPage({Key? key, required this.username}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
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

  void _sendMessage() {
    String messageText = _messageController.text;
    if (messageText.isNotEmpty) {
      webSocketService.send(
        {'message': messageText, 'username': widget.username},
      );
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Message> messages = webSocketService.get_messages();
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat [${widget.username}]'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                Message message = messages[index];
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
