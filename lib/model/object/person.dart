class Person {
  String role, name, email, image, token;

  Person({this.token, this.name, this.email, this.image, this.role});

  @override
  String toString() {
    return 'Person{role: $role, name: $name, email: $email, image: $image, token: $token}';
  }

/*  factory Person.fromJson(Map<String , dynamic> json)=>User(
    role: json['role'],
    email: json['email'],
    token: json['token'],
  );*/

}