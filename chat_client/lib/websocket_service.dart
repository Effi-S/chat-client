import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketService {
  late WebSocketChannel _channel;

  void connect(WebSocketChannel channel) {
    _channel = channel;
  }

  void subscribe() {
    _channel.sink.add(jsonEncode({'destination': '/app/chat'}));
    _channel.stream.listen((message) {
      print(message);
    });
  }

  void send(Map<String, String> data) {
    _channel.sink.add(jsonEncode({
      'destination': '/app/chat',
      'body': jsonEncode(data),
    }));
  }

  void disconnect() {
    _channel.sink.close();
  }
}
