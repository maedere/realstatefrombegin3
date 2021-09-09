
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:realstatefrombegin3/model/object/agent.dart';
import 'package:realstatefrombegin3/model/object/company.dart';
import 'package:realstatefrombegin3/model/object/user.dart';
import 'package:realstatefrombegin3/sercives/base_service.dart';
import 'package:realstatefrombegin3/util/Constant.dart';
import 'package:realstatefrombegin3/util/Tools.dart';
import 'package:realstatefrombegin3/util/size_config.dart';
import 'package:realstatefrombegin3/values/color_app.dart';
import 'package:realstatefrombegin3/view/welcome.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

import 'main_cat_choose.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    SizeConfig sizeConfig = new SizeConfig();
    sizeConfig.init(context);
    getUserToken(context);

    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Text(
            'Real Estate',
            style: TextStyle(
                color: ColorApp.primaryColor,
                fontSize: 25,
                fontWeight: FontWeight.w800
            ),
          ),
        ),
      ),);
  }

  void getUserToken(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.getString('token');

    if (token != null && token != '') {
      final Map<String, dynamic> data = {
        'token': token,
      };
      print(token);
      final res = await patternAll(Constant.BASE_ADDRESS+"check_token",context,false,data: {'token': token});

        Constant.login = true;
        Constant.type = res['role'];
        switch (Constant.type) {
          case 'company':
            Constant.token = res['company']['token'];
            Constant.userName=res['company']['email'];
            break;
          case 'agent':
            Constant.token = res['agent']['token'];
            Constant.userName=res['agent']['email'];
            break;
          case 'user':
            Constant.token = res['user']['Token'];
            Constant.userName=res['user']['Email'];
            break;

      }
    }

    SharedPreferences.getInstance().then((prefs){
      if(!prefs.containsKey("showmaincatchoosecoach"))
      {
        Future.delayed(Duration(seconds: 1)).then((value) =>
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => IntroScreen(),
                )));
      }
      else{
        Future.delayed(Duration(seconds: 1)).then((value) =>
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => MainCatChoose(),
                )));
      }


    });

  }
}