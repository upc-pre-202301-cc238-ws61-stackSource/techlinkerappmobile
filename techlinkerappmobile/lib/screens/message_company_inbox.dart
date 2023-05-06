import 'package:flutter/material.dart';
import 'package:techlinkerappmobile/constants/colors.dart';
import '../constants/colors.dart';

class CompanyMessageInbox extends StatefulWidget {
  const CompanyMessageInbox({super.key});

  @override
  State<CompanyMessageInbox> createState() => _CompanyMessageInboxState();
}

class _CompanyMessageInboxState extends State<CompanyMessageInbox> {
  final TextEditingController _textController = TextEditingController();
  final List<Map<String, dynamic>> _messages = [
    {
      'text': 'Hello',
      'isMe': true,
      'time': DateTime.now().subtract(const Duration(minutes: 10)),
    },
    {
      'text': 'Hi there!',
      'isMe': false,
      'time': DateTime.now().subtract(const Duration(minutes: 5)),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Row(
          children: const [
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(
                  'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
            ),
            const SizedBox(width: 15),
            Text(
              'User Name',
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
        // Add an app bar background color
      ),
      body: Container(
        child: Column(children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              reverse: true,
              itemBuilder: (BuildContext context, int index) {
                final message = _messages[index];
                return Row(
                  mainAxisAlignment: message['isMe']
                      ? MainAxisAlignment.end
                      : MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: message['isMe'] ? primaryColor : buttonColor,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(16),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: message['isMe']
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start,
                        children: [
                          Text(
                            message['text'],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            message['time'].toString(),
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: const InputDecoration(
                      hintText: 'Type a message',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    if (_textController.text.trim().isNotEmpty) {
                      setState(() {
                        _messages.add({
                          'text': _textController.text.trim(),
                          'isMe': true,
                          'time': DateTime.now(),
                        });
                        _textController.clear();
                      });
                    }
                  },
                  child: const Icon(Icons.send),
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(16),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
