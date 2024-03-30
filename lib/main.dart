import 'package:flutter/material.dart';
import 'package:machine_test/database/db.dart';

import 'package:machine_test/ui/screen_login.dart';
import 'package:machine_test/ui/splash_screen.dart';

void main() {
  DBManager().openDB();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
