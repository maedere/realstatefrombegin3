// To parse this JSON data, do
//
//     final MiniCar = MiniCarFromJson(jsonString);

import 'dart:convert';

MiniCar MiniCarFromJson(String str) => MiniCar.fromJson(json.decode(str));

String MiniCarToJson(MiniCar data) => json.encode(data.toJson());

class MiniCar {
  MiniCar({
    this.id,
    this.company,
    this.model,
    this.year,
    this.cost,
    this.totalTrips,
    this.lat,
    this.lng,
    this.images,
  });

  int id;
  String company;
  String model;
  int year;
  int cost;
  dynamic totalTrips;
  double lat;
  double lng;
  List<String> images;

  factory MiniCar.fromJson(Map<String, dynamic> json) => MiniCar(
    id: json["id"],
    company: json["company"],
    model: json["model"],
    year: json["year"],
    cost: json["cost"],
    totalTrips: json["total_trips"],
    lat: json["lat"].toDouble(),
    lng: json["lng"].toDouble(),
    images:json.containsKey("images")? List<String>.from(json["images"].map((x) => x["image"])):[],
    //image:json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "company": company,
    "model": model,
    "year": year,
    "cost": cost,
    "total_trips": totalTrips,
    "lat": lat,
    "lng": lng,
    "images": List<dynamic>.from(images.map((x) => x)),
    //"image": image,
  };
  @override
  String toString() {
    return 'Car{id: $id,year: $year, company: $company, model: $model,totalTrips: $totalTrips, cost: $cost, lat: $lat, lng: $lng, image: $images}';
  }
}



Car carFromJson(String str) => Car.fromJson(json.decode(str));

String carToJson(Car data) => json.encode(data.toJson());

class Car {
  Car({
    this.id,
    this.isAvailable,
    this.door,
    this.seat,
    this.power,
    this.transmission,
    this.odometer,
    this.year,
    this.company,
    this.model,
    this.trim,
    this.color,
    this.ageLimit,
    this.rate,
    this.totalTrips,
    this.userId,
    this.insurance,
    this.cost,
    this.description,
    this.startDate,
    this.endDate,
    this.address,
    this.lat,
    this.lng,
    this.limitDistance,
    this.extraDistanceCharge,
    this.createdAt,
    this.updatedAt,
    this.images,
    this.phone,
    this.city
  });

  int id;
  int isAvailable;
  int door;
  int seat;
  int power;
  int transmission;
  int odometer;
  int year;
  String company;
  String model;
  dynamic trim;
  String color;
  int ageLimit;
  double rate;
  int totalTrips;
  String userId;
  int insurance;
  int cost;
  String description;
  String phone;
  String city;
  DateTime startDate;
  DateTime endDate;
  String address;
  double lat;
  double lng;
  int limitDistance;
  dynamic extraDistanceCharge;
  DateTime createdAt;
  DateTime updatedAt;
  List<String> images;

  factory Car.fromJson(Map<String, dynamic> json) => Car(
    id: json["id"],
    isAvailable: json["isAvailable"],
    door: json["door"],
    seat: json["seat"],
    power: json["power"],
    transmission: json["transmission"],
    odometer: json["odometer"],
    year: json["year"],
    company: json["company"],
    model: json["model"],
    trim: json["trim"],
    color: json["color"],
    ageLimit: json["age_limit"],
    rate: json["rate"] == null ? 0 : json["rate"].toDouble(),
    totalTrips: json["total_trips"],
    userId: json["user_id"],
    insurance: json["insurance"],
    city: json["city"],
    cost: json["cost"],
    phone: json["phone"],
    description: json["description"],
  /*  startDate: DateTime.parse(json["start_date"]),
    endDate: DateTime.parse(json["end_date"]),*/
    address: json["address"],
    lat: json["lat"].toDouble(),
    lng: json["lng"].toDouble(),
    limitDistance: json["limit_distance"],
    extraDistanceCharge: json["extra_distance_charge"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    images: List<String>.from(json["images"].map((x) => x["image"])),
    //image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "isAvailable": isAvailable,
    "door": door,
    "seat": seat,
    "power": power,
    "transmission": transmission,
    "odometer": odometer,
    "year": year,
    "company": company,
    "model": model,
    "trim": trim,
    "color": color,
    "age_limit": ageLimit,
    "rate": rate,
    "total_trips": totalTrips,
    "user_id": userId,
    "insurance": insurance,
    "cost": cost,
    "description": description,
    "start_date": "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
    "end_date": "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
    "address": address,
    "phone": phone,
    "lat": lat,
    "lng": lng,
    "limit_distance": limitDistance,
    "extra_distance_charge": extraDistanceCharge,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "images": List<dynamic>.from(images.map((x) => x)),
    //"image": image,
  };

  @override
  String toString() {
    return 'Car{id: $id, isAvailable: $isAvailable, door: $door, seat: $seat, power: $power, transmission: $transmission, odometer: $odometer, year: $year, company: $company, model: $model, trim: $trim, color: $color, ageLimit: $ageLimit, rate: $rate, totalTrips: $totalTrips, userId: $userId, insurance: $insurance, cost: $cost, description: $description, startDate: $startDate, endDate: $endDate, address: $address, lat: $lat, lng: $lng, limitDistance: $limitDistance, extraDistanceCharge: $extraDistanceCharge, createdAt: $createdAt, updatedAt: $updatedAt, images: $images , phone:$phone}';
  }
}

