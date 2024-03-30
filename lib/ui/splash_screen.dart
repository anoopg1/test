import 'package:flutter/material.dart';
import 'package:machine_test/database/db.dart';
import 'package:machine_test/model/user_model.dart';
import 'package:machine_test/ui/profile_screen.dart';
import 'package:machine_test/ui/screen_home.dart';
import 'package:machine_test/ui/screen_login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    checkLoginStatus(context);
    return const Scaffold(
      body: Center(
        child: Text("Splash Screen"),
      ),
    );
  }

  void checkLoginStatus(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.get("userlogin");
    int i = prefs.getInt("loggedinUser")!.toInt();

    if (prefs.get("userlogin") == true) {
      List<User> listData = await DBManager().getUserList();
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ProfileScreen(
            name: listData[i].name,
            email: listData[i].email,
            mobile: listData[i].phone),
      ));
    } else {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const ScreenLogin(),
      ));
    }
  }
}
