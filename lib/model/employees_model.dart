import 'dart:convert';

import 'dart:typed_data';

class Employees {
  Employees({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.gender,
    this.employeePic,
  });

  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? gender;
  Uint8List? employeePic;

  factory Employees.fromJson(Map<String, dynamic> json) => Employees(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        gender: json["gender"],
    employeePic: base64Decode(json["employee_pic"].replaceAll('data:image/png;base64,', '')),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "gender": gender,
        "employee_pic": employeePic,
      };
}
