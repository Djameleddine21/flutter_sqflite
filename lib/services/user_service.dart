import 'package:flutter_sqflite/database_helper.dart';
import 'package:flutter_sqflite/models/user.dart';

class UserService {
  DataBaseHelper db = DataBaseHelper();

  Future<List<User>> allUsers() async {
    List items = List();
    List<User> list = List<User>();
    items = await db.getAllUsers();
    for (var item in items) {
      User user = User.fromMap(item);
      print(
          "ID : ${user.id} + User : ${user.usename} + Password : ${user.password}");
      list.add(user);
    }
    return list;
  }

  void create() async {
    int savedUserID =
        await db.createUser(User(username: "Jato", password: "123456"));
  }

  void delete() async {
    int savedUserID = await db.deleteUser(0);
  }

  void update() async {
    int savedUserID =
        await db.updateUser(User(username: "USER", password: "000000", id: 2));
  }
}
//0697634328
