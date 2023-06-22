import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:chat_client/message.dart';

class MessageService {
  Future<List<Message>> loadMessages() async {
    final response = await http.get('http://localhost:8080/api/v1/users/get/all');
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((message) => Message.fromJson(message)).toList();
    } else {
      throw Exception('Failed to load messages');
    }
  }
}
