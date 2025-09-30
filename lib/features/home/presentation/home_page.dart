import 'package:flutter/material.dart';
import '../../auth/presentation/pages/login_page.dart';

class HomePage extends StatelessWidget {
  final String username;
  const HomePage({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage()),
          ), //back
        ),
        title: const Text("Home"),
      ),
      body: Center(
        child: Text(
          "Xin chào $username 👋",
          style: const TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }
}
