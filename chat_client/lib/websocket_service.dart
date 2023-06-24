import 'dart:convert';
import 'package:chat_client/message.dart';
import 'package:web_socket_channel/html.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketService {
  // final WebSocketChannel _channel =
  //     WebSocketChannel.connect(Uri.parse('ws://localhost:8080/stomp'));
  // final WebSocketChannel chl = IOWebSocketChannel.connect(
  //   Uri.parse('ws://localhost:8080/stomp'));
  final WebSocketChannel _channel =
      WebSocketChannel.connect(Uri.parse('wss://echo.websocket.events'));

  final List<Message> _messages = [
    Message(username: 'user1', text: 'text'),
    Message(username: 'user2', text: 'text2'),
    Message(username: 'user3', text: 'text3'),
  ];

  void subscribe() {
    // _channel.sink.add(jsonEncode({'destination': '/topic/messages'}));
    // _channel.stream.listen((message) {
    //   print(message);
    // });
  }

  void send(Map<String, String> data) {
    // _channel.sink.add(jsonEncode({
    //   'destination': '/topic/messages',
    //   'body': jsonEncode(data),
    // }));
  }
  List<Message> get_messages() {
    return _messages;
  }

  void disconnect() {
    // _channel.sink.close();
  }
}
