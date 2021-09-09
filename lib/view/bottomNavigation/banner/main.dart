
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realstatefrombegin3/model/NavigationProvider.dart';
import 'package:realstatefrombegin3/util/Constant.dart';
import 'package:realstatefrombegin3/util/size_config.dart';
import 'package:realstatefrombegin3/values/color_app.dart';
import 'package:realstatefrombegin3/view/bottomNavigation/home/main.dart';
import 'package:realstatefrombegin3/view/bottomNavigation/hotel/main.dart';
import 'package:realstatefrombegin3/widget/custom/Colors.dart';
import 'package:realstatefrombegin3/widget/item/banner_data_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../base_navigation.dart';
import 'dart:ui' as ui;
class BannerMainPage extends StatefulWidget {
  static const String ADDRESS = "banner/main";

  @override
  _BannerMainPageState createState() => _BannerMainPageState();
}

class _BannerMainPageState extends State<BannerMainPage> {
  bool showCoache=false;
  @override
  void initState() {
    SharedPreferences.getInstance().then((prefs){
      if(!prefs.containsKey("showbannermaincoach"))
      {
        setState(() {
          showCoache=true;
        });
        prefs.setBool("showbannermaincoach", false);
      }

    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final myModel = Provider.of<NavigationProviderModel>(context, listen: false);

    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CarouselSlider(
                      items: [
                        Image(image: AssetImage(Constant.IMAGE_ADDRESS + "ban1.jpg") , fit: BoxFit.fill,),
                        Image(image: AssetImage(Constant.IMAGE_ADDRESS + "ban2.jpg"),fit: BoxFit.fill,),
                      ],
                      options: CarouselOptions(
                          viewportFraction: 1.0,
                          enlargeCenterPage: false,
                          height: 32.v
                      )
                  ),
                  SizedBox(height: 5.v,),
                  Row(
                    children: [
                      SizedBox(width: 5.h),
                      Text("Property",  style: TextStyle(fontSize: 20),),
                      Expanded(child: SizedBox()),
                      GestureDetector(onTap : (){
                        Constant.pop=true;

                        myModel.changeIndex(0);

                      },child: Text("More > ",  style: TextStyle(fontSize: 16 , color: ColorApp.primaryColor),)),
                      SizedBox(width: 5.h),
                    ],
                  ),
                  SizedBox(height: 3.v,),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: Constant.homes.map((e) => BannerItem(type: 'home' , home: e,)).toList(),
                    ),
                  ),
                  SizedBox(height: 5.v,),
                  Row(
                    children: [
                      SizedBox(width: 5.h),
                      Text("Hotel",  style: TextStyle(fontSize: 20),),
                      Expanded(child: SizedBox()),
                      GestureDetector(onTap : (){
                        Constant.pop=true;
                        myModel.changeIndex(1);


                      },child: Text("More > ",  style: TextStyle(fontSize: 16 , color: ColorApp.primaryColor),)),
                      SizedBox(width: 5.h),
                    ],
                  ),
                  SizedBox(height: 3.v,),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                        children: Constant.hotels.map((e) => BannerItem(type: 'hotel' , hotel: e,)).toList()
                    ),
                  ),
                ],
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
                  padding: const EdgeInsets.only(top: 200,left: 40,right: 40),
                  child: Column(
                    children: [
                      Text(
                        "The the app will show you options according to the filters that you filled up. From the option you can choose and book as usual.",
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
