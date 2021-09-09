import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:realstatefrombegin3/model/object/comment.dart';
import 'package:realstatefrombegin3/model/object/hotel.dart';
import 'package:realstatefrombegin3/model/object/person.dart';
import 'package:realstatefrombegin3/sercives/hotelApi.dart';
import 'package:realstatefrombegin3/util/Constant.dart';
import 'package:realstatefrombegin3/util/Tools.dart';
import 'package:realstatefrombegin3/util/size_config.dart';
import 'package:realstatefrombegin3/values/color_app.dart';
import 'package:realstatefrombegin3/values/icon_app_icons.dart';
import 'package:realstatefrombegin3/view/bottomNavigation/hotel/suite.dart';
import 'package:realstatefrombegin3/view/bottomNavigation/profile/fav_page.dart';
import 'package:realstatefrombegin3/widget/custom/Colors.dart';
import 'package:realstatefrombegin3/widget/item/comment.dart';
import 'package:realstatefrombegin3/widget/item/extra_hotel_item.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import 'package:http/http.dart' as http;
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'dart:ui' as ui;

class DetailHotelPage extends StatefulWidget {
  static const String ADDRESS = "hotel/detail";
  final String id;
  final String startDate,endDate;

  DetailHotelPage({this.id, this.startDate, this.endDate});

  @override
  _DetailHotelPageState createState() => _DetailHotelPageState();
}

class _DetailHotelPageState extends State<DetailHotelPage> {
  Hotel hotel;
  String mapStyle = "";
  GoogleMapController _controller;

  MiniHotel miniHotel;

  bool _showButton = true;
  FocusNode _focusNode;
  TextEditingController _textEditingController;

  String startDate="",endDate="";
  List<Comment> comments = [];

  TutorialCoachMark tutorialCoachMark;
  List<TargetFocus> targets = [];

  GlobalKey  _key1 = GlobalKey();
  ScrollController _scrollController;

  DateRangePickerController _dateRangePickerController= DateRangePickerController();
  bool showCoache=false;

  Set<Marker> mark = Set();

  getData() async {


    final value=await HotelApi.singleHotel(widget.id,context);

    setState(() {
      hotel=value[0];
      comments=value[1];
    });

    if(!hotel.lat.contains("null") && !hotel.lng.contains("null"))
          mark.add(Marker(
            markerId: MarkerId(hotel.id.toString()),
            position: LatLng(double.parse(hotel.lat), double.parse(hotel.lng))));
    miniHotel = new MiniHotel(
        images: hotel.images,
        level: hotel.level,
        id: hotel.id,
        name: hotel.name,);

    setState(() {
      Constant.favorites.contains(miniHotel) ? fav =true : fav = false;
    });

    SharedPreferences.getInstance().then((prefs){
      if(!prefs.containsKey("showdetailhotelcoach"))
      {
        initTargets();
        WidgetsBinding.instance.addPostFrameCallback((_) async{

          showTutorial();

        });
        prefs.setBool("showdetailhotelcoach", false);
      }
    });
  }

  bool fav = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs){
      if(!prefs.containsKey("showdetailhotelcoach"))
      {
        _scrollController=ScrollController(initialScrollOffset: 1000);
      }
    });

    _textEditingController = TextEditingController();

    _focusNode = FocusNode()
      ..addListener(() {
        if (_focusNode.hasFocus) {
          _showButton = false;
        } else {
          _showButton = true;
        }
        setState(() {});
      });

    getData();

    rootBundle
        .loadString('assets/style/map_style.txt')
        .then((value) => mapStyle = value);
  }

  @override
  Widget build(BuildContext context) {
    if(Constant.pop)
    {
      Navigator.pop(context);
      Constant.pop=false;
    }
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: hotel == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
              },
              child: Stack(
                children: [
                  CustomScrollView(
                    controller: _scrollController,

                    slivers: <Widget>[
                      SliverAppBar(
                        backgroundColor: Colors.white,
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
                                Tools.editFavorite(miniHotel, fav);
                              });
                            },
                            child: Icon(IconApp.favorite,
                                size: 20,
                                color: fav ? Colors.redAccent : Colors.white),
                          ),
                        ],
                        flexibleSpace: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: hotel.images.length==0
                                      ? AssetImage(
                                          Constant.IMAGE_ADDRESS + "h5.jpg")
                                      : NetworkImage(
                                          Constant.BASE_IMAGE_ADDRESS +
                                              hotel.images[0]))),
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
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.h),
                                    child: Text(
                                      hotel.name,
                                      style: TextStyle(fontSize: 22),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.h),
                                    child: RatingBar.builder(
                                      onRatingUpdate: null,
                                      itemSize: 18,
                                      itemCount: 5,
                                      itemBuilder: (context, index) {
                                        return Icon(
                                          IconApp.star,
                                          color: Colors.yellow[600],
                                        );
                                      },
                                      initialRating: hotel.level.toDouble(),
                                      allowHalfRating: true,
                                      itemPadding:
                                          EdgeInsets.symmetric(horizontal: 3),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.v,
                                  ),
                                  Padding(
                                    padding:
                                    EdgeInsets.symmetric(horizontal: 5.h),
                                    child: Text(
                                      hotel.description,
                                      style: TextStyle(fontFamily: "long"),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.v,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.h),
                                    child: Row(
                                      children: [],
                                    ),
                                  ),
                                  //list horizontal az custom widget
                                  SizedBox(
                                    height: 8.v,
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
                                              "City: "+hotel.city,
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
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.h),
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: [
                                          if(hotel.restaurant)
                                            ExtraHotelItem(
                                            icon: Icons.restaurant,
                                            name: "restaurant",
                                          ),
                                          if(hotel.cafe)
                                            ExtraHotelItem(
                                            icon: IconApp.cafe,
                                            name: "cafe",
                                          ),
                                          if(hotel.restaurant)
                                            ExtraHotelItem(
                                            icon: Icons.local_parking,
                                            name: "parking",
                                          ),
                                          if(hotel.pool)
                                            ExtraHotelItem(
                                            icon: Icons.pool,
                                            name: "pool",
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
                                    title: Text(hotel.address,style: TextStyle(fontSize: Constant.fontSize/1.5),),
                                  ),
                                  Container(
                                    key: _key1,
                                    height: 22.v,
                                    width: double.infinity,
                                    child: GoogleMap(

                                      initialCameraPosition: CameraPosition(
                                        target: LatLng(
                                          double.parse(hotel.lat.contains("null")?'10.1':hotel.lat),
                                          double.parse(hotel.lng.contains("null")?'10.1':hotel.lng),
                                        ),
                                      ),
                                      onMapCreated: (controller) {
                                        _controller = controller;
                                        _controller.setMapStyle(mapStyle);
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
                                          controller: _textEditingController,
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
                            );
                          },
                          childCount: 1,
                        ),
                      ),
                    ],
                  ),
                  _showButton
                      ? Align(
                          alignment: AlignmentDirectional.bottomCenter,
                          child: GestureDetector(
                            onTap: () {
                              if(widget.startDate!=null && widget.endDate!=null )
                                Navigator.push(context,MaterialPageRoute(builder: (context)=>SuitesPage(startDate: widget.startDate,endDate: widget.endDate,hotelId: hotel.id.toString(),)));
                              else {
                                SharedPreferences.getInstance().then((prefs){
                                if(!prefs.containsKey("showchoosedatecoach"))
                                {
                                  setState(() {
                                    showCoache=true;
                                  });
                                  prefs.setBool("showchoosedatecoach", false);
                                }
                              });
                              showDialog(

                                  context: context,
                                  builder: (context) {
                                    return StatefulBuilder(
                                        builder: (context, myState) {
                                          return
                                                  Scaffold(
                                                    appBar: AppBar(
                                                      iconTheme: IconThemeData(
                                                        color: Colors.black, //change your color here
                                                      ),
                                                      backgroundColor: Colors.white,
                                                      elevation: 0,
                                                      centerTitle: true,
                                                    ),
                                                    body: Container(
                                              width: 200.h,
                                              height: 100.v,
                                              color: Colors.white,
                                              child: Stack(
                                                children: [
                                                    Column(
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: [
                                                        Container(
                                                          height: 70.v,
                                                          padding: EdgeInsets.symmetric(
                                                              vertical: 10.v,
                                                              horizontal: 5.h),
                                                          child: SfDateRangePicker(
                                                            controller: _dateRangePickerController,
                                                            view: DateRangePickerView.month,
                                                            monthViewSettings:
                                                                DateRangePickerMonthViewSettings(
                                                                    firstDayOfWeek: 1),
                                                            rangeSelectionColor: ColorApp
                                                                .primaryColor
                                                                .withOpacity(.4),
                                                            selectionMode:
                                                                DateRangePickerSelectionMode
                                                                    .range,
                                                            onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {

                                                              myState(() {
                                                                if (args.value is PickerDateRange) {

                                                                  setState(() {
                                                                    startDate=args.value.startDate.toString();
                                                                    endDate=args.value.endDate.toString();
                                                                  });

                                                                }
                                                              });
                                                            },

                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        IgnorePointer(
                                                          ignoring:    !(startDate.contains("-") && endDate.contains("-")),
                                                          child: FlatButton(
                                                            onPressed: (){

                                                              Navigator.push(context,MaterialPageRoute(builder: (context)=>SuitesPage(startDate: startDate,endDate: endDate,hotelId: hotel.id.toString(),)));

                                                            },
                                                            child: Container(
                                                              width: 20.v,
                                                              margin: EdgeInsets.symmetric(
                                                                  horizontal: 3.h, vertical: 1.v),
                                                              height: 6.v,
                                                              padding: EdgeInsets.symmetric(vertical: 2.v),
                                                              child: Center(
                                                                child: Text(
                                                                  "select",
                                                                  style: TextStyle(
                                                                      color: Colors.white, fontSize: 16),
                                                                ),
                                                              ),
                                                              decoration: BoxDecoration(
                                                                color: (startDate.contains("-") && endDate.contains("-"))?ColorApp.primaryColor:Colors.grey,

                                                                borderRadius:
                                                                BorderRadius.all(Radius.circular(30)),
                                                              ),
                                                            )

                                                          ),
                                                        ),
                                                        ],
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
                                                                    "Choose the desired dates of you stay.",
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
                                                                      myState((){});

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
                                                    ):SizedBox(),


                                                ],
                                              ),
                                            ),
                                                  );}
                                    );
                                  });
                              }
                            },
                            child: Constant.login?Container(
                              width: double.infinity,
                              margin: EdgeInsets.symmetric(
                                  horizontal: 3.h, vertical: 1.v),
                              height: 8.v,
                              padding: EdgeInsets.symmetric(vertical: 2.v),
                              child: Center(
                                child: Text(
                                  "select suites",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ),
                              decoration: BoxDecoration(
                                color: ColorApp.primaryColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                              ),
                            ):SizedBox(),
                          ),
                        )
                      : SizedBox(),
                ],
              ),
            ),
    );
  }

  void _submitReview(BuildContext context) async {
    if (Constant.login && Constant.type == 'user') {
      if (_textEditingController.text.isEmpty) {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Container(
              height: 5.v,
              child: Center(child: Text('please first fill text')),
            ),
          ),
        );
      } else {
        HotelApi.addComment(_textEditingController.text,hotel.id,context).then((value) {
          _textEditingController.clear();
          getData();
        });
      }
    } else {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Container(
            height: 5.v,
            child: Center(child: Text('just users can submit a comment')),
          ),
        ),
      );
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
                padding: const EdgeInsets.only(top: 30.0),
                child: Column(
                  children: [

                    Text(
                      "You can view the location of the hotel in a Goggle map. It also shows the hotel amenities and other details.",
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

        print('onClickTarget: $target');

      },
    )..show();
  }
}
