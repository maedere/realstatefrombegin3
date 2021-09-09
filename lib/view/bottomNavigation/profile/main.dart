import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realstatefrombegin3/model/NavigationProvider.dart';

import 'package:realstatefrombegin3/util/Constant.dart';
import 'package:realstatefrombegin3/util/size_config.dart';
import 'package:realstatefrombegin3/values/color_app.dart';
import 'package:realstatefrombegin3/view/bottomNavigation/profile/profile_after_login.dart';
import 'package:realstatefrombegin3/view/bottomNavigation/profile/signup.dart';

import 'package:realstatefrombegin3/widget/custom/Colors.dart';
import 'package:realstatefrombegin3/widget/custom/mini_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:ui' as ui;

import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import 'loginPage.dart';

class ProfileMainPage extends StatefulWidget {
  static const String ADDRESS = "profile/main";

  @override
  _ProfileMainPageState createState() => _ProfileMainPageState();
}

class _ProfileMainPageState extends State<ProfileMainPage> {
  bool showCoach=false;
  TutorialCoachMark tutorialCoachMark;
  List<TargetFocus> targets = [];
  GlobalKey  _key1 = GlobalKey();
  GlobalKey  _key2 = GlobalKey();
  @override
  void initState() {
    //initTargets();
    Future.delayed(const Duration(milliseconds: 500), () {

        SharedPreferences.getInstance().then((prefs){
          if(!prefs.containsKey("showmainprofilecoach"))
          {
            print("hoooora");
            initTargets();
            WidgetsBinding.instance.addPostFrameCallback((_) async{

              showTutorial();

            });
            prefs.setBool("showmainprofilecoach", false);
          }
        });


    });


    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              Constant.IMAGE_ADDRESS + 'blur.jpg',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
          child: Container(
              decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)),
              child: Column(
                children: [
                  SizedBox(height: 10.v,),
                  Text("Hotel Enjoy has been welcoming\n real estate" ,textAlign: TextAlign.center, style: TextStyle(color: Colors.white , fontSize: Constant.fontSize*1.3  , shadows: [
                  ]),),
                  Expanded(child: SizedBox()),
                  GestureDetector(
                      key: _key2,

                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage(),));

                      },
                      child: CustomButtonMini(color: Colors.white,child: Text("login" , style: TextStyle(fontSize: Constant.fontSize , color: ColorApp.accentColor ),),)),
                  SizedBox(height: 2.v,),
                  GestureDetector(
                    key: _key1,
                      onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage(),));
                      },
                      child: CustomButtonMini( color: Colors.white, child: Text("Register" , style: TextStyle(fontSize: Constant.fontSize , color: ColorApp.primaryColor )))),
                  SizedBox(height: 10.v,),
                ],
              )
          ),
        ),
      ),
    );
  }
  void initTargets() {

    targets.add(
      TargetFocus(
        identify: "Target 1",
        keyTarget: _key2,
        color: ColorApp.blackColor,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            child: Container(
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  "If you are an existing use you can LOG-IN as usual.",
                  style: TextStyle(color: Colors.white,fontSize: 20),
                ),
              ),
            ),
          )
        ],
        shape: ShapeLightFocus.RRect,
        radius: 200,
      ),
    );
    targets.add(
      TargetFocus(
        identify: "Target 1",
        keyTarget: _key1,
        color: ColorApp.blackColor,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            child: Container(
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  "If you are a new use you can click REGISTER and follow the prompt",
                  style: TextStyle(color: Colors.white,fontSize: 20),
                ),
              ),
            ),
          )
        ],
        shape: ShapeLightFocus.RRect,
        radius: 200,
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


