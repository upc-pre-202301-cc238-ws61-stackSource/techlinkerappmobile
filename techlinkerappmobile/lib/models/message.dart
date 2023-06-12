class Message {
  final int id;
  final String message;
  final int receiverId;

  Message({
    required this.id,
    required this.message,
    required this.receiverId,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'],
      message: json['message'],
      receiverId: json['receiver']['id'],
    );
  }

//method that return all object attributes as string
  @override
  String toString() {
    return 'Message{id: $id, message: $message, receiverId: $receiverId}';
  }
}
