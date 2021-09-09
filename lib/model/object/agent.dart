import 'package:realstatefrombegin3/model/object/person.dart';

class Agent extends Person {
  String company, country, language,phone;

  Agent(
      {String email,
      String name,
      String image,
      String token,
      this.company,
      this.country,
      this.language,
      this.phone})
      : super(
            email: email,
            name: name,
            image: image,
            token: token,
            role: 'agent');

  factory Agent.fromJson(Map<String, dynamic> json) => Agent(
      email: json['email'],
      name: json['name'],
      image: json['image'],
      token: json['token'],
      company: json['company_id'],
      phone: json['phone']);
}
