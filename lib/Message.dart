import 'dart:math';

import 'package:flutter/material.dart';
import 'Chat.dart'; // Chat sayfasını import et

class MessagePage extends StatefulWidget {
  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  bool isDarkMode = false;
  Map<String, Color> userColors = {
    "EDA": Color(0xFF4E1559),
    "FURKAN": Color(0xFF006064),
    "AHMET": Color(0xDA0399F5),
    "MELİS": Color(0xFFC51162),
  };

  List<String> users = ["EDA", "FURKAN", "AHMET", "MELİS"];

  // Örnek bir profil ikonu
  Widget _buildProfileIcon(String username) {
    return CircleAvatar(
      backgroundColor: userColors[username],
      child: Icon(
        Icons.person,
        color: Colors.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'New Chat',
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
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (BuildContext context, int index) {
          String username = users[index];

          // Her bir öğe için ListTile ve Divider oluşturun
          return Column(
            children: [
              SizedBox(height: 10),
              ListTile(
                leading: _buildProfileIcon(username),
                title: Text(
                  username,
                  style: TextStyle(
                    color: _getTextColor(),
                    fontSize: 20,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatPage(username: username),
                    ),
                  );
                },
                // Sil ikonu ekleyin ve tıklanınca kullanıcıyı silme işlemini gerçekleştirin
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    setState(() {
                      users.removeAt(index);
                    });
                  },
                  color: userColors[username],
                ),
              ),
              Divider(
                thickness: 2.0,
                color: _getDividerColor(),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // '+' ikonuna tıklandığında yeni bir kullanıcı ekleyin
          setState(() {
            String newUsername = "User ${users.length + 1}";
            users.add(newUsername);
            userColors[newUsername] = _generateRandomColor();
          });
        },
        child: Icon(Icons.add),
        backgroundColor: _getAppBarColor(),
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

  Color _getDividerColor() {
    return isDarkMode ? Colors.white : Colors.black;
  }

  Color _generateRandomColor() {
    // Rastgele renk oluştur
    return Color((Random().nextDouble() * 0xFFFFFF).toInt() << 0).withOpacity(1.0);
  }
}