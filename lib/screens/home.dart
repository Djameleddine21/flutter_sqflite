import 'package:flutter/material.dart';
import 'package:flutter_sqflite/models/user.dart';
import 'package:flutter_sqflite/services/user_service.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<User> _users = List<User>();
  UserService _userService;

  @override
  void initState() {
    super.initState();
    _userService = UserService();
  }

  getUsers() async {
    _users = await _userService.allUsers();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("SQF Lite EX"), centerTitle: true),
        body: Padding(
          padding: EdgeInsets.all(15.0),
          child: FutureBuilder(
            future: getUsers(),
            builder: (_, data) {
              if (data.hasData == null) {
                return CircularProgressIndicator();
              }
              return ListView.builder(
                itemCount: _users.length,
                itemBuilder: (_,index) {
                  return ListTile(
                    leading: Text(_users[index].id.toString()),
                    title: Text(_users[index].usename),
                    subtitle: Text(_users[index].password),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
