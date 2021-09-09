import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:realstatefrombegin3/model/NavigationProvider.dart';
import 'package:realstatefrombegin3/model/object/person.dart';
import 'package:realstatefrombegin3/sercives/base_service.dart';
import 'package:realstatefrombegin3/util/Constant.dart';
import 'package:realstatefrombegin3/values/color_app.dart';
import 'package:realstatefrombegin3/view/bottomNavigation/profile/main.dart';
import 'dart:ui' as ui;

import 'package:realstatefrombegin3/widget/custom/Colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

//todo edit with get data from bloc if user , comapny or agent
class ProfilePage extends StatefulWidget {

  static const String ADDRESS = 'profile/logined';

  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  bool _status = true;
  bool showCoache=false;
  bool isLoading=true;
  String name,emailId,phone,country,role,about,language,status,image;
  final FocusNode myFocusNode = FocusNode();
  Person p;

  @override
  void initState() {

    SharedPreferences.getInstance().then((prefs){
      if(!prefs.containsKey("showprofileafterlogincoach"))
      {
        setState((){
          showCoache=true;
        });
        prefs.setBool("showprofileafterlogincoach", false);
      }
      String token = prefs.getString('token');

      if (token != null && token != '') {

        patternAll(Constant.BASE_ADDRESS+"check_token",context,false,data: {'token': token}).then((res){
          role=res["role"];
          if(res['role'].toString().contains("user"))
            {
              name=res["user"]["Name"];
              emailId=res["user"]["Email"];
              phone=res["user"]["PhoneNumber"];
              image=res["user"]["Image"];
            }
          if(res['role'].toString().contains("agent"))
            {
              name=res["agent"]["name"];
              emailId=res["agent"]["email"];
              phone=res["agent"]["phone"];
              country=res["agent"]["country"];
              language=res["agent"]["languages"];
              image=res["agent"]["image"];
            }
          if(res['role'].toString().contains("company"))
            {
              name=res["company"]["name"];
              emailId=res["company"]["email"];
              about=res["company"]["about"];
              status=res["company"]["status"];
              image=res["company"]["image"];
            }
          setState(() {
            isLoading=false;
          });

        });




      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: isLoading?Center(child: CircularProgressIndicator(),):Stack(
        children: [
          new Scaffold(
              body: new Container(
                color: Colors.white,
                child: new ListView(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(child:SizedBox()),
                              InkWell(
                                  onTap:(){
                                      Constant.login=false;
                                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ProfileMainPage(),));
                                      SharedPreferences.getInstance().then((preferences) {
                                        preferences.setString("token", '');

                                      });
                                      final myModel = Provider.of<NavigationProviderModel>(context, listen: false);
                                      myModel.changeIndex(3);
                                      myModel.changeIndex(4);
                                  },
                                  child: Icon(Icons.logout)),
                            ],
                          ),
                        ),
                        new Container(
                          height: 250.0,
                          color: Colors.white,
                          child: new Column(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(top: 50.0),
                                child: new Stack(fit: StackFit.loose, children: <Widget>[
                                  new Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      new Container(
                                          width: 140.0,
                                          height: 140.0,
                                          decoration: new BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(image:  (image==null)
                                                ? AssetImage(
                                                Constant.IMAGE_ADDRESS + "person.png")
                                                : NetworkImage(
                                                Constant.BASE_IMAGE_ADDRESS + image), fit: BoxFit.cover),
                                          )),
                                    ],
                                  ),
                                  /*Padding(
                                      padding: EdgeInsets.only(top: 90.0, right: 100.0),
                                      child: new Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          new CircleAvatar(
                                            backgroundColor: ColorApp.primaryColor,
                                            radius: 25.0,
                                            child: new Icon(
                                              Icons.camera_alt,
                                              color: Colors.white,
                                            ),
                                          )
                                        ],
                                      )),*/
                                ]),
                              )
                            ],
                          ),
                        ),
                        new Container(
                          color: Color(0xffFFFFFF),
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 25.0),
                            child: new Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 25.0, right: 25.0, top: 25.0),
                                    child: new Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        new Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            new Text(
                                              'Parsonal Information',
                                              style: TextStyle(
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        /*new Column(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            _status ? _getEditIcon() : new Container(),
                                          ],
                                        )*/
                                      ],
                                    )),
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 25.0, right: 25.0, top: 25.0),
                                    child: new Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        new Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            new Text(
                                              'Name',
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )),
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 25.0, right: 25.0, top: 2.0),
                                    child: new Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        new Flexible(
                                          child: new TextFormField (
                                            initialValue:name,
                                            enabled: !_status,
                                            autofocus: !_status,

                                          ),
                                        ),
                                      ],
                                    )),
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 25.0, right: 25.0, top: 25.0),
                                    child: new Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        new Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            new Text(
                                              'Email ID',
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )),
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 25.0, right: 25.0, top: 2.0),
                                    child: new Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        new Flexible(
                                          child: new TextFormField (
                                            initialValue:emailId,
                                           /* decoration: InputDecoration(
                                                hintText: (p != null && p.email != null) ? p.email :"Enter Email ID" ),*/
                                            enabled: !_status,
                                          ),
                                        ),
                                      ],
                                    )),
                                role.contains("company")?SizedBox():Padding(
                                    padding: EdgeInsets.only(
                                        left: 25.0, right: 25.0, top: 25.0),
                                    child: new Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        new Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            new Text(
                                              'Mobile',
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )),
                                role.contains("company")?SizedBox():Padding(
                                    padding: EdgeInsets.only(
                                        left: 25.0, right: 25.0, top: 2.0),
                                    child: new Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        new Flexible(
                                          child: new TextFormField (
                                            initialValue:phone,
                                            /*decoration: const InputDecoration(
                                                hintText: "Enter Mobile Number"),*/
                                            enabled: !_status,
                                          ),
                                        ),
                                      ],
                                    )),
                                role.contains("user")?SizedBox():Padding(
                                    padding: EdgeInsets.only(
                                        left: 25.0, right: 25.0, top: 25.0),
                                    child: new Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        new Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            new Text(
                                              role.contains("agent")?'Country':'About',
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )),
                                role.contains("user")?SizedBox():Padding(
                                    padding: EdgeInsets.only(
                                        left: 25.0, right: 25.0, top: 2.0),
                                    child: new Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        new Flexible(
                                          child: new TextFormField (
                                            initialValue:role.contains("agent")?country:about,
                                           /* decoration: const InputDecoration(
                                                hintText: "Enter Mobile Number"),*/
                                            enabled: !_status,
                                          ),
                                        ),
                                      ],
                                    )),

                                role.contains("user")?SizedBox():Padding(
                                    padding: EdgeInsets.only(
                                        left: 25.0, right: 25.0, top: 25.0),
                                    child: new Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        new Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            new Text(
                                              role.contains("agent")?'Language':'Status',
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )),
                                role.contains("user")?SizedBox():Padding(
                                    padding: EdgeInsets.only(
                                        left: 25.0, right: 25.0, top: 2.0),
                                    child: new Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        new Flexible(
                                          child: new TextFormField (
                                            initialValue:role.contains("agent")?language:status,

                                            enabled: !_status,
                                          ),
                                        ),
                                      ],
                                    )),
                                /*Padding(
                                    padding: EdgeInsets.only(
                                        left: 25.0, right: 25.0, top: 25.0),
                                    child: new Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Expanded(
                                          child: Container(
                                            child: new Text(
                                              'Pin Code',
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          flex: 2,
                                        ),
                                        Expanded(
                                          child: Container(
                                            child: new Text(
                                              'State',
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          flex: 2,
                                        ),
                                      ],
                                    )),
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 25.0, right: 25.0, top: 2.0),
                                    child: new Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Flexible(
                                          child: Padding(
                                            padding: EdgeInsets.only(right: 10.0),
                                            child: new TextFormField (
                                              decoration: const InputDecoration(
                                                  hintText: "Enter Pin Code"),
                                              enabled: !_status,
                                            ),
                                          ),
                                          flex: 2,
                                        ),
                                        Flexible(
                                          child: new TextFormField (
                                            decoration: const InputDecoration(
                                                hintText: "Enter State"),
                                            enabled: !_status,
                                          ),
                                          flex: 2,
                                        ),
                                      ],
                                    )),*/
                                !_status ? _getActionButtons() : new Container(),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              )),
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
                          "To register you need to fill up the personal information and there is an option to upload a profile picture as well",
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

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myFocusNode.dispose();
    super.dispose();
  }

  Widget _getActionButtons() {
    return Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Container(
                  child: new RaisedButton(
                    child: new Text("Save"),
                    textColor: Colors.white,
                    color: Colors.green,
                    onPressed: () {
                      setState(() {
                        _status = true;
                        FocusScope.of(context).requestFocus(new FocusNode());
                      });
                    },
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0)),
                  )),
            ),
            flex: 2,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Container(
                  child: new RaisedButton(
                    child: new Text("Cancel"),
                    textColor: Colors.white,
                    color: ColorApp.primaryColor,
                    onPressed: () {
                      setState(() {
                        _status = true;
                        FocusScope.of(context).requestFocus(new FocusNode());
                      });
                    },
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0)),
                  )),
            ),
            flex: 2,
          ),
        ],
      ),
    );
  }

  Widget _getEditIcon() {
    return new GestureDetector(
      child: new CircleAvatar(
        backgroundColor: ColorApp.primaryColor,
        radius: 14.0,
        child: new Icon(
          Icons.edit,
          color: Colors.white,
          size: 16.0,
        ),
      ),
      onTap: () {
        setState(() {
          _status = false;
        });
      },
    );
  }
}