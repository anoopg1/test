import 'package:flutter/material.dart';
import 'package:machine_test/database/db.dart';
import 'package:machine_test/model/user_model.dart';
import 'package:machine_test/ui/profile_screen.dart';
import 'package:machine_test/ui/screen_login.dart';
import 'package:machine_test/ui/screen_register.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<User> userList = [];

class ScreenHome extends StatelessWidget {
  const ScreenHome({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    DBManager dbManager = DBManager();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () async {
                final SharedPreferences prefs =
                    await SharedPreferences.getInstance();
                prefs.setBool("userlogin", false);
                int i = prefs.getInt("loggedinUser")!.toInt();
                List<User> listData = await DBManager().getUserList();
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ProfileScreen(
                      name: listData[i].name,
                      email: listData[i].email,
                      mobile: listData[i].phone),
                ));
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: FutureBuilder(
        future: dbManager.getUserList(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            userList = snapshot.data as List<User>;
            return ListView.builder(
              itemCount: userList.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ProfileScreen(
                          name: userList[index].name.toString(),
                          email: userList[index].email.toString(),
                          mobile: userList[index].phone.toString()),
                    ));
                  },
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Text("Id : "),
                                  Text(userList[index].id.toString()),
                                ],
                              ),
                              IconButton(
                                  onPressed: () async {
                                    await DBManager()
                                        .deleteStudent(userList[index].id);
                                    build(context);
                                  },
                                  icon: Icon(Icons.delete))
                            ],
                          ),
                          Row(
                            children: [
                              Text("Name : "),
                              Text(userList[index].name.toString()),
                            ],
                          ),
                          Row(
                            children: [
                              Text("E-mail : "),
                              Text(userList[index].email.toString()),
                            ],
                          ),
                          Row(
                            children: [
                              Text("Phone : "),
                              Text(userList[index].phone.toString()),
                            ],
                          ),
                          Row(
                            children: [
                              Text("Password : "),
                              Text(userList[index].password.toString()),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
          return CircularProgressIndicator();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => SignUp(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
