import 'package:machine_test/model/user_model.dart';
import 'package:machine_test/ui/screen_home.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBManager {
  late Database _datebase;

  Future openDB() async {
    _datebase = await openDatabase(join(await getDatabasesPath(), "user.db"),
        version: 1, onCreate: (Database db, int version) async {
      await db.execute(
          "CREATE TABLE user(id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,email TEXT,phone TEXT,password TEXT)");
    });
  }

  Future<int> insertUser(User user) async {
    await openDB();
    return await _datebase.insert('user', user.toMap());
  }

  Future<List<User>> getUserList() async {
    await openDB();
    final List<Map<String, dynamic>> maps = await _datebase.query('user');
    return userList = List.generate(maps.length, (index) {
      return User(
        id: maps[index]['id'],
        name: maps[index]['name'],
        email: maps[index]['email'],
        phone: maps[index]['phone'],
        password: maps[index]['password'],
      );
    });
  }

  Future<int> updateUser(User user) async {
    await openDB();
    return await _datebase
        .update('user', user.toMap(), where: 'id=?', whereArgs: []);
  }

  Future<void> deleteStudent(int? id) async {
    await openDB();
    await _datebase.delete("user", where: "id = ? ", whereArgs: [id]);
  }
}
