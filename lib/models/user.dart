class User {
  int _id;
  String _username;
  String _password;

  User({int id, String username, String password})
      : this._id = id,
        this._username = username,
        this._password = password;

  User.map(dynamic obj) {
    this._username = obj['username'];
    this._password = obj['password'];
    this._id = obj['id'];
  }

  //getters
  String get usename => _username;
  String get password => _password;
  int get id => _id;

  Map<String, dynamic> toMap() {
    return {
      "username": this._username,
      "password": this._password,
      "id": this._id==null ? null : this._id 
    };
  }

  User.fromMap(Map<String, dynamic> map) {
    this._username = map["username"];
    this._password = map["password"];
    this._id = map["id"];
  }
}
