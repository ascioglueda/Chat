import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final String username;

  ChatPage({required this.username});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  bool isDarkMode = false;
  List<Message> messages = [];

  TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Önceden var olan konuşmaları ekleyin
    messages.addAll([
      Message(text: 'Merhaba', isMe: false),
      Message(text: 'Merhaba, Nasılsın?', isMe: true),
      Message(text: 'İyiyim sen nasılsın?', isMe: false),
      Message(text: 'İyiyim ben de teşekkür ederim.', isMe: true),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.username,
          style: TextStyle(
            color: _getAppBarTextColor(),
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: _getIconColor(),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: IconButton(
              icon: Icon(
                isDarkMode ? Icons.dark_mode : Icons.light_mode,
                color: _getIconColor(),
              ),
              onPressed: () {
                setState(() {
                  isDarkMode = !isDarkMode;
                });
              },
            ),
          ),
        ],
        backgroundColor: _getAppBarColor(),
      ),
      backgroundColor: _getBackgroundColor(),
      body: Column(
        children: [
          SizedBox(height: 10,),
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return Align(
                  alignment: messages[index].isMe
                      ? Alignment.topRight
                      : Alignment.topLeft,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: messages[index].isMe
                          ? Color(0xFF914A98)
                          : isDarkMode
                          ? Colors.black
                          : Color(0xA8FFFFFF),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      messages[index].text,
                      style: TextStyle(
                        color: _getTextColor(),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            color: isDarkMode ? Colors.black : Color(0xFFDFDBE7),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      style: TextStyle(color: _getTextColor()),
                      decoration: InputDecoration(
                        hintText: 'Mesajınızı buraya yazın...',
                        hintStyle:
                        TextStyle(color: _getTextColor().withOpacity(0.5)),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.send,
                      color: Color(0xFF914A98),
                    ),
                    onPressed: () {
                      // Kullanıcıdan alınan mesajı listeye ekle
                      if (_messageController.text.isNotEmpty) {
                        setState(() {
                          messages.add(Message(
                            text: _messageController.text,
                            isMe: true,
                          ));
                          // Karşı taraftan sahte bir cevap ekle (örnek amaçlı)
                          messages.add(Message(
                            text: 'Teşekkür ederim.',
                            isMe: false,
                          ));
                          _messageController.clear();
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getAppBarColor() {
    return isDarkMode ? Colors.black : Color(0xFFF2E7F3);
  }

  Color _getBackgroundColor() {
    return isDarkMode ? Colors.black : Color(0xFFDFDBE7);
  }

  Color _getIconColor() {
    return isDarkMode ? Colors.white : Colors.black;
  }

  Color _getTextColor() {
    return isDarkMode ? Colors.white : Colors.black;
  }

  Color _getAppBarTextColor() {
    return isDarkMode ? Colors.white : Colors.black;
  }
}

class Message {
  final String text;
  final bool isMe;

  Message({required this.text, required this.isMe});
}
