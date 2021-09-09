import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:realstatefrombegin3/model/object/comment.dart';
import 'package:realstatefrombegin3/model/object/home.dart';
import 'package:realstatefrombegin3/model/object/person.dart';
import 'package:realstatefrombegin3/sercives/homeApi.dart';
import 'file:///E:/flutterProject/real-estate1/lib/widget/custom/Colors.dart';
import 'package:realstatefrombegin3/util/Constant.dart';
import 'package:realstatefrombegin3/util/Tools.dart';
import 'package:realstatefrombegin3/util/size_config.dart';
import 'package:realstatefrombegin3/values/color_app.dart';
import 'package:realstatefrombegin3/values/icon_app_icons.dart';
import 'package:realstatefrombegin3/view/bottomNavigation/profile/fav_page.dart';
import 'package:realstatefrombegin3/widget/item/agent_item.dart';
import 'package:realstatefrombegin3/widget/item/comment.dart';
import 'package:realstatefrombegin3/widget/item/detail_home_item.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:http/http.dart' as http;

import '../../../model/object/agent.dart';
import 'dart:ui' as ui;

class DetailHomePage extends StatefulWidget {
  static const ADDRESS = "home/detail";
  final String id;

  DetailHomePage(this.id);

  @override
  _DetailHomePageState createState() => _DetailHomePageState();
}

class _DetailHomePageState extends State<DetailHomePage> {
  ScrollController _controller;
  final _navigatorKey = GlobalKey<NavigatorState>();

  bool _showButtons = true;

  FocusNode _focusNode;
  TextEditingController _editingController;

  Set<Marker> mark = Set();

  HomeModel home;
  MiniHome miniHome;
  Agent agent;
  List<Comment> comments = [];

  String mapStyle = "";
  GoogleMapController _controllerMap;

  bool fav = false;
  TutorialCoachMark tutorialCoachMark;
  List<TargetFocus> targets = [];

  bool showCoache=false;
  GlobalKey  _key1 = GlobalKey();
  GlobalKey  _key2 = GlobalKey();
  GlobalKey  _key3 = GlobalKey();
  GlobalKey  _key4 = GlobalKey();
  ScrollController _scrollController = ScrollController();

  getData() async {

     final value=await HomeApi.singleHome(widget.id,context);
    setState(() {
      home = value[0];
      agent = value[1];
      comments=value[2];
      mark.add(
        Marker(
            markerId: MarkerId(home.id),
            position: LatLng(
              double.parse(home.lat),
              double.parse(home.lng),
            )),
      );

      miniHome = new MiniHome(
          image: home.images.length!=0?home.images[0]:"",
          id: home.id,
          address: home.address,
          bathroom: home.bathroom,
          bedroom: home.bedroom,
          price: home.price,
          size: home.size);

      if (Constant.favorites.contains(miniHome)) {
        fav = true;
      }

      if (!mounted) return;
      setState(() {});


      SharedPreferences.getInstance().then((prefs){
        if(!prefs.containsKey("showdetailhomecoach"))
        {
          initTargets();
          WidgetsBinding.instance.addPostFrameCallback((_) async{

            showTutorial();

          });
          prefs.setBool("showdetailhomecoach", false);
        }
      });
   });


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

    rootBundle
        .loadString('assets/style/map_style.txt')
        .then((value) => mapStyle = value);

    _controller = ScrollController();





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

          backgroundColor: Colors.white,
          body: home == null
              ? Center(child: CircularProgressIndicator())
              : GestureDetector(
                  onTap: () {
                    FocusScope.of(context).requestFocus(new FocusNode());
                  },
                  child: Stack(
                    children: [

                      CustomScrollView(
                        controller: _controller,
                        slivers: <Widget>[
                          SliverAppBar(

                            backgroundColor: Colors.white,
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
                                    Tools.editFavorite(miniHome, fav);
                                  });
                                },
                                child: Icon(IconApp.favorite,
                                    size: 20,
                                    color: fav ? Colors.redAccent : Colors.white),
                              ),
                            ],
                            floating: true,
                            flexibleSpace: Container(
                              key: _key1,

                              decoration: BoxDecoration(

                                  image: DecorationImage(
                                    fit: BoxFit.fill,

                                    image: (home.images == null ||
                                        home.images.length == 0)
                                    ? AssetImage(Constant.IMAGE_ADDRESS + "h5.jpg")
                                    : NetworkImage(Constant.BASE_IMAGE_ADDRESS +
                                        home.images[0].toString()),
                              )),
                            ),
                            expandedHeight: SizeConfig.screenHeight / 3,
                          ),
                          SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                return SingleChildScrollView(
                                  controller: _scrollController,

                                  child: Container(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 8.v,
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment: MainAxisAlignment.center, //Center Row contents horizontally,
                                          crossAxisAlignment: CrossAxisAlignment.center ,//Center Row contents vertically,
                                          children: [
                                            Text(
                                              '\$${home.price}',
                                              style: TextStyle(
                                                fontSize: 22,
                                              ),

                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 1.h,
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
                                                    "City: "+home.city,
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
                                        SizedBox(
                                          height: 5.v,
                                        ),
                                        Padding(

                                            padding: EdgeInsets.symmetric(
                                                horizontal: 5.h),
                                            child: Text('House Information')),
                                        SizedBox(
                                          height: 5.v,
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsets.symmetric(horizontal: 5.h),
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              children: [
                                                DetailHomeItem(
                                                    data: home.size,
                                                    name: "square foot"),
                                                DetailHomeItem(
                                                    data: home.bathroom,
                                                    name: "bathroom"),
                                                DetailHomeItem(
                                                    data: home.bedroom,
                                                    name: "bedroom"),
                                                DetailHomeItem(
                                                    data: home.yearOfBuilt,
                                                    name: "Year Built"),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5.v,
                                        ),
                                        ListTile(
                                            leading: Icon(Icons.directions_car_sharp),
                                            title: Transform.translate(
                                                offset: Offset(-16, 0),
                                                child: Text("Garage capacity: "+home.garageCapacity+" car"+(home.garageCapacity=="0"?"":"s"))),
                                        ),
                                        SizedBox(
                                          height: 5.v,
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsets.symmetric(horizontal: 5.h),
                                          child: Text(
                                            home.description,
                                            style: TextStyle(fontFamily: "long"),
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
                                          title: Text(home.address,style: TextStyle(fontSize: Constant.fontSize/1.5),),
                                        ),
                                        Container(
                                          key: _key2,

                                          height: 22.v,
                                          width: double.infinity,
                                          child: Stack(children: [
                                            GoogleMap(


                                              initialCameraPosition: CameraPosition(
                                                  target: LatLng(
                                                      double.parse(home.lat),
                                                      double.parse(home.lng))),
                                              onMapCreated: (controller) {
                                                _controllerMap = controller;
                                                _controllerMap
                                                    .setMapStyle(mapStyle);
                                              },
                                              gestureRecognizers: Set()
                                                ..add(Factory<
                                                        EagerGestureRecognizer>(
                                                    () =>
                                                        EagerGestureRecognizer())),
                                              markers: mark,
                                            ),
                                          ]),
                                        ),
                                        SizedBox(
                                          height: 5.v,
                                        ),
                                        AgentShow(
                                          agent: agent,
                                        ),
                                        SizedBox(
                                          height: 5.v,
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsets.symmetric(horizontal: 5.h),
                                          child: Text(
                                            "Reviews",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w800,
                                                fontSize: 18),
                                          ),
                                        ),
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
                                          height: 20.v,
                                        ),
                                      ],
                                    ),
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
                              key:_key3,
                              left: 14.h,
                              bottom: 5.v,
                              child: _buttonFloat(IconApp.mail, "message"))
                          : SizedBox(),
                      _showButtons
                          ? Positioned(
                              key:_key4,
                              right: 14.h,
                              bottom: 5.v,
                              child: _buttonFloat(IconApp.phone, "call"))
                          : SizedBox()
                    ],
                  ),
                ),
        ),


      ],
    );
  }

  @override
  void dispose() {
    tutorialCoachMark.finish();

    super.dispose();
  }

  void _submitReview(BuildContext context) async{

    if (Constant.login && Constant.type == 'user') {

      if (_editingController.text.isEmpty) {
        Scaffold.of(context).showSnackBar(SnackBar(content: Container(height: 5.v,child: Center(child : Text('please first fill text')),),),);
      }else{
        HomeApi.addComment(_editingController.text,home.id,context).then((value) {
          _editingController.clear();
          getData();
        });


      }
    }else{
      Scaffold.of(context).showSnackBar(SnackBar(content: Container(height: 5.v,child: Center(child : Text('just users can submit a comment')),),),);
    }

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
       String uri = 'tel:+1 '+agent.phone;
      if (await canLaunch(uri)) {
        await launch(uri);
      } else if (Platform.isIOS) {
        String uri = 'tel:'+agent.phone.replaceAll(" ", "-");
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
      String uri = 'sms:+'+agent.phone;
      if (await canLaunch(uri)) {
        await launch(uri);
      } else if (Platform.isIOS) {
        String uri = 'sms:00'+agent.phone.replaceAll(" ", "-");
        if (await canLaunch(uri)) {
          await launch(uri);
        } else {
          throw 'Could not launch $uri';
        }
      }
    }
  }


  void initTargets() {

    targets.add(
      TargetFocus(
        identify: "Target 1",
        keyTarget: _key1,
        color: ColorApp.blackColor,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            child: Container(
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Column(
                  children: [

                    Text(
                      "Once you set the filters, you can now choose the properties that are within the range of the options chosen. It will give you the details of the properties along with the actual picture and other informations.",
                      style: TextStyle(color: Colors.white,fontSize: 20),
                    ),

                  ],
                ),
              ),
            ),
          )
        ],
        shape: ShapeLightFocus.RRect,
        radius: 20,
      ),
    );
    targets.add(
      TargetFocus(
        identify: "Target 2",
        keyTarget: _key2,
        color: ColorApp.blackColor,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            child: Container(
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Column(
                  children: [

                    Text(
                      "It allows you to see the actual address and the location of the property along with the contact details of the agent",
                      style: TextStyle(color: Colors.white,fontSize: 20),
                    ),

                  ],
                ),
              ),
            ),
          )
        ],
        shape: ShapeLightFocus.RRect,
        radius: 20,
      ),
    );
    targets.add(
      TargetFocus(
        identify: "Target 3",
        keyTarget: _key3,
        color: ColorApp.blackColor,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            child: Container(
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Column(
                  children: [
                    Text(
                      "You can directly send message to the agent if you require additional information about the posted property.",
                      style: TextStyle(color: Colors.white,fontSize: 20),
                    ),

                  ],
                ),
              ),
            ),
          )
        ],
        shape: ShapeLightFocus.RRect,
        radius: 20,
      ),
    );
    targets.add(
      TargetFocus(
        identify: "Target 4",
        keyTarget: _key4,
        color: ColorApp.blackColor,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            child: Container(
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Column(
                  children: [
                    Text(
                      "Another option is you can call the directly the agent on the posted contact details.",
                      style: TextStyle(color: Colors.white,fontSize: 20),
                    ),

                  ],
                ),
              ),
            ),
          )
        ],
        shape: ShapeLightFocus.RRect,
        radius: 20,
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

      paddingFocus: 5,
      opacityShadow: 0.8,
      onSkip: (){

      },
      onClickOverlay: (target) {
        print('onClickOverlay: $target');
      },
      onClickTarget: (target) {
        _controller..animateTo(
          1000.h,
          curve: Curves.easeOut,
          duration: const Duration(milliseconds: 1000),
        );

        print('onClickTarget: $target');

      },
    )..show();
  }
}
