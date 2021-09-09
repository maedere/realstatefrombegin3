import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'package:http/http.dart' as http;
import 'package:realstatefrombegin3/model/object/agent.dart';
import 'package:realstatefrombegin3/model/object/car.dart';
import 'package:realstatefrombegin3/model/object/home.dart';
import 'package:realstatefrombegin3/sercives/base_service.dart';
import 'package:realstatefrombegin3/util/Constant.dart';
import 'package:realstatefrombegin3/util/Tools.dart';
import 'package:realstatefrombegin3/util/size_config.dart';
import 'package:realstatefrombegin3/values/color_app.dart';
import 'package:realstatefrombegin3/widget/custom/Colors.dart';
import 'package:realstatefrombegin3/widget/custom/empty_widget.dart';
import 'package:realstatefrombegin3/widget/item/home_added.dart';
import 'dart:ui' as ui;

import 'package:shared_preferences/shared_preferences.dart';

class ListDataPage extends StatefulWidget {
  static const String ADDRESS = 'profile/list';

  @override
  _ListDataPageState createState() => _ListDataPageState();
}

class _ListDataPageState extends State<ListDataPage> {
  bool loading = false;
  List<MiniHome> dataHome = [];
  List<Agent> dataAgent = [];
  List<MiniCar> dataCar = [];

  bool showCoache =false;
  getData() async{

      if (!loading) {
      setState(() {
        loading = true;
      });
    }

    var res;
    if (Constant.type == 'company') {
      res = await patternAll(Constant.BASE_ADDRESS_ADMIN + "list_agent",context,false,data: {'token': Constant.token});
    } else if (Constant.type == 'agent') {
      res = await patternAll(Constant.BASE_ADDRESS_ADMIN + "list_property",context,false,data: {'token': Constant.token});
    } else if(Constant.type == 'user'){
       res = await patternAll(Constant.BASE_ADDRESS_ADMIN + 'get_user_car_list',context,false,data: {'token': Constant.token});
    }

    if (true) {

      final List<dynamic> result = res['data'] != null ? res['data'] : List();

      for (final service in result) {
        print(service.toString());
        if (Constant.type == 'company') {
          dataAgent.add(Agent.fromJson(service));
        } else if (Constant.type == 'agent') {
          dataHome.add(MiniHome.fromJson(service));
        }
        else if(Constant.type == 'user')
          {
            dataCar.add(MiniCar.fromJson(service));

          }
      }

      if (!mounted) return;
      setState(() {
        loading = false;
      });
    }
    SharedPreferences.getInstance().then((prefs){
      if(!prefs.containsKey("showlistdataaddedcoache"))
      {
        setState(() {
          showCoache=true;
        });
        prefs.setBool("showlistdataaddedcoache", false);
      }
    });

  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          Scaffold(
            appBar: AppBar(

              iconTheme: IconThemeData(
                color: Colors.black, //change your color here
              ),
              backgroundColor: Colors.white,
              elevation: 0,
              centerTitle: true,
              title: Text(
                'My Data List',
                style: TextStyle(color: Colors.black),
              ),
            ),
            body: Padding(
              padding: EdgeInsets.only(
                top: SizeConfig.blockSizeVertical * 2,
              ),
              child: loading
                  ? Center(child: CircularProgressIndicator())
                  : (Constant.type == 'user' && dataCar.length==0 ||
                          (Constant.type == 'company' && dataAgent.length == 0) ||
                          (Constant.type == 'agent' && dataHome.length == 0))
                      ? EmptyShow()
                      : SingleChildScrollView(
                          child: Column(
                              children: Constant.type == 'company'
                                  ? dataAgent
                                      .map((e) => HomeListItemWidget(
                                            type: 'agent',
                                            agent: e,
                                          ))
                                      .toList()
                                  : Constant.type == 'agent'?dataHome
                                      .map((e) => HomeListItemWidget(
                                            type: 'home',
                                            home: e,
                                          ))
                                      .toList()
                                 : dataCar
                                  .map((e) => HomeListItemWidget(
                                      type: 'car',
                                      car: e,
                                      ))
                                      .toList())   ,
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
                          "This will also show the other properties that you posted along with the price and other details",
                          style: TextStyle(color: Colors.white,fontSize: 20),
                        ),


                      ],
                    ),
                  ),
                  Expanded(child: SizedBox()),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10,right: 10),
                    child: Align(
                      alignment: AlignmentDirectional.bottomEnd,

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
      ),
    );
  }
}
