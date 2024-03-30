import 'package:flutter/material.dart';
import 'package:machine_test/database/db.dart';
import 'package:machine_test/model/user_model.dart';
import 'package:machine_test/ui/screen_login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen(
      {super.key,
      required this.name,
      required this.email,
      required this.mobile});

  final String name;
  final String email;
  final String mobile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: false,
        title: Text("Profile Page",style: TextStyle(color: Colors.white),),
        actions: [
          IconButton(
              onPressed: () async {
                final SharedPreferences prefs =
                    await SharedPreferences.getInstance();
                prefs.setBool("userlogin", false);
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ScreenLogin(),
                    ));
              },
              icon: Icon(Icons.logout,color: Colors.white,))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
         
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                backgroundColor: Colors.amber,
                radius: 140,
              ),
            ),
            Text("Name :$name",style: TextStyle(fontSize: 30),),
            Text("Email : $email",style: TextStyle(fontSize: 30),),
            Text("Mobile : $mobile",style: TextStyle(fontSize: 30),),
          ],
        ),
      ),
    );
  }
}
