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

  //create method to Json
  Map<String, dynamic> toJson() => {
        'id': id,
        'message': message,
        'receiverId': receiverId,
      };

  //Create a empy method
  static Message empty() {
    return Message(
      id: 0,
      message: '',
      receiverId: 0,
    );
  }

//method that return all object attributes as string
  @override
  String toString() {
    return 'Message{id: $id, message: $message, receiverId: $receiverId}';
  }
}
