
import 'package:realstatefrombegin3/model/object/person.dart';

class User extends Person{

  User(
      {String email,
        String name,
        String image,
        String token,})
      : super(
      email: email,
      name: name,
      image: image,
      token: token,
      role: 'user');

  factory User.fromJson(Map<String, dynamic> json) => User(
    email: json['Email'],
    name: json['Name'],
    image: json['image'],
    token: json['Token'],
  );

}