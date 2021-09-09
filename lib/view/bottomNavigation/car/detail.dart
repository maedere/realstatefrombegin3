import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:realstatefrombegin3/model/object/car.dart';
import 'package:realstatefrombegin3/model/object/comment.dart';
import 'package:realstatefrombegin3/sercives/carApi.dart';
import 'package:realstatefrombegin3/util/Constant.dart';
import 'package:realstatefrombegin3/util/Tools.dart';
import 'package:realstatefrombegin3/util/size_config.dart';
import 'package:realstatefrombegin3/values/color_app.dart';
import 'package:realstatefrombegin3/values/icon_app_icons.dart';
import 'package:realstatefrombegin3/view/bottomNavigation/profile/fav_page.dart';
import 'package:realstatefrombegin3/widget/item/comment.dart';
import 'package:realstatefrombegin3/widget/item/detail_home_item.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class CarDetailPage extends StatefulWidget {
  static const String ADDRESS = "car/detail";

  final String id;


  CarDetailPage(this.id);

  @override
  _CarDetailPageState createState() => _CarDetailPageState();
}

class _CarDetailPageState extends State<CarDetailPage> {
  List<Comment> comments = [];
  FocusNode _focusNode;
  TextEditingController _editingController;
  bool _showButtons = true;

  bool fav = false;
  Car car;
  MiniCar miniCar;

  String mapStyle = "";
  GoogleMapController _controllerMap;

  Set<Marker> mark = Set();

  getData() async {
    final Map<String, dynamic> data = {'id': widget.id};
    final value = await CarApi.singleCar(widget.id,context);
    car=value[0];
    comments=value[1];

    mark.add(
      Marker(
          markerId: MarkerId(car.id.toString()),
          position: LatLng(
            car.lat,
            car.lng,
          )),
    );

    miniCar=
        MiniCar(id:car.id,
            totalTrips: car.totalTrips,
            lat: car.lat,
            lng: car.lng,
            cost: car.cost,
            year: car.year,
            model: car.model,
            company: car.company,
            images: car.images);
    setState(() {
      fav=false;
      for (final i in Constant.favorites)
        {
          if(i is MiniCar && i.id==miniCar.id)
            {
              fav=true;
              break;
            }
        }
     // Constant.favorites.contains(miniCar) ? fav =true : fav = false;
    });
    if (!mounted) return;
    setState(() {});
  }
  Widget _buttonFloat(IconData icon, String name) {
    return GestureDetector(
      onTap: () {
        if(name.contains("call"))
          _callMe();
        else
          _textMe();
      },
      child: Container(
        width: 34.h,
        padding: EdgeInsets.symmetric(vertical: 2.v),
        decoration: BoxDecoration(
          color: ColorApp.primaryColor,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 16,
              color: Colors.white,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              name,
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }

  _callMe() async {
    if (Platform.isAndroid) {
      String uri = 'tel:+1 '+car.phone;
      if (await canLaunch(uri)) {
        await launch(uri);
      } else if (Platform.isIOS) {
        String uri = 'tel:00'+car.phone.replaceAll(" ", "-");
        if (await canLaunch(uri)) {
          await launch(uri);
        } else {
          throw 'Could not launch $uri';
        }
      }
    }
  }

  _textMe() async {
    if (Platform.isAndroid) {
      String uri = 'sms:+'+car.phone;
      if (await canLaunch(uri)) {
        await launch(uri);
      } else if (Platform.isIOS) {
        String uri = 'sms:00'+car.phone.replaceAll(" ", "-");
        if (await canLaunch(uri)) {
          await launch(uri);
        } else {
          throw 'Could not launch $uri';
        }
      }
    }
  }

  @override
  void initState() {
    _editingController = TextEditingController();

    _focusNode = FocusNode()
      ..addListener(() {
        if (_focusNode.hasFocus) {
          _showButtons = false;
        } else {
          _showButtons = true;
        }

        setState(() {});
      });

    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: car == null ? Center(child: CircularProgressIndicator(),) : Stack(
        children: [
          GestureDetector(
            onTap: (){
              FocusScope.of(context).requestFocus(new FocusNode());

            },
            child: Stack(
              children: [
                CustomScrollView(
                  slivers: <Widget>[
                    SliverAppBar(
                      floating: true,

                      actions: [
                        SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onLongPress: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>FavoritePage()));
                          },

                          onTap: () {
                            setState(() {
                              fav = !fav;
                              Tools.editFavorite(miniCar , fav);
                            });
                          },
                          child: Icon(IconApp.favorite,
                              size: 20,
                              color: fav ? Colors.redAccent : Colors.white),
                        ),
                      ],
                      flexibleSpace: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          image: DecorationImage(image:  (car.images.length  == 0)
                              ? AssetImage(
                              Constant.IMAGE_ADDRESS + "fiat.jpg")
                              : NetworkImage(
                              Constant.BASE_IMAGE_ADDRESS + car.images[0].toString()), fit: BoxFit.cover),
                        ),
                      ),

                      expandedHeight: SizeConfig.screenHeight / 3,
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                            (context, index) {
                          return SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 3.v,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10.h),
                                  child: Text(
                                    '${car.company} ${car.model} ${car.year}',
                                    style: TextStyle(fontSize: 22),
                                  ),
                                ),

                                //list horizontal az custom widget
                                SizedBox(
                                  height: 8.v,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10.h),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Price",
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                      SizedBox(width: 2.v,),
                                      RichText(
                                        text: TextSpan(
                                          text: "\$${car.cost}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w800,
                                              color: Colors.grey,
                                              fontSize: 20,
                                              ),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: ' /day',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14,
                                                  decoration: TextDecoration.none),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 1.v,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 90.h,
                                      child: ListTile(
                                        leading: Icon(Icons.location_city),
                                        title: Transform.translate(
                                          offset: Offset(-16, 0),
                                          child: Text(
                                            "City: "+(car.city==null?'':car.city),
                                            style: TextStyle(
                                                color: Colors.grey),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(child: SizedBox()),
                                    //todo new widget create
                                    //   FilterItem(text: home.category),
                                  ],
                                ),
                               /* Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10.h),
                                  child: Row(
                                    children: [
                                      Text("Price Now"),
                                      Expanded(child: SizedBox()),
                                      RichText(
                                        text: TextSpan(
                                          text: "\$${car.cost}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w800,
                                              color: Colors.black,
                                              fontSize: 24),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: ' /day\n',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 15),
                                            ),
                                            TextSpan(
                                              text: ' You\'re saving',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 15,
                                                  fontFamily: 'CostumFont',
                                                  color: Colors.green[400]),
                                            ),
                                            TextSpan(
                                              text: ' \$10',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w800,
                                                  fontSize: 15,
                                                  color: Colors.green[400]),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),*/
                                SizedBox(
                                  height: 5.v,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10.h),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        DetailHomeItem(
                                          name: 'seats',
                                          data: car.seat.toString(),
                                        ),
                                        DetailHomeItem(
                                          name: 'doors',
                                          data: car.door.toString(),
                                        ),
                                        DetailHomeItem(
                                          name: 'year',
                                          data: car.year.toString(),
                                        ),
                                        DetailHomeItem(
                                          name: 'Color',
                                          data: car.color,
                                        ),
                                        DetailHomeItem(
                                          name: 'Insurance',
                                          data: car.insurance == 0 ? 'NO' : 'YES',
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5.v,
                                ),
                                ListTile(
                                  leading: Icon(
                                    IconApp.security_pin,
                                    color: ColorApp.primaryColor,
                                  ),
                                  title: Text(car.address,style: TextStyle(fontSize: Constant.fontSize/1.5),),
                                ),
                                Container(
                                  height: 22.v,
                                  width: double.infinity,
                                  child: GoogleMap(
                                    initialCameraPosition: CameraPosition(
                                        target: LatLng(car.lat, car.lng)),
                                    onMapCreated: (controller) {
                                      _controllerMap = controller;
                                      _controllerMap.setMapStyle(mapStyle);
                                    },
                                    gestureRecognizers: Set()
                                      ..add(Factory<EagerGestureRecognizer>(
                                              () => EagerGestureRecognizer())),
                                    markers: mark,
                                  ),
                                ),
                                SizedBox(
                                  height: 5.v,
                                ),
                                Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10.h),
                                    child: Text(
                                      "Reviews",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 18),
                                    )),
                                SizedBox(
                                  height: comments.length * 8.v,
                                  child: ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    itemCount: comments.length,
                                    itemBuilder: (context, index) {
                                      return CommentItem(
                                        comment: comments[index],
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 3.v,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 5.h,
                                    ),
                                    Expanded(
                                      child: TextField(
                                        focusNode: _focusNode,
                                        controller: _editingController,

                                        decoration: InputDecoration(
                                            hintText:
                                            'please submit your\'s text',
                                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(50))),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 2.h,
                                    ),
                                    GestureDetector(
                                      onTap: (){
                                        _submitReview(context);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 2.v, horizontal: 3.h),
                                        child: Text('submit' , style: TextStyle(color: Colors.white),),
                                        decoration: BoxDecoration(
                                          color: ColorApp.primaryColor,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(50)),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5.h,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 1.v,
                                ),
                                SizedBox(
                                  height: 20.v,
                                ),
                              ],
                            ),
                          );
                        },
                        childCount: 1,
                      ),
                    ),
                  ],
                ),

                _showButtons
                    ? Positioned(
                    left: 14.h,
                    bottom: 5.v,
                    child: _buttonFloat(IconApp.mail, "message"))
                    : SizedBox(),
                _showButtons
                    ? Positioned(
                    right: 14.h,
                    bottom: 5.v,
                    child: _buttonFloat(IconApp.phone, "call"))
                    : SizedBox()
              ],
            ),
          ),

        ],
      ),
    );
  }
  void _submitReview(BuildContext context) async{

    if (Constant.login && Constant.type == 'user') {

      if (_editingController.text.isEmpty) {
        Scaffold.of(context).showSnackBar(SnackBar(content: Container(height: 5.v,child: Center(child : Text('please first fill text')),),),);
      }else{
        CarApi.addComment(_editingController.text,car.id,context).then((value) {
          _editingController.clear();
          getData();
        });


      }
    }else{
      Scaffold.of(context).showSnackBar(SnackBar(content: Container(height: 5.v,child: Center(child : Text('just users can submit a comment')),),),);
    }

  }

}