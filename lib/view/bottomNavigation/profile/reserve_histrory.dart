


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:realstatefrombegin3/model/object/hotel.dart';
import 'package:realstatefrombegin3/model/object/reserve.dart';
import 'package:realstatefrombegin3/sercives/hotelApi.dart';
import 'package:realstatefrombegin3/util/Constant.dart';
import 'package:realstatefrombegin3/widget/item/history_item.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  bool isLoading=true;
  List<Reserve> reservs=[Reserve(),];
  @override
  void initState() {
    HotelApi.getReserveHistory(context,Constant.userName).then((value) {
      setState(() {
        isLoading=false;
        reservs=value;
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text('Booking history',style: TextStyle(color: Colors.black),),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: isLoading?Center(child: CircularProgressIndicator(),):
      reservs.length!=0?ListView(
        scrollDirection: Axis.vertical,
        children: reservs.map((e) {
          return HistoryItem(
            reserve: e,
          );
        }).toList(),
      ):Center(child:Text("You have not made any reservations so far")),
    );
  }
}
