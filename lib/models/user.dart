class User {
  String? id;
  String? name;
  String? email;
  String? role;
  String? classroom;
  String photo;
  String? password;
  User({this.id, this.name, this.email, this.role, this.classroom, required this.photo, this.password});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['user']['id'].toString(),
        name: json['user']['name'].toString(),
        email: json['user']['email'].toString(),
        classroom: json['classroom'][0].toString(),
        role: json['user']['role'].toString(),
        photo: json['photo'].toString(),
        password: json['user']['password'].toString(),
        );
  }
}