

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:realstatefrombegin3/model/object/suite.dart';
import 'package:realstatefrombegin3/sercives/hotelApi.dart';
import 'package:realstatefrombegin3/util/Constant.dart';
import 'package:realstatefrombegin3/util/size_config.dart';
import 'package:realstatefrombegin3/view/bottomNavigation/home/map.dart';
import 'package:realstatefrombegin3/widget/item/suiteItem.dart';

class SuitesPage extends StatefulWidget {
  final String startDate;
  final String endDate;
  final String hotelId;

  const SuitesPage({Key key, this.startDate, this.endDate,this.hotelId}) : super(key: key);
  @override
  _SuitesPageState createState() => _SuitesPageState();
}

class _SuitesPageState extends State<SuitesPage> {
  bool isLoading=true;
  List<Suite> suites=[];//=[Suite(bathroom: true,bed: 2,room: 4,wifi: true,hotelId: 6,id: 7,terrace: true,airConditioning: false,animal: false,breakFast: false,kitchen: true,tv: false),Suite(bathroom: true,bed: 2,room: 4,wifi: true,hotelId: 6,id: 7,terrace: true,airConditioning: false,animal: false,breakFast: false,kitchen: true,tv: false),Suite(bathroom: true,bed: 2,room: 4,wifi: true,hotelId: 6,id: 7,terrace: true,airConditioning: false,animal: false,breakFast: false,kitchen: true,tv: false)];

  @override
  void initState() {
    HotelApi.getSuites(context,widget.hotelId,widget.startDate.split(" ")[0],widget.endDate.split(" ")[0]).then((value) {

     /* setState(() {
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

      });*/
     setState(() {
       suites=value;
       isLoading=false;
     });
    });    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body:isLoading?Center(child: CircularProgressIndicator()): Padding(
        padding: EdgeInsets.only(left: 7.h,right:7.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 2.v,
            ),
            Text("Available suites: ",style: TextStyle(fontSize: 18),),
            SizedBox(height: 3.h,),
            Divider(
              height: 3,
              thickness: 2,
              color: Colors.grey[300],
            ),
            SizedBox(height: 2.h,),



            Expanded(
                child:suites.length == 0
                    ? Center(child: Text("There is no suite according to your filter"))
                    :
                NotificationListener<ScrollEndNotification>(
                    onNotification: (scrollEnd) {
                      var metrics = scrollEnd.metrics;
                      return true;
                    },
                    child:  ListView(

                      scrollDirection: Axis.vertical,
                      children: suites.map((e) {
                        return SuiteItem(
                          suite: e,
                          startDate: widget.startDate,
                          endDate: widget.endDate,
                          hotelId: widget.hotelId,
                        );
                      }).toList(),
                    )
                )


            ),
          ],
        ),
      ),


    );
  }
}
