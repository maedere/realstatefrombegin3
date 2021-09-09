import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:realstatefrombegin3/model/object/agent.dart';
import 'package:realstatefrombegin3/model/object/comment.dart';
import 'package:realstatefrombegin3/model/object/filter.dart';
import 'package:realstatefrombegin3/model/object/home.dart';
import 'package:realstatefrombegin3/util/Constant.dart';
import 'package:realstatefrombegin3/util/Tools.dart';
import 'package:realstatefrombegin3/util/app_exceptions.dart';
import 'package:realstatefrombegin3/view/bottomNavigation/home/filter.dart';

import 'base_service.dart';

class HomeApi {

  static Future<List<MiniHome>> getHomes(page,key) async {

    List<MiniHome> homes = List();
    final res = await patternAll(Constant.BASE_ADDRESS+"propertyList",key,false,data: {"range":page});
    for (final service in res['data']) {
      homes.add(MiniHome.fromJson(service));
    }
    return homes;
  }

  static Future<List<MiniHome>> getHomeFilter(List<FilterModel> models,city,type,maxPrice,minPrice,page,key) async {


    List<MiniHome> homes = List();

    List<int> bedrooms = models.where((element) => element.type == 'bedroom').map((e) => int.parse(e.name)).toList();
    List<int> bathrooms = models.where((element) => element.type == 'bathroom').map((e) => int.parse(e.name)).toList();

    Map<String , dynamic> data = {};


      data['type'] = type.toString();
      data['range'] = page.toString();
      data['price_max'] = maxPrice.toString();
      data['price_min'] = minPrice.toString();
      data['city'] = city.toString().toLowerCase();

    if (bathrooms.length > 0) {
      data['bathroom'] = jsonEncode(bathrooms);
    }

    if (bedrooms.length > 0) {
      data['bedroom'] = jsonEncode(bedrooms);
    }

    print('data to sent :' + data.toString() );
    final res = await patternAll(Constant.BASE_ADDRESS + 'filter_home',key,false,data: data);

    for (final service in res['data'])
      homes.add(MiniHome.fromJson(service));
    return homes;
  }

  static Future<List> singleHome(String id,key) async{
    HomeModel home;
    Agent agent;
    List<Comment> comments=[];

    Map<String , dynamic> data = {
      'id' : id
    };
    final res = await patternAll(Constant.BASE_ADDRESS+"propertyInfo",key,false,data: data);

      home = HomeModel.fromJson(res["data"]["property"]);
      agent = Agent.fromJson(res["data"]["agent"]);
      for (final comment in res["data"]["review"])
        comments.add(Comment.fromJson(comment));



    return [home,agent,comments];
  }

  static Future<void> addComment(String message,homeId,key) async{


    Map<String , dynamic> data = {
    'massage' : message,
    'property_id' : homeId,
    'username' : Constant.userName
    };

    await patternAll(Constant.BASE_ADDRESS+"property_add_review",key,false,data: data);

    return ;
  }

}