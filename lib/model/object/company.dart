
import 'package:realstatefrombegin3/model/object/person.dart';

class Company extends Person{

  String about;

  Company(
      {String email,
        String name,
        String image,
        String token,
        this.about,})
      : super(
      email: email,
      name: name,
      image: image,
      token: token,
      role: 'company');

  factory Company.fromJson(Map<String , dynamic> json)=> Company(
    email: json['email'],
    token: json['token'],
    image: json['image'],
    about: json['about'],
  );

}