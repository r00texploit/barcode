import 'package:cloud_firestore/cloud_firestore.dart';

class Admin {
  String? id;
  String? name;
  String? email;
  String? type;
  int? number;

  Admin(
      {this.id,
      required this.name,
      required this.email,
      required this.number,
      required this.type});

  Admin.fromMap(DocumentSnapshot data) {
    id = data.id;
    name = data["name"];
    email = data["email"];
    number = data["number"];
    type = data["type"];
  }
}
