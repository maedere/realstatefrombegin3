import 'package:equatable/equatable.dart';


class Suite extends Equatable{

  final int id;
  final int hotelId;
  final int bed;
  final int room;
  final  String priceAll;
  final  bool kitchen;
  final  bool bathroom;
  final  bool breakFast;
  final  bool terrace;
  final  bool airConditioning;
  final  bool wifi;
  final  bool tv;
  final  bool animal;



  Suite({this.hotelId, this.bed, this.room, this.kitchen, this.bathroom, this.breakFast, this.terrace, this.airConditioning, this.wifi, this.tv, this.animal, this.id, this.priceAll,});

  factory Suite.fromJson(Map<String, dynamic> json) => Suite(
    id: json['id'],
    hotelId: json['hotel_id'],
    bed: json['bed'],
    room: json['room'],
    priceAll: json["price"].toString(),
    kitchen: json["kitchen"].toString().contains("1")?true:false,
    bathroom: json["bathroom"].toString().contains("1")?true:false,
    breakFast: json["breakfast_included"].toString().contains("1")?true:false,
    terrace: json["terrace"].toString().contains("1")?true:false,
    airConditioning: json["air_condition"].toString().contains("1")?true:false,
    wifi: json["wifi"].toString().contains("1")?true:false,
    tv: json["tv"].toString().contains("1")?true:false,
    animal: json["animal"].toString().contains("1")?true:false,


  );

  @override
  List<Object> get props => [id];

}

class MiniSuite extends Equatable{
  MiniSuite({
    this.name,
    this.level,
    this.priceAll,
    this.image,
    this.id
  });

  final  int id;
  final  String name;
  final  int level;
  final int priceAll;
  final  String image;

  factory MiniSuite.fromJson(Map<String, dynamic> json) => MiniSuite(
    id: json['id'],
    name: json["name"],
    level: json["level"],
    priceAll: json["price"],
    image: json["image"],
  );

  @override
  String toString() {
    return 'MiniSuite{id: $id, name: $name, level: $level , priceAll: $priceAll, image: $image}';
  }

  @override
  // TODO: implement props
  List<Object> get props => [id];
}

