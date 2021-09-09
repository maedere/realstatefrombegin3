

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:realstatefrombegin3/model/object/suite.dart';
import 'package:realstatefrombegin3/sercives/hotelApi.dart';
import 'package:realstatefrombegin3/util/Constant.dart';
import 'package:realstatefrombegin3/util/size_config.dart';
import 'package:realstatefrombegin3/values/color_app.dart';
import 'package:realstatefrombegin3/values/icon_app_icons.dart';
import 'package:realstatefrombegin3/view/bottomNavigation/hotel/suite.dart';
import 'package:giffy_dialog/giffy_dialog.dart';

import 'extra_hotel_item.dart';

class SuiteItem extends StatefulWidget {
  final Suite suite;

  final String hotelId;
  final String startDate;
  final String endDate;

  const SuiteItem({Key key, this.suite, this.startDate, this.endDate,this.hotelId}) : super(key: key);
  @override
  _SuiteItemState createState() => _SuiteItemState();
}

class _SuiteItemState extends State<SuiteItem> {
  bool isLoading=false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(bottom: 4.h),
      child: Card(
        color: Colors.grey[100],
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [

              Row(
                children: [
                  Icon(Icons.hotel),
                  SizedBox(width: 2.v,),
                  Text("Bed room:"),
                  SizedBox(width: 3.v,),

                  Text(widget.suite.bed.toString()),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.home),
                  SizedBox(width: 2.v,),
                  Text("Room:"),
                  SizedBox(width: 3.v,),

                  Text(widget.suite.room.toString()),
                ],
              ),
              SizedBox(height: 3.h,),
              Align(child: Text("Features:"),alignment: Alignment.centerLeft,),
              SizedBox(height: 3.h,),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    if(widget.suite.kitchen)
                      ExtraHotelItem(
                        icon: Icons.kitchen,
                        name: "kitchen",
                      ),
                    if(widget.suite.bathroom)
                        ExtraHotelItem(
                        icon: Icons.bathtub,
                        name: "bathroom",
                      ),
                    if(widget.suite.breakFast)
                        ExtraHotelItem(
                        icon: Icons.free_breakfast,
                        name: "breakfast",
                      ),
                    if(widget.suite.terrace)
                        ExtraHotelItem(
                        icon: Icons.water_damage_rounded,
                        name: "terrace",
                      ),
                    if(widget.suite.airConditioning)
                        ExtraHotelItem(
                        icon: Icons.invert_colors_sharp,
                        name: "ventilation",
                      ),
                    if(widget.suite.wifi)
                        ExtraHotelItem(
                        icon: Icons.wifi,
                        name: "wifi",
                      ),
                    if(widget.suite.tv)
                        ExtraHotelItem(
                        icon: Icons.tv,
                        name: "tv",
                      ),
                    if(widget.suite.animal)
                        ExtraHotelItem(
                        icon: Icons.pets,
                        name: "animal",
                      ),


                  ],
                ),
              ),
              Divider(
                height: 3,
                thickness: 2,
                color: Colors.grey[300],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8,bottom: 8),
                child: Column(
                  children: [

                    Row(
                      children: [
                        Icon(Icons.monetization_on_sharp),
                        SizedBox(width: 2.v,),

                        Text("Price:",style: TextStyle(fontSize: 14),),
                        SizedBox(width: 3.v,),
                        Text(widget.suite.priceAll,
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                color: Colors.black,
                                fontSize: 12)),
                        Text(" /night",
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                color: Colors.black,
                                fontSize: 12)),
                      ],
                    ),

                  ],
                ),
              ),
              GestureDetector(
                onTap: (){

                  setState(() {
                    isLoading=true;
                  });
                  try{
                    HotelApi.reserveSuite(context,widget.suite.id,widget.startDate.split(" ")[0],widget.endDate.split(" ")[0], Constant.userName).then((value) {
                      setState(() {
                        isLoading=false;
                      });
                      if(value==null)
                        showDialog(
                            context: context,builder: (_) => NetworkGiffyDialog(
                          title: Text('This suite has been reserved for this time, please choose another one',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.w600,

                              )),

                          onOkButtonPressed: () {
                            Navigator.pop(context);
                            Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>SuitesPage(startDate: widget.startDate,endDate: widget.endDate,hotelId: widget.hotelId,)));

                          },
                          image: Image(

                            image: AssetImage(
                              "assets/gifs/oups.gif",
                            ),
                            fit: BoxFit.fill,
                            width: double.infinity,
                            height: double.infinity,
                          ),

                          onlyOkButton: true,
                        ) ,
                            barrierDismissible: false
                        );


                      if(value.contains("ok"))
                      {
                        showDialog(
                            context: context,builder: (_) => NetworkGiffyDialog(
                          title: Text('Reservation completed successfully',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 19.0,
                                  fontWeight: FontWeight.w600)),

                          onOkButtonPressed: () {
                            Navigator.of(context, rootNavigator: true).pop();
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          image: Image(

                            image: AssetImage(
                              "assets/gifs/check.gif",
                            ),
                            fit: BoxFit.fill,
                            width: double.infinity,
                            height: double.infinity,
                          ),

                          onlyOkButton: true,
                          buttonOkColor: ColorApp.primaryColor,
                          buttonRadius: 30,
                        ) ,
                            barrierDismissible: false
                        );
                      }


                    });
                  } on Exception catch (exception) {
                  } catch (error) {
                  }

                },
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(
                      horizontal: 2.h, vertical: 1.v),
                  height: 7.v,
                  padding: EdgeInsets.symmetric(vertical: 1.v),
                  child: Center(
                    child: isLoading?CircularProgressIndicator():Text(
                      "Reserve",
                      style: TextStyle(
                          color: Colors.white, fontSize: 16),
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: ColorApp.primaryColor,
                    borderRadius:
                    BorderRadius.all(Radius.circular(30)),
                  ),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
