class MessageCompany {
  final int id;
  final String message;
  final int receiverId;

  MessageCompany({
    required this.id,
    required this.message,
    required this.receiverId,
  });

  factory MessageCompany.fromJson(Map<String, dynamic> json) {
    return MessageCompany(
      id: json['id'],
      message: json['message'],
      receiverId: json['emitter']['id'],
    );
  }

//method that return all object attributes as string
  @override
  String toString() {
    return 'Message{id: $id, message: $message, receiverId: $receiverId}';
  }
}
