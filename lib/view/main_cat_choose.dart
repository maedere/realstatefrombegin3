
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:realstatefrombegin3/util/Constant.dart';
import 'file:///E:/flutterProject/real-estate1/lib/widget/custom/Colors.dart';
import 'package:realstatefrombegin3/values/color_app.dart';
import 'package:realstatefrombegin3/values/icon_app_icons.dart';
import 'package:realstatefrombegin3/widget/item/main_cat_item.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class MainCatChoose extends StatefulWidget {
  @override
  _MainCatChooseState createState() => _MainCatChooseState();
}

class _MainCatChooseState extends State<MainCatChoose> {
  TutorialCoachMark tutorialCoachMark;
  List<TargetFocus> targets = List();

  bool showCoache=false;
  GlobalKey _key1 = GlobalKey();

  @override
  void initState() {

    SharedPreferences.getInstance().then((prefs){
      if(!prefs.containsKey("showmaincatchoosecoach"))
      {
        setState(() {
          showCoache=true;
        });
        prefs.setBool("showmaincatchoosecoach", false);
      }


    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: showCoache?1.5:0, sigmaY: showCoache?1.5:0),

              child: Column(
                children: [
                  Expanded(child: MainCatItem(image: 'h1.jpg', name: "Hotel", count: "100" , index: 1,)),
                  Expanded(child: MainCatItem(image: 'ban1.jpg', name: "Buy / Rent", count: "101" , index: 0,)),
                  Expanded(child: MainCatItem(image: 'car3.jpg', name: "Rent Car", count: "103",index: 3,)),
                ],
              ),
            ),
            showCoache?Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: ColorApp.blackColor,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 200,left: 40,right: 40),
                    child: Text(
                      "Featuring the app “REAL PROPERTY” it enables you to Buy or Rent properties, Book a Hotel and Rent a Car. ",
                      style: TextStyle(color: Colors.white,fontSize: 20),

                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height/10,),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        Expanded(child: SizedBox()),
                        Icon(Icons.touch_app,size: MediaQuery.of(context).size.height/8,color: Colors.blue),
                        Container(
                          width: MediaQuery.of(context).size.width/3,
                            child: Text("Everything in just a click of your finger tips.",style: TextStyle(color: Colors.blue,fontSize: 16),)),
                        Expanded(child: SizedBox()),

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
            ):SizedBox()
          ],
        ),
      ),
    );
  }




}


