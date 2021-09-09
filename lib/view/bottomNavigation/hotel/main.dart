import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:realstatefrombegin3/model/object/hotel.dart';
import 'package:realstatefrombegin3/sercives/hotelApi.dart';
import 'package:realstatefrombegin3/util/Constant.dart';
import 'package:realstatefrombegin3/util/Tools.dart';
import 'package:realstatefrombegin3/util/size_config.dart';
import 'package:realstatefrombegin3/values/color_app.dart';
import 'package:realstatefrombegin3/values/icon_app_icons.dart';
import 'package:realstatefrombegin3/view/bottomNavigation/home/map.dart';
import 'package:realstatefrombegin3/view/bottomNavigation/hotel/suite.dart';
import 'package:realstatefrombegin3/widget/custom/Colors.dart';
import 'package:realstatefrombegin3/widget/custom/empty_widget.dart';
import 'package:realstatefrombegin3/widget/item/product_item.dart';
import 'dart:ui' as ui;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import 'detail.dart';
import 'filter.dart';

class HotelMainPage extends StatefulWidget {
  static const String ADDRESS = "hotel/main";

  @override
  _HotelMainPageState createState() => _HotelMainPageState();
}

class _HotelMainPageState extends State<HotelMainPage> {
  bool loading = false;
  int countHotel = 0;
  int page=0;
  bool isFiltered=false;
  bool isLoading=true;
  bool nextPageLoading=false;
  bool noMoreLoding=false;
  List<MiniHotel> hotels=[];
  TutorialCoachMark tutorialCoachMark;
  List<TargetFocus> targets = [];

  bool showCoache=false;
  GlobalKey  _key1 = GlobalKey();
  GlobalKey  _key2 = GlobalKey();


  var value1;


  @override
  void initState() {

    HotelApi.getHotels(0,context).then((value) {

      setState(() {
        isLoading=false;
        hotels=hotels+value;
      });
      Constant.hotels=hotels;
      SharedPreferences.getInstance().then((prefs){
        if(!prefs.containsKey("showhotelmaincoach"))
        {
          initTargets();
          WidgetsBinding.instance.addPostFrameCallback((_) async{

            showTutorial();

          });
          prefs.setBool("showhotelmaincoach", false);
        }

      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:isLoading?Center(child: CircularProgressIndicator()): Padding(
          padding: EdgeInsets.only(left: 7.h,right:7.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 12.v,
              ),
              ListTile(

                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>FilterHotelPage())).then((value) {
                    if(value!=null)
                    {
                      value1=value;
                      setState(() {
                      isLoading=true;
                    });
                    HotelApi.getHotelFilter(value[0],value[1],value[2],value[3],value[4],value[5],value[6],0,context).then((value) {
                      setState(() {
                        hotels=value;
                        isFiltered=true;
                        isLoading=false;
                      });
                    });
                    }
                  });
                },
                trailing: Icon(

                  IconApp.filter,
                  size: 14,
                  key:_key2,

                ),
                title: Text(
                  (value1==null || value1[0].toString().contains("all"))?'All City':value1[0].toString(),
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              Divider(
                height: 3,
                thickness: 2,
                color: Colors.grey[300],
              ),

              Row(
                children: [
                  SizedBox(
                    width: 80.h,
                    height: 5.v,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [],
                    ),
                  ),
                ],
              ),

              RichText(
                text: TextSpan(
                  text: hotels.length.toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                      fontSize: 24),
                  children: <TextSpan>[
                    TextSpan(
                      text: ' hotels',
                      style: TextStyle(fontWeight: FontWeight.w400),
                    )
                  ],
                ),
              ),

              Expanded(
                child: loading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : hotels.length == 0
                        ? EmptyShow()
                        :
                NotificationListener<ScrollEndNotification>(
                    onNotification: (scrollEnd) {
                      var metrics = scrollEnd.metrics;
                      if (metrics.atEdge) {
                        if (metrics.pixels == 0) print('At top');
                        else {
                          if(!noMoreLoding)
                          {
                            setState(() {
                              page++;
                              nextPageLoading=true;
                            });
                            if(!isFiltered)
                              HotelApi.getHotels(page,context).then((value) {
                                setState(() {
                                  if(value.length==0)
                                    noMoreLoding=true;
                                  nextPageLoading=false;
                                  hotels=hotels+value;

                                });
                              });
                            else{
                             /* HotelApi.getHotelFilter(value1[0],value1[1],value1[2],value1[3],page,context).then((value) {
                                setState(() {
                                  if(value.length==0)
                                    noMoreLoding=true;
                                  nextPageLoading=false;
                                  hotels=hotels+value;

                                });
                              });*/
                            }
                          }

                        }
                      }
                      return true;
                    },
                    child:  ListView(
                      key: _key1,
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      children: hotels.map((e) {
                        return value1==null?ProductItem(
                          hotel: e,
                        ):ProductItem(hotel: e,startDate: value1[2],endDate: value1[3], );
                      }).toList(),
                    )
                )


              ),
            ],
          ),
        ),

      floatingActionButton: Constant.login
          ? SizedBox()
          : GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => MapPage(type:1)));
            },
              child: Container(
                width: 12.h,
                height: 12.h,
                decoration: BoxDecoration(
                    color: ColorApp.primaryColor,
                    shape: BoxShape.circle,
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: ColorApp.primaryColor,
                          blurRadius: 10,
                          spreadRadius: 4)
                    ]),
                padding: EdgeInsets.all(1.5.h),
                child: Icon(
                  IconApp.compass,
                  color: Colors.white,
                ),
              ),
            ),
    );
  }



  void initTargets() {

    targets.add(
      TargetFocus(

        identify: "Target 1",
        keyTarget: _key1,
        color: ColorApp.blackColor,
        contents: [
          TargetContent(
            customPosition: CustomTargetContentPosition(top: 20),
            align: ContentAlign.custom,
            child: Container(
              child: Center(
                child: Text(
                  "The app allows you to book a hotel, there are hindered and thousand of option based on your set filters from different price range, to ratings and other details.",
                  style: TextStyle(color: Colors.white,fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          )
        ],
        shape: ShapeLightFocus.RRect,
        radius: 20,
      ),
    );
    targets.add(
      TargetFocus(
        identify: "Target 2",
        keyTarget: _key2,
        color: ColorApp.blackColor,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            child: Container(
              child: Padding(
                padding: const EdgeInsets.only(top: 70.0),
                child: Text(
                  "Open the Hotel Filter and fill up the options a per your requirements",
                  style: TextStyle(color: Colors.white,fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          )
        ],
        shape: ShapeLightFocus.RRect,
        radius: 20,
      ),
    );



  }

  void showTutorial() async{
    await Future.delayed(Duration(seconds: 1));
    setState(() {});

    tutorialCoachMark = TutorialCoachMark(
      context,
      targets: targets,
      colorShadow: ColorApp.blackColor,
      textSkip: "SKIP",

      paddingFocus: 10,
      opacityShadow: 0.8,
      onSkip: (){

      },
      onClickOverlay: (target) {
        print('onClickOverlay: $target');
      },
      onClickTarget: (target) {

        print('onClickTarget: $target');

      },
    )..show();
  }
}
