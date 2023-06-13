import 'package:flutter/material.dart';
import 'package:techlinkerappmobile/constants/colors.dart';
import 'package:techlinkerappmobile/models/company_x_message.dart';
import 'package:techlinkerappmobile/models/developer_unique_item.dart';
import 'package:techlinkerappmobile/models/developer_x_message.dart';
import 'package:techlinkerappmobile/models/message_post.dart';
import 'package:techlinkerappmobile/services/developer_service.dart';
import 'package:techlinkerappmobile/widgets/developer_item.dart';
import '../constants/colors.dart';
import '../models/message.dart';
import '../services/company_service.dart';

class DeveloperMessageInbox extends StatefulWidget {
  final int developerId;
  final CompanyMessage item;
  const DeveloperMessageInbox(
      {super.key, required this.developerId, required this.item});

  @override
  State<DeveloperMessageInbox> createState() => _DeveloperMessageInboxState();
}

class _DeveloperMessageInboxState extends State<DeveloperMessageInbox> {
  final TextEditingController _textController = TextEditingController();
  List<Message> developerMessages = <Message>[];
  List<Message> companyMessages = <Message>[];

  final List<Map<String, dynamic>> _messages = [];

  @override
  void initState() {
    super.initState();
    getAllMessagesByReciverId(widget.developerId.toString()).then((value) {
      // update _messages with isMe = false, with the company messages data
      for (var message in companyMessages) {
        setState(() {
          _messages.add({
            'id': message.id,
            'text': message.message,
            'isMe': true,
            'time': DateTime.now().subtract(const Duration(minutes: 5)),
          });
        });
      }

      // update _messages with isMe = true, with the developer messages data
      for (var message in developerMessages) {
        setState(() {
          _messages.add({
            'id': message.id,
            'text': message.message,
            'isMe': false,
            'time': DateTime.now().subtract(const Duration(minutes: 5)),
          });
        });
      }

      //order the messages by id
      _messages.sort((a, b) => a['id'].compareTo(b['id']));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(widget.item.company.image!),
            ),
            const SizedBox(width: 15),
            Text(
              widget.item.company.firstName!,
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
            Color(0xFF39BCFD),
            Color(0xFF4F93E9),
            Color(0xFF7176EE),
          ])),
        ),
        // Add an app bar background color
      ),
      body: Container(
        child: Column(children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              reverse: false,
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
                        color: message['isMe']
                            ? Color(0xFF7176EE)
                            : Color.fromARGB(255, 221, 221, 221),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(16),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: message['isMe']
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start,
                        children: [
                          message['isMe']
                              ? Text(
                                  analyseMessage(message['text']),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                )
                              : Text(
                                  analyseMessage(message['text']),
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 120, 120, 120),
                                    fontSize: 16,
                                  ),
                                ),
                          const SizedBox(height: 8),
                          message['isMe']
                              ? Text(
                                  '${message['time'].hour}:${message['time'].minute}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                )
                              : Text(
                                  '${message['time'].hour}:${message['time'].minute}',
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 120, 120, 120),
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
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: const InputDecoration(
                      hintStyle:
                          TextStyle(color: Color.fromARGB(255, 120, 120, 120)),
                      hintText: 'Type a message',
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 221, 221, 221))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 221, 221, 221))),
                      filled: true,
                      fillColor: Color.fromARGB(255, 221, 221, 221),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    if (_textController.text.trim().isNotEmpty) {
                      insertMessage(
                          _textController.text.trim(),
                          widget.developerId,
                          widget.item.company.id.toString());

                      setState(() {
                        //update the messages view (update _messages)

                        _textController.clear();
                      });
                    }
                  },
                  child: const Icon(Icons.send),
                  style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(16),
                      backgroundColor: Color(0xFF7176EE)),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  String analyseMessage(String message) {
    String newMessage = "";
    int count = 0;

    for (int i = 0; i < message.length; i++) {
      newMessage += message[i];
      count++;

      if (count == 30) {
        // Check if the current character is a space
        if (message[i] != " ") {
          // Search backward for the previous space to insert the line break
          int j = i;
          while (j >= 0 && message[j] != " ") {
            j--;
          }
          if (j >= 0) {
            newMessage = newMessage.substring(0, j + 1) +
                "\n" +
                newMessage.substring(j + 1);
            count = i - j;
          }
        } else {
          newMessage += "\n";
          count = 0;
        }
      }
    }

    return newMessage;
  }

  Future getAllMessagesByReciverId(String id) async {
    List<Message> messages = <Message>[];

    try {
      final messagesData =
          await DeveloperService.getMessagesByDeveloperAndReciverId(
              id, widget.item.company.id.toString());
      if (mounted) {
        messages.addAll(messagesData
            .map<Message>((message) => Message.fromJson(message))
            .toList());
      }
    } catch (e) {
      print('Failed to fetch messages data. Error: $e');
    }

    for (var message in messages) {
      if (message.receiverId.toString() == widget.developerId.toString()) {
        developerMessages.add(message);
      } else {
        companyMessages.add(message);
      }
    }

    setState(() {});
  }

  Future insertMessage(
      String myMessage, int senderId, String receiverId) async {
    final message = MessagePost(
        emitter: Emitter.withId(id: senderId),
        id: 0,
        message: myMessage,
        receiver: Receiver.withId(id: int.parse(receiverId)));

    try {
      await CompanyService.postMessage(message).then((value) {
        MessagePost post = MessagePost.fromJson(value);

        print(post.id);
        print(post.message);

        if (value != null) {
          setState(() {
            _messages.add({
              'id': post.id,
              'text': post.message,
              'isMe': true,
              'time': DateTime.now().subtract(const Duration(minutes: 5)),
            });
          });
        }
      });

      // update _messages with isMe = true, with the developer messages data
    } catch (e) {
      print('Failed to post message. Error: $e');
    }
  }
}
