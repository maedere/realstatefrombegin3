

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:realstatefrombegin3/model/object/car.dart';
import 'package:realstatefrombegin3/model/object/home.dart';
import 'package:realstatefrombegin3/model/object/hotel.dart';
import 'package:realstatefrombegin3/util/Constant.dart';
import 'package:realstatefrombegin3/widget/item/home_added.dart';


class FavoritePage extends StatelessWidget{

  static const String BASE_ADDRESS = 'profile/favorite';

  @override
  Widget build(BuildContext context) {
    if(Constant.pop)
    {
      Navigator.pop(context);
      Constant.pop=false;
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text('Favourite',style: TextStyle(color: Colors.black),),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Constant.favorites.length == 0 ? Center(child: Text('is Empty'),):
      SingleChildScrollView(
        child: Column(
          children: Constant.favorites.map((e) {
            String type;
            MiniHome m;
            MiniHotel h;
            MiniCar c;
            if (e is MiniHome) {
              type = 'home';
              m = e;
            }  else if (e is MiniHotel){
              type = 'hotel';
              h = e;
            } else if (e is MiniCar){
              type = 'car';
              c = e;
            }
            return HomeListItemWidget(type: type , home: m,hotel: h,car: c,);
          }).toList(),
        ),
      ),
    );
  }

}