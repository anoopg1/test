import 'package:flutter/material.dart';
import 'package:machine_test/database/db.dart';
import 'package:machine_test/model/user_model.dart';
import 'package:machine_test/ui/profile_screen.dart';
import 'package:machine_test/ui/screen_home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  hintText: ' Username',
                  labelText: 'name *',
                ),
                validator: (String? value) {
                  if (value!.contains("@")) {
                    return "invalidname";
                  }
                  if (value.isEmpty) {
                    return "must fill this field";
                  }
                },
              ),
              TextFormField(
                controller: phoneController,
                decoration: const InputDecoration(
                  icon: Icon(Icons.phone_android),
                  hintText: 'phone ',
                  labelText: 'phone *',
                ),
                validator: (String? value) {
                  if (value!.length != 10) {
                    return "invalidphone";
                  }
                  if (value.isEmpty) {
                    return "must have 10 digits";
                  }
                },
              ),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  icon: Icon(Icons.email),
                  hintText: 'Email ',
                  labelText: 'email *',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter your Email address';
                  }
                  if (!RegExp(
                          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                      .hasMatch(value)) {
                    return 'Enter a Valid Email address';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  icon: Icon(Icons.password),
                  hintText: 'password',
                  labelText: 'password *',
                ),
                validator: (String? value) {
                  if (value!.length < 8) {
                    return "invalid password";
                  }
                  if (value!.isEmpty) {
                    return "valid password";
                  }
                },
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    print("validation successfull");
                    await DBManager().insertUser(
                      User(
                          name: nameController.text,
                          email: emailController.text,
                          phone: phoneController.text,
                          password: passwordController.text),
                    );

                    List<User> listData =
                        await DBManager().getUserList() as List<User>;

                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => ProfileScreen(
                                name: listData[listData.length - 1]
                                    .name
                                    .toString(),
                                email: listData[listData.length - 1]
                                    .email
                                    .toString(),
                                mobile: listData[listData.length - 1]
                                    .phone
                                    .toString(),
                              )),
                    );
                    final SharedPreferences prefs =
                        await SharedPreferences.getInstance();

                    prefs.setBool("userlogin", true);
                  } else {
                    print("Validation Failed");
                  }
                },
                child: const Text("Register"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
