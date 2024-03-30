import 'package:flutter/material.dart';
import 'package:machine_test/database/db.dart';
import 'package:machine_test/model/user_model.dart';
import 'package:machine_test/ui/profile_screen.dart';

import 'package:machine_test/ui/screen_register.dart';
import 'package:machine_test/ui/user_not_found.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<User>? userList = [];

class ScreenLogin extends StatelessWidget {
  const ScreenLogin({super.key});

  @override
  Widget build(BuildContext context) {
    DBManager().getUserList();

    TextEditingController usernameController = TextEditingController();
    TextEditingController PasswordController = TextEditingController();
    late List<User> userList;

    final deviceHeight = MediaQuery.sizeOf(context).height;
    final deviceWidth = MediaQuery.sizeOf(context).width;

    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                SizedBox(
                  height: deviceHeight * 0.070,
                ),
                SizedBox(
                  height: deviceHeight * 0.040,
                ),
                SizedBox(
                  width: deviceWidth * 0.68,
                  height: deviceHeight * 0.065,
                  child: TextFormField(
                    controller: usernameController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.perm_identity,
                        color: Colors.black,
                      ),
                      hintText: "User Id",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF1C3C3A),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: deviceHeight * 0.040,
                ),
                SizedBox(
                  width: deviceWidth * 0.68,
                  height: deviceHeight * 0.065,
                  child: TextFormField(
                    controller: PasswordController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.key,
                        color: Colors.black,
                      ),
                      hintText: "Password",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF1C3C3A),
                        ),
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 50, right: 63, top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Forget Password?",
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                SizedBox(
                  width: deviceWidth * 0.68,
                  height: deviceHeight * 0.060,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      elevation: const MaterialStatePropertyAll(10),
                      shadowColor: const MaterialStatePropertyAll(Colors.black),
                      backgroundColor:
                          const MaterialStatePropertyAll(Color(0xFF1C3C3A)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    onPressed: () async {
                      final SharedPreferences prefs =
                          await SharedPreferences.getInstance();

                      List<User> listData =
                          await DBManager().getUserList() as List<User>;

                      for (int i = 0; i <= listData.length; i++) {
                        if (usernameController.text ==
                            listData[i].id.toString()) {
                          if (PasswordController.text == listData[i].password) {
                            prefs.setBool("userlogin", true);
                            prefs.setInt("loggedinUser", i);
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => ProfileScreen(
                                        name: listData[i].name.toString(),
                                        email: listData[i].email.toString(),
                                        mobile: listData[i].phone.toString(),
                                      )),
                            );
                          }
                        } else {
                          
                        }
                      }
                    },
                    child: const Text(
                      "LOGIN",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(
                  height: deviceHeight * 0.020,
                ),
                const Text("or"),
                SizedBox(
                  height: deviceHeight * 0.020,
                ),
                SizedBox(
                  height: deviceHeight * 0.050,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don’t have an account?"),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (_) => const SignUp()));
                      },
                      child: const Text(
                        " Sign up",
                        style: TextStyle(
                          color: Color(0xFF1C3C3A),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
