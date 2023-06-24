import 'package:chat_client/message.dart';

class MessageService {
  Future<List<Message>> loadMessages() async {
    // final response =
    //     await http.get(Uri.parse('http://localhost:8080/api/v1/users/get/all'));

    //   if (response.statusCode == 200) {
    //     List<dynamic> data = jsonDecode(response.body);
    //     return data.map((message) => Message.fromJson(message)).toList();
    //   } else {
    //     throw Exception('Failed to load messages');
    //   }
    return [
      Message(username: 'user1', text: 'text'),
      Message(username: 'user2', text: 'text2'),
      Message(username: 'user3', text: 'text3'),
    ]; // Uncomment to MOCK
  }
}
