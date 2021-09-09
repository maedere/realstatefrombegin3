
import 'package:flutter/material.dart';
import 'package:realstatefrombegin3/model/object/car.dart';

import 'package:realstatefrombegin3/model/object/filter.dart';
import 'package:realstatefrombegin3/sercives/carApi.dart';
import 'package:realstatefrombegin3/view/bottomNavigation/home/map.dart';
import 'detail.dart';
import 'file:///E:/flutterProject/real-estate1/lib/widget/custom/Colors.dart';
import 'package:realstatefrombegin3/util/Constant.dart';
import 'package:realstatefrombegin3/values/color_app.dart';
import 'package:realstatefrombegin3/values/icon_app_icons.dart';
import 'package:realstatefrombegin3/util/size_config.dart';

import 'package:realstatefrombegin3/widget/custom/empty_widget.dart';
import 'package:realstatefrombegin3/widget/item/car_main_item.dart';
import 'package:realstatefrombegin3/widget/item/filter_item.dart';
import 'dart:ui' as ui;

import 'package:shared_preferences/shared_preferences.dart';

import 'filter.dart';

class CarMainPage extends StatefulWidget {
  static const String ADDRESS = 'car/main';

  @override
  _CarMainPageState createState() => _CarMainPageState();
}

class _CarMainPageState extends State<CarMainPage> {
   List<MiniCar> cars=[];
   bool isFiltered=false;
   bool isLoading=true;
   bool nextPageLoading=false;
   int page=0;
   bool noMoreLoding=false;
   ScrollController _scrollController = new ScrollController();

   bool showCoache=false;
   var value1;
  @override
  void initState() {


    CarApi.getCars(0,context).then((value) {
      print(value);
      setState(() {
        isLoading=false;
        cars=value;

      });
      SharedPreferences.getInstance().then((prefs){
        if(!prefs.containsKey("showmaincarcoache"))
        {
          setState(() {
            showCoache=true;
          });
          prefs.setBool("showmaincarcoache", false);
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.white,
          body: isLoading?Center(child: CircularProgressIndicator()):Padding(
            padding: EdgeInsets.symmetric(horizontal: 7.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 12.v,
                ),
                ListTile(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>FilterCarPage())).then((value) =>{

                        if(value!=null)
                        {

                          setState(() {
                            value1=value;
                            isFiltered=true;
                            isLoading=true;

                        }),
                          CarApi.getCarsFilter(value[0],value[1],value[2],value[3],value[4],value[5],value[6],value[7],context).then((carValues) => {

                              setState(() {
                                cars=carValues;
                                isLoading=false;
                              })
                        })
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
                  height: 3.v,
                ),

                SizedBox(
                  height: 4.v,
                ),
                Expanded(
                  child: (cars.length == 0)?EmptyShow():
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
                                CarApi.getCars(page,context).then((value) {
                                  setState(() {
                                    print(value.length);
                                    if(value.length==0)
                                      noMoreLoding=true;
                                    nextPageLoading=false;
                                    cars=cars+value;

                                  });
                                });
                            }
                          }
                        }
                        return true;
                      },
                      child:  ListView(
                          controller: _scrollController,
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                        children:[
                          ListView.builder(
                            physics: ScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: cars.length,
                            itemBuilder: (BuildContext context, int index) {
                              return  CarItem(
                                miniCar: cars[index],
                              );
                            },
                          ),
                          /*nextPageLoading?Container(
                            height: 40,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          ):SizedBox(),*/
                        ]

                      )
                  )

                ),
              ],
            ),
          ),
          /*   floatingActionButton: GestureDetector(
            onTap: () => BlocProvider.of<RouteBloc>(context)
                .add(RouteChangePageEvent(address: MapPage.ADDRESS)),
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
          ),*/

          floatingActionButton: Constant.login && !isLoading
              ? SizedBox()
              : GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => MapPage(type:3)));

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
        showCoache?BackdropFilter(
          filter: new ui.ImageFilter.blur(
            sigmaX: 2,
            sigmaY: 2,
          ),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: ColorApp.blackColor,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 250,left: 40,right: 40),
                  child: Column(
                    children: [
                      Text(
                        "Choose from the wide range of cars available for rent. You can choose according to the type, price range and the location.",
                        style: TextStyle(color: Colors.white,fontSize: 20),
                      ),


                    ],
                  ),
                ),
                Expanded(child: SizedBox()),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10,right: 10),
                  child: Align(
                    alignment: Constant.login?AlignmentDirectional.bottomCenter:AlignmentDirectional.bottomEnd,

                    child: Container(

                      child: GestureDetector(
                        onTap: (){

                          setState((){
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

