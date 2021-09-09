
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:realstatefrombegin3/model/object/hotel.dart';
import 'package:realstatefrombegin3/sercives/base_service.dart';
import 'package:realstatefrombegin3/util/Constant.dart';
import 'package:realstatefrombegin3/util/Tools.dart';
import 'package:realstatefrombegin3/util/size_config.dart';
import 'package:realstatefrombegin3/values/color_app.dart';
import 'package:realstatefrombegin3/widget/custom/Colors.dart';
import 'package:realstatefrombegin3/widget/item/map_item.dart';
import 'package:http/http.dart' as http;
import 'dart:ui' as ui;

import 'package:shared_preferences/shared_preferences.dart';

class MapPage extends StatefulWidget {
  static const String ADDRESS = "map";

  //0 -> property , 1 -> hotel , 2 ->all , 3->car
  final int type;

  MapPage({this.type = 0});

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  String mapStyle = "";
  Set<Marker> mark = Set();

  bool showCoache=false;
  Uint8List customIconHotel;
  Uint8List customIconHome;
  Uint8List customIconCar;

  List<HotelModel> miniList;
  bool isLoading=false;

  GoogleMapController _controller;
  LatLng here = LatLng(25.23333456111011, 55.41756201535463);

  getData() async {
    miniList = [];

    setState(() {
      isLoading=true;
    });
    var res;
    //http.Response res;
    if (widget.type == 0) {
       res = await patternAll(Constant.BASE_ADDRESS + "propertyListMap",context,false);
    } else if (widget.type == 2) {
       res = await patternAll(Constant.BASE_ADDRESS + "allListMap",context,false);
    } else if (widget.type == 3){
       res = await patternAll(Constant.BASE_ADDRESS + "carListMap",context,false);
    } else {
       res = await patternAll(Constant.BASE_ADDRESS + "hotelListMap",context,false);
    }

    setState(() {
      isLoading=false;
    });


      final List<dynamic> result =
        res['data']['hotels'] != null ? res['data']['hotels'] : List();
      for (final service in result) {
        miniList.add(HotelModel.fromJson(service));
        _setMarkers(service['id'].toString(), service['lat'].toString(), service['lng'].toString());
      }

      here = LatLng(double.parse(miniList[0].lat) , double.parse(miniList[0].lng));

      if (!mounted) return;
      setState(() {

      });
    SharedPreferences.getInstance().then((prefs){
      if(!prefs.containsKey("showmapcoach"))
      {
        setState(() {
          showCoache=true;
        });
        prefs.setBool("showmapcoach", false);
      }
    });

    
  }

  _setMarkers(String id, String lat, String lng) {
    mark.add(Marker(
        markerId: MarkerId(id),
        position: LatLng(
          double.parse(lat),
          double.parse(lng),
        ),
        icon: BitmapDescriptor.fromBytes(widget.type==0?customIconHome:widget.type==3?customIconCar:widget.type==1?customIconHotel:null),
      onTap: () {
        //BlocProvider.of<RouteBloc>(context).add(RouteChangePageEvent(address: DetailHotelPage.ADDRESS , object: id));
      },
    ));


  }

  createMarket(BuildContext context) {
    if (customIconHotel == null) {

      getBytesFromAsset(Constant.IMAGE_ADDRESS + 'hotel.png', 70)
          .then((value) =>
          setState(() {
            customIconHotel = value;
          }));
    }
    if (customIconHome == null) {

      getBytesFromAsset(Constant.IMAGE_ADDRESS + 'home.png', 70)
          .then((value) =>
          setState(() {
            customIconHome = value;
          }));
    }
    if (customIconCar == null) {

      getBytesFromAsset(Constant.IMAGE_ADDRESS + 'car.png', 70)
          .then((value) =>
          setState(() {
            customIconCar = value;
          }));
    }
   /* if (customIconHotel == null) {
      ImageConfiguration imageConfiguration =
      createLocalImageConfiguration(context);
      BitmapDescriptor.fromAssetImage(
          imageConfiguration, Constant.IMAGE_ADDRESS + 'hotel.png')
          .then((value) =>
          setState(() {
            customIconHotel = value;
          }));
    }
    if (customIconHome == null) {
      ImageConfiguration imageConfiguration =
      createLocalImageConfiguration(context);
      BitmapDescriptor.fromAssetImage(
          imageConfiguration, Constant.IMAGE_ADDRESS + 'home.png')
          .then((value) =>
          setState(() {
            customIconHome = value;
          }));
    }
    if (customIconCar == null) {
      ImageConfiguration imageConfiguration =
      createLocalImageConfiguration(context);
      BitmapDescriptor.fromAssetImage(
          imageConfiguration, Constant.IMAGE_ADDRESS + 'car.png')
          .then((value) =>
          setState(() {
            customIconCar = value;
          }));
    }*/
  }

  @override
  void initState() {
    rootBundle
        .loadString('assets/style/map_style.txt')
        .then((value) => mapStyle = value);

    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(Constant.pop)
    {
      Navigator.pop(context);
      Constant.pop=false;
    }
    createMarket(context);
    return Scaffold(
      body: isLoading?Center(child: CircularProgressIndicator(),):Stack(
        children: [
          GoogleMap(
            myLocationEnabled: true,
            initialCameraPosition: CameraPosition(
                target: here,
                zoom: 12),
            onMapCreated: (controller) {
              _controller = controller;
              _controller.setMapStyle(mapStyle);
            },
            markers: mark,
          ),
          Positioned(
            left: 10.h,
            top: 5.v,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: 8.v,
                height: 8.v,
                padding: EdgeInsets.all(1.v),
                decoration:
                    BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                child: Center(
                    child: Icon(
                  Icons.clear,
                  color: Colors.grey[600],
                )),
              ),
            ),
          ),
          Align(
            alignment: AlignmentDirectional.bottomCenter,
            child: Container(
              width: double.infinity,
              height: 32.v,
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(.9),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.white.withOpacity(.6),
                        offset: Offset(0, 6.v),
                        blurRadius: 10),
                    BoxShadow(
                        color: Colors.white.withOpacity(.6),
                        offset: Offset(0, -6.v),
                        blurRadius: 10),
                  ]),
            ),
          ),
          Positioned(
            bottom: 32.v,
            left: 5.h,
            right: 5.h,
            child: Row(
              children: [
                RichText(
                  text: TextSpan(
                    text:miniList == null ? '-' : miniList.length.toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                        fontSize: 24),
                    children: <TextSpan>[
                      TextSpan(
                        text: widget.type == 0 ? 'Property' : widget.type == 1 ? ' hotels' : widget.type == 2 ? 'All Products' : 'Cars',
                        style: TextStyle(fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                ),
                Expanded(child: SizedBox()),
              ],
            ),
          ),
          Align(
            alignment: AlignmentDirectional.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(left: 5.h, bottom: 2.v),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: miniList == null
                      ? []
                      : miniList.map(
                          (e) => MapItem(
                            hotel: e,
                            type:widget.type
                          ),
                        ).toList(),
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
                          "You can see also other properties within the locality that you chosen, it will give you options to choose whatever suits your requirements.",
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
      ),
    );
  }
  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png)).buffer.asUint8List();
  }
}
