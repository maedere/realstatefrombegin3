import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:realstatefrombegin3/model/object/filter.dart';
import 'package:realstatefrombegin3/model/object/home.dart';
import 'package:realstatefrombegin3/sercives/homeApi.dart';

import 'file:///E:/flutterProject/real-estate1/lib/widget/custom/Colors.dart';
import 'package:realstatefrombegin3/util/Constant.dart';
import 'package:realstatefrombegin3/util/size_config.dart';
import 'package:realstatefrombegin3/values/color_app.dart';
import 'package:realstatefrombegin3/values/icon_app_icons.dart';
import 'package:realstatefrombegin3/widget/custom/empty_widget.dart';
import 'package:realstatefrombegin3/widget/item/filter_item.dart';
import 'package:realstatefrombegin3/widget/item/home_item.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'dart:ui' as ui;

import 'filter.dart';
import 'map.dart';


class HomeMainPage extends StatefulWidget {
  static const String ADDRESS = "home/main";


  @override
  _HomeMainPageState createState() => _HomeMainPageState();
}

class _HomeMainPageState extends State<HomeMainPage> {
  int page=0;
  bool isFiltered=false;
  bool isLoading=true;
  bool nextPageLoading=false;
  bool noMoreLoding=false;
  List<MiniHome> homes=[];
  var value1;
  bool showCoache=false;
  bool isTopLoading=false;
  TutorialCoachMark tutorialCoachMark;
  List<TargetFocus> targets = List();


  @override
  void initState() {




    HomeApi.getHomes(0,context).then((value) {
      print(value);
      setState(() {
        isLoading=false;
        homes=value;

      });
      Constant.homes=homes;

      SharedPreferences.getInstance().then((prefs){
        if(!prefs.containsKey("showmainhomecoach"))
        {
          setState(() {
            showCoache=true;
          });
          prefs.setBool("showmainhomecoach", false);
        }

      });
    });

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
  print(isLoading);

    return Stack(
      children: [
        ImageFiltered(
          imageFilter: ImageFilter.blur(sigmaX: showCoache?1.5:0, sigmaY: showCoache?1.5:0),
          child: Scaffold(
            backgroundColor: Colors.white,
            body:isLoading?Center(child: CircularProgressIndicator()): Padding(
              padding: EdgeInsets.symmetric(horizontal: 7.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 12.v,
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>FilterHomePage(),maintainState: false)).then((value) {
                        if(value!=null)
                        {
                          value1=value;
                          setState(() {
                          isLoading=true;
                          page=0;
                        });
                        HomeApi.getHomeFilter(value[0],value[1],value[2],value[3],value[4],0,context).then((value) {
                          setState(() {
                            isFiltered=true;
                            isLoading=false;
                            homes=value;
                          });
                        });
                        }

                      });

                    },
                    trailing: Icon(
                      IconApp.filter,
                      size: 18,
                    ),
                    title: Text(
                      (value1==null || value1[1].toString().contains("all"))?'All City':value1[1].toString(),
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

                  SizedBox(
                    height: 1.v,
                  ),
                  Container(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                            height: 6.h,
                            width: 6.h,
                            child: isTopLoading?CircularProgressIndicator(strokeWidth: 1.3,):SizedBox()),
                      ),
                    ),
                  ),
                  Expanded(
                    child:
                    NotificationListener<ScrollEndNotification>(
                        onNotification: (scrollEnd) {
                          var metrics = scrollEnd.metrics;
                          if (metrics.atEdge) {
                            if (metrics.pixels == 0) {
                              setState(() {
                                page=0;
                                nextPageLoading=true;
                                isTopLoading=true;
                                noMoreLoding=false;
                              });
                              if(!isFiltered)
                                HomeApi.getHomes(page,context).then((value) {
                                  setState(() {
                                    if(value.length==0)
                                      noMoreLoding=true;
                                    nextPageLoading=false;
                                    isTopLoading=false;
                                    homes=value;

                                  });
                                });
                              else{
                                HomeApi.getHomeFilter(value1[0],value1[1],value1[2],value1[3],value1[4],page,context).then((value) {
                                  setState(() {
                                    if(value.length==0)
                                      noMoreLoding=true;
                                    isTopLoading=false;
                                    nextPageLoading=false;
                                    homes=value;

                                  });
                                });
                              }
                            }
                            else {
                              if(!noMoreLoding)
                              {
                                setState(() {
                                  page++;
                                  nextPageLoading=true;
                                });
                                if(!isFiltered)
                                  HomeApi.getHomes(page,context).then((value) {
                                    setState(() {
                                      if(value.length==0)
                                        noMoreLoding=true;
                                      nextPageLoading=false;
                                      homes=homes+value;

                                    });
                                  });
                                else{
                                  HomeApi.getHomeFilter(value1[0],value1[1],value1[2],value1[3],value1[4],page,context).then((value) {
                                    setState(() {
                                      if(value.length==0)
                                        noMoreLoding=true;
                                      nextPageLoading=false;
                                      homes=homes+value;

                                    });
                                  });
                                }
                              }

                            }
                          }
                          return true;
                        },
                      child:  ListView(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        children:
                          homes.map((e) {
                            return HomeItem(
                              miniHome: e,
                            );
                          }).toList(),
                      )
                    )
                          //todo ui monaseb
                  ),
                ],
              ),
            ),
            floatingActionButton: Constant.login && !isLoading
                ? SizedBox()
                : GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>MapPage(type:0)));
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
          ),
        ),
        showCoache?WillPopScope (
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: ColorApp.blackColor,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 200,left: 40,right: 40),
                  child: Text(
                    "The app allow you to buy or rent a property base on your specific requirements. It will give you different options from the location, to number of bedrooms, everything in just a click ",
                    style: TextStyle(color: Colors.white,fontSize: 20),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height/10,),
                Expanded(child: SizedBox()),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10,right: 10),
                  child: Align(
                    alignment: Constant.login?AlignmentDirectional.bottomCenter:AlignmentDirectional.bottomEnd,

                    child: Container(

                      child: GestureDetector(
                        onTap: (){
                          setState(() {
                            showCoache=false;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("SKIP",style: TextStyle(color: Colors.white),),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ):SizedBox()
      ],
    );
  }
}




