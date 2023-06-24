import 'dart:async';
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
  final StreamController<List<Message>> _messageController =
      StreamController<List<Message>>();

  Stream<List<Message>> get messageStream => _messageController.stream;

  final List<Message> _messages = [
    Message(username: 'user1', message: 'text'),
    Message(username: 'user2', message: 'text2')
  ];

  void subscribe() {
    _channel.sink.add(jsonEncode({'destination': '/topic/messages'}));
    _channel.stream.listen((data) {
      Map<String, dynamic> decoded = jsonDecode(data);

      if (!decoded.containsKey('body')) {
        return;
      }
      Map<String, dynamic> msg = jsonDecode(decoded['body']);

      if (msg.containsKey('message') && msg.containsKey('username')) {
        print('Adding message: ' + msg['message']);
        _messages.add(Message.fromJson(msg));
        _messageController.add(_messages);
      }
      print('--------------------------------');
    });
  }

  void send(Map<String, String> data) {
    print('SENDING!!!!');
    print(data);
    print(_messages);
    print('--------------------------------');
    _channel.sink.add(jsonEncode({
      // 'destination': '/topic/messages',
      'body': jsonEncode(data),
    }));
  }

  List<Message> getMessages() {
    return _messages;
  }

  void disconnect() {
    _channel.sink.close();
  }
}
