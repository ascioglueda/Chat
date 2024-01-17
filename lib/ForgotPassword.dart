import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Message.dart';
import 'Register.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  TextEditingController _emailController = TextEditingController();

  Future<void> sendResetLink(String email) async {
    try {
      final response = await http.post(
        Uri.parse('http://********************/reset_password'), // Şifre sıfırlama API endpoint'i
        body: {
          'email': email,
        },
      );

      if (response.statusCode == 200) {
        // Şifre sıfırlama bağlantısı başarıyla gönderildi
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Şifre Sıfırlama Bağlantısı Gönderildi'),
            content: Text('E-posta adresinize bir şifre sıfırlama bağlantısı gönderildi.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Tamam'),
              ),
            ],
          ),
        );
      } else {
        // Şifre sıfırlama bağlantısı gönderme başarısız, hata mesajını yazdır
        print('Reset link failed: ${response.body}');
      }
     } catch (e) {
  // Hata durumu
  print('Error during reset link sending: $e');
  }

}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Şifremi Unuttum'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                hintText: 'E-posta Adresi',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.all(16.0),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Şifre sıfırlama bağlantısı gönder
                sendResetLink(_emailController.text);
              },
              child: Text('Şifre Sıfırlama Bağlantısı Gönder'),
            ),
          ],
        ),
      ),
    );
  }
}
