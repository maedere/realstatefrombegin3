
import 'package:equatable/equatable.dart';

class MiniHome extends Equatable {
  final String price, address, bathroom, bedroom, size, image , id;

  MiniHome(
      {this.price,
      this.address,
      this.bathroom,
      this.bedroom,
      this.size,
        this.id,
      this.image});

  factory MiniHome.fromJson(Map<String, dynamic> json) => MiniHome(
    price: json["price"],
    address: json["address"],
    bathroom: json["bathroom"],
    bedroom: json["bedroom"],
    size: json["size"],
    image: json["image"],
    id: json["id"].toString(),
  );

  @override
  List<Object> get props => [id];
}

class HomeModel {
  String price, address, bathroom, bedroom, size;
  String id;
  String category;
  String description;
  String lat;
  String lng;
  String name;
  String yearOfBuilt;
  String garageCapacity;
  String city;
  List<dynamic> images;

  HomeModel({this.price, this.address, this.bathroom, this.bedroom, this.size,this.city,
  this.id, this.category, this.description, this.lat, this.lng, this.name , this.images,this.yearOfBuilt,this.garageCapacity});

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
    name : json['name'],
    price: json["price"],
    address: json["address"],
    bathroom: json["bathroom"],
    bedroom: json["bedroom"],
    size: json["size"],
    id: json["id"].toString(),
    category: json["category"],
    city: json["city"],
    description: json["description"],
    lat: json["lat"].toString(),
    lng: json["lng"].toString(),
    images: json['images'],
    yearOfBuilt: json['year_built'].toString(),
    garageCapacity: json['garage_capacity'].toString(),
  );
}
