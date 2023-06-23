import 'package:web_socket_channel/html.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketService {
  final WebSocketChannel _channel =
      HtmlWebSocketChannel.connect('ws://localhost:8080/stomp');

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

  void disconnect() {
    // _channel.sink.close();
  }
}
