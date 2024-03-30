import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class UserNotFound extends StatelessWidget {
  const UserNotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text(
          "User Not Found",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30,color: Colors.red),
        ),
      ),
    );
  }
}
