import 'dart:convert';

import 'package:realstatefrombegin3/model/object/car.dart';
import 'package:realstatefrombegin3/model/object/comment.dart';
import 'package:realstatefrombegin3/model/object/filter.dart';
import 'package:realstatefrombegin3/util/Constant.dart';
import 'package:realstatefrombegin3/util/Tools.dart';
import 'package:realstatefrombegin3/util/app_exceptions.dart';
import 'package:http/http.dart' as http;

import 'base_service.dart';


class CarApi {

  static Future<List<MiniCar>> getCars(int page,key) async{

    print(page);
    List<MiniCar> cars = List();
    final res = await patternAll(Constant.BASE_ADDRESS_PANEL+"getCarList",key,false,data: {"range":page});
    for (final service in res['data']) {
      cars.add(MiniCar.fromJson(service));
    }
    return cars;
  }


  static Future<List<MiniCar>> getCarsFilter(List<FilterModel> models,city,maxPrice,minPrice,seats,doors,transmission,insurance,key) async {

    List<MiniCar> cars = List();

    for( final i in models){
      print(i.name);
    }

    List<String> company = models.where((element) => element.type == 'company').map((e) => e.name).toList();
    List<int> year = models.where((element) => element.type == 'year').map((e) => int.parse(e.name)).toList();
    List<String> color = models.where((element) => element.type == 'color').map((e) => e.name).toList();
    List<int> feature = models.where((element) => element.type == 'feature').map((e) => int.parse(e.name)).toList();

    Map<String , dynamic> data = {};

    data["city"]=city.toString();
    data["maxCost"]=maxPrice;
    data["minCost"]=minPrice;
    data["isAvailable"]=true;
    data["transmission"]=transmission;
    data["insurance"]=insurance;

     if (company.length > 0) {
       data['company'] = company;
     }

    if (year.length > 0) {
      data['year'] = jsonEncode(year);
    }

    if (color.length > 0) {
      data['color'] = color;
    }

    if (seats.length > 0) {
      data['seat'] = seats;
    }

    if (doors.length > 0) {
      data['door'] = doors;
    }

    if (feature.length > 0) {
      data['feature'] = jsonEncode(feature);
    }

    print('data to sent :' + data.toString() );
    final res = await patternAll(Constant.BASE_ADDRESS_PANEL + 'carFilter',key,false,data: data);

    if( !res['data'].toString().contains("no car found with this filter"))
      for (final service in res['data'])
        cars.add(MiniCar.fromJson(service));
    return cars;
  }


  static Future<List> singleCar(String id,key) async{
    Car car;
    List<Comment> comments=[];


    Map<String , dynamic> data = {
      'id' : id
    };
    final res = await patternAll(Constant.BASE_ADDRESS_PANEL + 'getCarInfo',key,false,data: data);

    car = Car.fromJson(res["data"]);
    for (final comment in res["data"]["comment"])
      comments.add(Comment.fromJson(comment));

    return [car,comments];
  }

  static Future<void> addComment(String message,carId,key) async{


    Map<String , dynamic> data = {
      'massage' : message,
      'car_id' : carId,
      'username' : Constant.userName
    };

    await patternAll(Constant.BASE_ADDRESS+"car_add_review",key,false,data: data);

    return ;
  }

}
