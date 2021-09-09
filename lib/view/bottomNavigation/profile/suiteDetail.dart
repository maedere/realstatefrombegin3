import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:realstatefrombegin3/model/object/comment.dart';
import 'package:realstatefrombegin3/model/object/hotel.dart';
import 'package:realstatefrombegin3/model/object/person.dart';
import 'package:realstatefrombegin3/model/object/reserve.dart';
import 'package:realstatefrombegin3/model/object/suite.dart';
import 'package:realstatefrombegin3/sercives/hotelApi.dart';
import 'package:realstatefrombegin3/util/Constant.dart';
import 'package:realstatefrombegin3/util/Tools.dart';
import 'package:realstatefrombegin3/util/size_config.dart';
import 'package:realstatefrombegin3/values/color_app.dart';
import 'package:realstatefrombegin3/values/icon_app_icons.dart';
import 'package:realstatefrombegin3/view/bottomNavigation/hotel/suite.dart';
import 'package:realstatefrombegin3/view/bottomNavigation/profile/fav_page.dart';
import 'package:realstatefrombegin3/widget/custom/Colors.dart';
import 'package:realstatefrombegin3/widget/item/comment.dart';
import 'package:realstatefrombegin3/widget/item/extra_hotel_item.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import 'package:http/http.dart' as http;
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'dart:ui' as ui;

class DetailSuitePage extends StatefulWidget {
  static const String ADDRESS = "profile/suiteDetail";
  final Reserve reserve;

  DetailSuitePage({ this.reserve});

  @override
  _DetailSuitePageState createState() => _DetailSuitePageState();
}

class _DetailSuitePageState extends State<DetailSuitePage> {
  Hotel hotel;
  String mapStyle = "";
  GoogleMapController _controller;

  MiniHotel miniHotel;

  bool _showButton = true;
  FocusNode _focusNode;
  TextEditingController _textEditingController;

  String startDate="",endDate="";
  List<Comment> comments = [];

  TutorialCoachMark tutorialCoachMark;
  List<TargetFocus> targets = [];

  GlobalKey  _key1 = GlobalKey();
  ScrollController _scrollController;

  DateRangePickerController _dateRangePickerController= DateRangePickerController();
  bool showCoache=false;

  Set<Marker> mark = Set();


  bool fav = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: ColorApp.accentColor,
      body: Stack(
        children: [

          Container(
            height: 70.h,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: widget.reserve.image==""
                  ? Image(

                image: AssetImage(
                  Constant.IMAGE_ADDRESS + "h5.jpg",
                ),
                fit: BoxFit.fill,
                width: double.infinity,
                height: double.infinity,
              )
                  : Image(
                image: NetworkImage(
                    Constant.BASE_IMAGE_ADDRESS + widget.reserve.image),
                fit: BoxFit.fill,
                width: double.infinity,
                height: double.infinity,
              ),),
          ),
          Padding(
            padding:  EdgeInsets.only(top: 11.h,left:2.8.v),
            child: InkWell(
                child: Icon(Icons.arrow_back,color: Colors.white,),
              onTap: (){
                  Navigator.pop(context);
              },
            ),
          ),

          Padding(
            padding:  EdgeInsets.only(top: 50.h),
            child: Container(
              decoration: new BoxDecoration(
                  color: Colors.grey[100], //new Color.fromRGBO(255, 0, 0, 0.0),
                  borderRadius: new BorderRadius.only(
                      topLeft:  const  Radius.circular(40.0),
                      topRight: const  Radius.circular(40.0))
              ),
              child: Padding(
                padding:  EdgeInsets.only(top: 15.h,left: 2.v),
                child: Column(
                  children: [
                    Text(widget.reserve.hotelName,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 3.h+2.v)),
                    SizedBox(height: 8.h,),

                    Row(
                      children: [
                        Icon(Icons.date_range,),
                        SizedBox(width: 2.v,),
                        Text(widget.reserve.startDate+" "),
                        Icon(Icons.arrow_forward,size: 5.h,),
                        Text(" "+widget.reserve.endDate),
                      ],
                    ),
                    SizedBox(height: 3.h,),

                    Row(
                      children: [
                        Icon(Icons.hotel),
                        SizedBox(width: 2.v,),
                        Text("Bed room:"),
                        SizedBox(width: 2.v,),

                        Text(widget.reserve.bed.toString()),
                      ],
                    ),
                    SizedBox(height: 3.h,),

                    Row(
                      children: [
                        Icon(Icons.home),
                        SizedBox(width: 2.v,),
                        Text("Room:"),
                        SizedBox(width: 2.v,),

                        Text(widget.reserve.room.toString()),
                      ],
                    ),
                    SizedBox(height: 3.h,),
                    Align(child: Text("Features:"),alignment: Alignment.centerLeft,),
                    SizedBox(height: 3.h,),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                         if(widget.reserve.kitchen)
                            ExtraHotelItem(
                              icon: Icons.kitchen,
                              name: "kitchen",
                            ),
                          if(widget.reserve.bathroom)
                            ExtraHotelItem(
                              icon: Icons.bathtub,
                              name: "bathroom",
                            ),
                            if(widget.reserve.breakFast)
                            ExtraHotelItem(
                              icon: Icons.free_breakfast,
                              name: "breakfast",
                            ),
                            if(widget.reserve.terrace)
                            ExtraHotelItem(
                              icon: Icons.water_damage_rounded,
                              name: "terrace",
                            ),
                            if(widget.reserve.airConditioning)
                            ExtraHotelItem(
                              icon: Icons.invert_colors_sharp,
                              name: "ventilation",
                            ),
                            if(widget.reserve.wifi)
                            ExtraHotelItem(
                              icon: Icons.wifi,
                              name: "wifi",
                            ),
                            if(widget.reserve.tv)
                            ExtraHotelItem(
                              icon: Icons.tv,
                              name: "tv",
                            ),
                            if(widget.reserve.animal)
                            ExtraHotelItem(
                              icon: Icons.pets,
                              name: "animal",
                            ),


                        ],
                      ),
                    ),
                    SizedBox(height: 5.h,),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        child:  Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Text("Tracking Code: " + widget.reserve.trakingCode.toString()),
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: ColorApp.accentColor,

                            ),
                            borderRadius: BorderRadius.all(Radius.circular(5))
                        ),),
                    ),


                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding:  EdgeInsets.only(top: 40.h),
            child: Row(
              children: [
                Expanded(child: SizedBox(),),
                Container(
                  height: 20.h,
                  width: 30.v,
                  decoration: new BoxDecoration(
                      color: ColorApp.primaryColor,
                      borderRadius: new BorderRadius.all(Radius.circular(4.0),),),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: SizedBox()),
                        Text("TOTAL",style: TextStyle(fontSize: 3.h+1.v),),
                        Expanded(child: SizedBox()),
                        Text(widget.reserve.priceAll+"\$",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 3.h+1.v),),
                        Expanded(child: SizedBox()),
                      ],
                    ),
                  ),
                ),
                Expanded(child: SizedBox(),),

              ],
            ),
          ),
        ],
      ),

    );
  }


}
