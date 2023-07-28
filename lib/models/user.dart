class User {
  String? id;
  String? name;
  String? email;
  String? role;
  String? classroom;
  User({this.id, this.name, this.email, this.role, this.classroom});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['user']['id'].toString(),
        name: json['user']['name'].toString(),
        email: json['user']['email'].toString(),
        classroom: json['classroom'][0].toString(),
        role: json['user']['role'].toString());
  }
}
