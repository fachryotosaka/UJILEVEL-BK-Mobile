class Profile {
  String? photo_path;
  Profile({this.photo_path});

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      photo_path: json['photo_path'].toString(),
    );
  }
}
