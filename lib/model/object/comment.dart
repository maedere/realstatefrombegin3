
class Comment {

  final String userId , message, image , name;
  final int id;

  Comment({this.userId, this.message, this.image, this.name, this.id});

  factory Comment.fromJson(Map<String,dynamic> json)=>Comment(
    id: json['id'],
    name: json['name'],
    message: json.containsKey("massage")?json['massage']:json['message'],
    image: json['image'],
    userId: json['username']
  );
}