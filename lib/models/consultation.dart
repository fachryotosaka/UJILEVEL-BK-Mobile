class Consultation {
  String? id;
  String? title;
  String? description;
  String? status;
  String? place;
  String? result;
  String? reason;
  String? serviceName;
  String? teacher_name;
  Consultation({this.id, this.title, this.description, this.status, this.place, this.result,  this.reason, this.serviceName, this.teacher_name});

  factory Consultation.fromJson(Map<String, dynamic> json) {
    return Consultation(
        id: json['id'].toString(),
        title: json['title'],
        description: json['description'],
        status: json['status'],
        place: json['place'],
        result: json['result'],
        reason: json['reason'],
        serviceName: json['service_name'],
        teacher_name: json['teacher_name'],
      );
  }
}