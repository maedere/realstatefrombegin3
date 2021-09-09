


import 'package:equatable/equatable.dart';

class Reserve extends Equatable{

  final int trakingCode;
  final int suiteId;
  final String hotelName;
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
  final int hotelLevel;
  final String startDate, endDate;
  final String image;



  Reserve({this.image,this.trakingCode,this.startDate, this.endDate, this.suiteId, this.hotelLevel, this.hotelName, this.bed, this.room, this.kitchen, this.bathroom, this.breakFast, this.terrace, this.airConditioning, this.wifi, this.tv, this.animal, this.priceAll,});

  /*factory Reserve.fromJson(Map<String, dynamic> json) => Reserve(
    suiteId: json['suite_id'],
      hotelName: json['hotel_id'],
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
    //hotelLevel: json["hotelLevel"],
    startDate: json["start_time"].toString(),
    endDate: json["end_time"].toString(),
    trakingCode: json["id"],
    image: json["image"]

  );*/

  @override
  List<Object> get props => [trakingCode];

}
