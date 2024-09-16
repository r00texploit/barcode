import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  String? id;
  String? name;
  String? email;
  String? type;
  int? number;

  Users(
      {this.id,
      required this.name,
      required this.email,
      required this.number,
      required this.type});

  Users.fromMap(DocumentSnapshot data) {
    id = data.id;
    name = data["name"];
    email = data["email"];
    number = data["number"];
    type = data["type"];
  }
}
