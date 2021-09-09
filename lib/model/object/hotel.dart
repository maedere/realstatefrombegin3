import 'package:equatable/equatable.dart';


class Hotel extends Equatable{

  final int id;
  final String name;
  final int level;
  List<String> images;
  final String description;
  final String lat;
  final  String lng;
  final  String address;
  final  String city;
  final bool parking;
  final bool cafe;
  final bool pool;
  final bool restaurant;


  Hotel({this.parking, this.cafe, this.pool, this.restaurant,this.id, this.name, this.level,
      this.images, this.lat, this.lng, this.address,this.description,this.city});

  factory Hotel.fromJson(Map<String, dynamic> json) => Hotel(
    id: json['id'],
    lat: json['lat'].toString(),
    lng :json['lng'].toString(),
    address: json['address'],
    name: json["name"],
    level: json["level"],
    city: json["city"],
    //image: json["image_url"],
    parking: json["parking"].toString().contains("1")?true:false,
    cafe: json["cafe"].toString().contains("1")?true:false,
    pool: json["pool"].toString().contains("1")?true:false,
    description:json["description"],
    images: List<String>.from(json["image"].map((x) => x["image"])),
    restaurant: json["restaurant"].toString().contains("1")?true:false,
  );

  @override
  List<Object> get props => [id];

}

class MiniHotel extends Equatable{
  MiniHotel({
    this.name,
    this.level,
    this.priceMember,
    this.priceAll,
    this.images,
    this.id
  });

  final  int id;
  final  String name;
  final  int level;
  final  int priceMember;
  final int priceAll;
  List<String> images;

  factory MiniHotel.fromJson(Map<String, dynamic> json) => MiniHotel(
    id: json['id'],
    name: json["name"],
    level: json["level"],
    priceMember: json["price_member"],
    priceAll: json["price_all"],
    //image: json["image"],
    images: List<String>.from(json["images"].map((x) => x["image"])),

  );

  @override
  String toString() {
    return 'MiniHotel{id: $id, name: $name, level: $level, priceMember: $priceMember, priceAll: $priceAll, images: $images}';
  }

  @override
  // TODO: implement props
  List<Object> get props => [id];
}

class HotelModel{
  HotelModel({
    this.name,
    this.level,
    this.priceMember,
    this.priceAll,
    this.images,
    this.id,
    this.lat,
    this.lng
  });

  int id;
  String name;
  int level;
  int priceMember;
  int priceAll;
  List<String> images;
  String lat;
  String lng;

  factory HotelModel.fromJson(Map<String, dynamic> json) => HotelModel(
    id: json['id'],
    name: json["name"],
    level: json["level"],
    priceMember: json["price_member"],
    priceAll: json["price_all"],
    //image: json["image"],
    images: json.containsKey("images")?List<String>.from(json["images"].map((x) => x["image"])):List<String>.from(json["image"].map((x) => x["image"])),
    lat: json['lat'].toString(),
    lng: json['lng'].toString(),
  );

}