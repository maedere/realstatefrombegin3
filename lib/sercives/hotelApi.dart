import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart';
import 'package:realstatefrombegin3/model/object/filter.dart';
import 'package:realstatefrombegin3/model/object/hotel.dart';
import 'package:realstatefrombegin3/model/object/comment.dart';
import 'package:realstatefrombegin3/model/object/reserve.dart';
import 'package:realstatefrombegin3/model/object/suite.dart';

import 'package:realstatefrombegin3/util/Constant.dart';

import 'base_service.dart';

class HotelApi {

  static Future<List<MiniHotel>> getHotels(page,key) async {


    List<MiniHotel> hotels = List();
    final res = await patternAll(Constant.BASE_ADDRESS_HOTEL + "show_all",key,true,data:{"range":page.toString()});
    for (final service in res['data']) {
      hotels.add(MiniHotel.fromJson(service));
    }
    return hotels;
  }

  static Future<List<MiniHotel>> getHotelFilter(city, bedCount,startTime,endTime,level,facilities,roomFacilities,page,key) async {

    List<MiniHotel> hotels = List();

    Map<String , dynamic> data = {};

    data['start_time'] = startTime.toString();
    data['end_time'] = endTime.toString();
    data['city'] = city.toString();
    data['bed_count'] = bedCount;
    data['level'] = level;
    data['facilities'] = facilities;
    data['roomFacilities'] = roomFacilities;
    //data['range'] = page.toString();
    print('data to sent :' + data.toString() );

    final res = await patternAll(Constant.BASE_ADDRESS_HOTEL + 'search_hotel',key,false,data: data);

    for (final service in res['data'])
      hotels.add(MiniHotel.fromJson(service));
    return hotels;
  }

  static Future<List> singleHotel(String id,key) async{
    Hotel hotel;
    List<Comment> comments=[];

    Map<String , dynamic> data = {
      'id' : id
    };
    final res = await patternAll(Constant.BASE_ADDRESS_HOTEL + id.toString(),key,true,data: data);
    hotel= Hotel.fromJson(res["data"]);
    for (final comment in res["data"]["comments"])
      comments.add(Comment.fromJson(comment));


    return [hotel,comments];
  }

  static Future<void> addComment(String message,homeId,key) async{


    Map<String , dynamic> data = {
      'text' : message,
      'hotel_id' : homeId,
      'user_email' : Constant.userName
    };

    await patternAll(Constant.HOST+"hotel_comments",key,false,data: data);

    return ;
  }

//----------------suite part--------------

  static Future<List<Suite>> getSuites(key,hotelId,startTime,endTime) async {


    Map<String , dynamic> data = {
      'hotel_id' : hotelId,
      'start_time' : startTime,
      'end_time' : endTime
    };
    List<Suite> suites = List();
    final res = await patternAll(Constant.BASE_ADDRESS_SUITE + "show_all",key,false,data: data);
    for (final service in res['data']) {
      suites.add(Suite.fromJson(service));
    }
    return suites;
  }

  static Future<String> reserveSuite(key,suiteId,startDate,endDate,userEmail) async {


    try {
      final res = await patternAll(
          Constant.HOST + "reservation", key, false, data: {
        "suite_id": suiteId,
        "start_time": startDate,
        "end_time": endDate,
        "user_email": userEmail
      });

      return res['result'];

    }catch(e){

    }
  }

  static Future< List<Reserve>> getReserveHistory(key,userEmail) async {

    List<Reserve> reservs = List();

    final res = await patternAll(
          Constant.HOST + "reservation/show_all", key, false, data: {
        "user_email": userEmail
      });

    for (final reserve in res['data']) {
     
      reservs.add(Reserve(trakingCode: reserve["id"],startDate: reserve["start_time"],endDate: reserve["end_time"],priceAll: reserve["price"].toString(),suiteId: reserve["suite"]["id"],tv: reserve["suite"]["tv"].toString().contains("1")?true:false,
      kitchen:  reserve["suite"]["kitchen"].toString().contains("1")?true:false, bathroom: reserve["suite"]["bathroom"].toString().contains("1")?true:false, breakFast:reserve["suite"]["breakfast_included"].toString().contains("1")?true:false, terrace:reserve["suite"]["terrace"].toString().contains("1")?true:false,
          airConditioning: reserve["suite"]["air_condition"].toString().contains("1")?true:false ,wifi: reserve["suite"]["wifi"].toString().contains("1")?true:false , animal: reserve["suite"]["animal"].toString().contains("1")?true:false ,
          room: reserve["suite"]["room"] , bed: reserve["suite"]["bed"] ,hotelName:reserve["suite"]["hotel"]["name"] ,hotelLevel: reserve["suite"]["hotel"]["level"],image: reserve["suite"]["hotel"]["image"].toString().contains("image")?reserve["suite"]["hotel"]["image"][0]["image"]:""));
    }
      return reservs;


  }

}