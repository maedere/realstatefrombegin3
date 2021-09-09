import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:realstatefrombegin3/model/object/filter.dart';

import 'file:///E:/flutterProject/real-estate1/lib/widget/custom/Colors.dart';
import 'package:realstatefrombegin3/util/Constant.dart';
import 'package:realstatefrombegin3/util/size_config.dart';
import 'package:realstatefrombegin3/values/color_app.dart';
import 'package:realstatefrombegin3/widget/custom/button.dart';
import 'package:realstatefrombegin3/widget/item/filter_page_item.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'dart:ui' as ui;

class FilterHomePage extends StatefulWidget {
  static const String ADDRESS = 'home/filter';


  @override
  _FilterHomePageState createState() => _FilterHomePageState();
}

class _FilterHomePageState extends State<FilterHomePage> {
 // RangeValues values = RangeValues(12, 500);
  bool showCoache=false;
  SfRangeValues _values = SfRangeValues(100.0, 200000.0);
  List<int> indexes=[];
  List<double> height=[];

  //List<FilterModel> filters=[];
  String currentCity="All";
  String currentTypesss="Apartment";
  @override
  void initState() {
    Constant.homeFilters=[
      FilterModel('1', 'bedroom', false),
      FilterModel('2', 'bedroom', false),
      FilterModel('3', 'bedroom', false),
      FilterModel('4', 'bedroom', false),
      FilterModel('5', 'bedroom', false),
      FilterModel('6', 'bedroom', false),
      FilterModel('1', 'bathroom', false),
      FilterModel('2', 'bathroom', false),
      FilterModel('3', 'bathroom', false),
      FilterModel('4', 'bathroom', false)];

    SharedPreferences.getInstance().then((prefs){
      if(!prefs.containsKey("showfilterhomecoach"))
      {
        setState(() {
          showCoache=true;
        });
        prefs.setBool("showfilterhomecoach", false);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(Constant.pop)
    {
      Navigator.pop(context);
      Constant.pop=false;
    }
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: Colors.black, //change your color here
            ),
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
          ),          backgroundColor: Colors.white,
          body: Padding(
            padding: EdgeInsets.only(left: 10.h, right: 5.h),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 8.v,
                  ),
                  Text( "City area",
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: Constant.fontSize,
                        color: Colors.black),),

                  SizedBox(
                    height: 1.v,
                  ),

                    DropdownButton(items:Constant.cites.map((e) => DropdownMenuItem(child: Text(e) , value: e,)).toList().cast<DropdownMenuItem<String>>(), onChanged: (i){
                      setState(() {
                        currentCity=i;
                      });
                    },
                    value: currentCity,
                    isExpanded: true,),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text( "Type property",
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: Constant.fontSize,
                        color: Colors.black),),

                  SizedBox(
                    height: 1.v,
                  ),

                  DropdownButton(items:Constant.types.map((e) => DropdownMenuItem(child: Text(e) , value: e,)).toList().cast<DropdownMenuItem<String>>(), onChanged: (i){
                    setState(() {
                      currentTypesss = i;
                    });
                  },
                    value: currentTypesss,
                    isExpanded: true,),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text( "Price range",
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: Constant.fontSize,
                        color: Colors.black),),

                  SizedBox(
                    height: 2.v,
                  ),
                  SizedBox(
                    width: 120.v,
                    child: SfRangeSlider(
                      min: 100.0,
                      max: 200000.0,
                      values: _values,
                      interval: 49975,
                      showTicks: true,
                      showLabels: true,

                      minorTicksPerInterval: 4,
                      onChanged: (SfRangeValues values){
                        setState(() {
                          _values = values;
                        });
                      },
                    ),
                  ),

                  SizedBox(
                    height: 10.h,
                  ),
                  Text( "Bedroom choose",
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: Constant.fontSize,
                        color: Colors.black),),

                  SizedBox(
                    height: 2.v,
                  ),
                   Wrap(
                        direction: Axis.horizontal,
                        children: Constant.homeFilters
                            .where((element) => element.type == 'bedroom')
                            .map((e) {
                          return FilterPageItem(model: e);
                        }).toList(),
                      ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text( "Bathroom choose",
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: Constant.fontSize,
                        color: Colors.black),),

                  SizedBox(
                    height: 2.v,
                  ),
                  Wrap(
                        direction: Axis.horizontal,
                        children:Constant.homeFilters
                            .where((element) => element.type == 'bathroom')
                            .map((e) {
                          return FilterPageItem(model: e);
                        }).toList(),
                      ),
                  SizedBox(
                    height: 10.h,
                  ),
                  CustomButtonBig(child: Text('Search' , style: TextStyle(color: Colors.white),),color: ColorApp.primaryColor ,clickCallback:f, )
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
                              padding: const EdgeInsets.only(top: 100,left: 40,right: 40),
                              child: Column(
                                children: [
                                  Text(
                                    "You can have several filters wherein you can choose the following options:",
                                    style: TextStyle(color: Colors.white,fontSize: 20),
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.arrow_right_sharp,color: Colors.white,size: 40,),
                                    title: Text('LOCATION',textScaleFactor: 1.5,style: TextStyle(color: Colors.white,fontSize: 15),
                                    ),
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.arrow_right_sharp,color: Colors.white,size: 40,),
                                    title: Text('PROPERTY TYPE',textScaleFactor: 1.5,style: TextStyle(color: Colors.white,fontSize: 15),
                                    ),
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.arrow_right_sharp,color: Colors.white,size: 40,),
                                    title: Text('PRICE RANGE',textScaleFactor: 1.5,style: TextStyle(color: Colors.white,fontSize: 15),
                                    ),
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.arrow_right_sharp,color: Colors.white,size: 40,),
                                    title: Text('OTHER DETAILS',textScaleFactor: 1.5,style: TextStyle(color: Colors.white,fontSize: 15),
                                    ),
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
  Function f()
  {
    List<FilterModel>  tempList=[];
    for(final i in Constant.homeFilters)
    {
      if(i.active) tempList.add(i);
    }
    Navigator.pop(context,[tempList,currentCity,currentTypesss.contains("Apartment")?1:2,_values.end,_values.start]);
  }
  @override
  void dispose() {
    super.dispose();
  }
}
