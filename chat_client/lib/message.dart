class Message {
  final String username;
  final String message;

  Message({
    required this.username,
    required this.message,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      username: json['username'],
      message: json['message'],
    );
  }
}
