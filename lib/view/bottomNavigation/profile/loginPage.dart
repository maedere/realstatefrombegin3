import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realstatefrombegin3/model/NavigationProvider.dart';
import 'package:realstatefrombegin3/sercives/authenticationApi.dart';
import 'package:realstatefrombegin3/values/color_app.dart';
import 'package:realstatefrombegin3/view/bottomNavigation/profile/profile_after_login.dart';
import 'package:realstatefrombegin3/view/bottomNavigation/profile/signup.dart';
import 'package:realstatefrombegin3/widget/custom/Colors.dart';
import 'package:realstatefrombegin3/widget/custom/bezierContainer.dart';
import 'package:realstatefrombegin3/util/size_config.dart';

import 'package:http/http.dart' as http;
import 'package:realstatefrombegin3/widget/custom/button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class LoginPage extends StatefulWidget {
  static const String ADDRESS = 'profile/login';

  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _loading = false;

  TutorialCoachMark tutorialCoachMark;
  List<TargetFocus> targets = [];
  GlobalKey  _key1 = GlobalKey();
  GlobalKey  _key2 = GlobalKey();

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

 /* _loginProcess(BuildContext context) async {

    setState(() {
      _loading = true;
    });

    final Map<String, dynamic> data = {
      'role': typUser,
      'email': emailController.text.trim(),
      'password': passController.text.trim(),
    };

    final http.Response res =
        await http.post(Constant.BASE_ADDRESS_ADMIN + 'login', body: data);
    try {
      if (Tools.checkResponse(res)) {
       Constant.login = true;
        Map<String, dynamic> response = json.decode(res.body);
        Constant.type = response['role'];
        switch (Constant.type) {
          case 'company':
            Constant.token = response['company']['token'];
            //todo fill company
            BlocProvider.of<UserBloc>(context).add(UserLoginRequestEvent(user: Company.fromJson(response['company'])));
            break;
          case 'agent':
            Constant.token = response['agent']['token'];
            //todo fill agent
            BlocProvider.of<UserBloc>(context).add(UserLoginRequestEvent(user: Agent.fromJson(response['agent'])));
            break;
          case 'user':
            Constant.token = response['user']['token'];
            //todo fill user
            BlocProvider.of<UserBloc>(context).add(UserLoginRequestEvent(user: Company.fromJson(response['user'])));
            break;
        }

        BlocProvider.of<RouteBloc>(context).add(RouteChangePageEvent(address: ProfilePage.ADDRESS));
      }
    } catch (e) {
      setState(() {
        _loading = false;
      });
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Container(
            height: 50,
            child: Center(
              child: Text(e.toString()),
            ),
          ),
        ),
      );
    }
  }*/

  String typUser = 'company';

  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
            ),
            Text('Back',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

  Widget _entryField(String title, TextEditingController controller,{bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.only(left: 7,right: 7),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 12.h,
              child: TextField(
                controller: controller,
                  obscureText: isPassword,
                  decoration: InputDecoration(

                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          )
                      ),
                      fillColor: Color(0xfff3f3f4),
                      filled: true)),
            )
          ],
        ),
      ),
    );
  }

  Widget _submitButton() {
    return

      CustomButtonBig(child: _loading
          ? SizedBox(height:4.h,width:4.h,child: CircularProgressIndicator(strokeWidth: .5,valueColor: AlwaysStoppedAnimation<Color>(Colors.white)))
          :Text('Login' , style: TextStyle(color: Colors.white),),color: ColorApp.primaryColor ,clickCallback:(){
        setState(() {
          _loading=true;
        });
        AuthenticationApi.login(typUser, emailController.text.trim(), passController.text.trim(),context).then((value) {
          setState(() {
            _loading=false;
          });
          if(value=="ok")
          {
            Navigator.pop(context);
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ProfilePage(),));
            final myModel = Provider.of<NavigationProviderModel>(context, listen: false);
            myModel.changeIndex(3);
            myModel.changeIndex(4);

          }

        });
      });

        /*Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.shade200,
                  offset: Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [ColorApp.accentColor, ColorApp.primaryColor])),
        child: _loading
            ? CircularProgressIndicator(strokeWidth: .5,)
            : Text(
                'Login',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
      ),*/

  }

  Widget _divider() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          Text('or'),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }

  Widget _facebookButton() {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.red[400],
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(5),
                    topLeft: Radius.circular(5)),
              ),
              alignment: Alignment.center,
              child: Text('G',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w400)),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.red[400],
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(5),
                    topRight: Radius.circular(5)),
              ),
              alignment: Alignment.center,
              child: Text('Log in with Google',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w400)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _createAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => SignUpPage()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Don\'t have an account ?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Register',
              style: TextStyle(
                  color: ColorApp.accentColor,
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'Real ',
          style: TextStyle(
            fontFamily: 'Righteous',
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: ColorApp.accentColor,
          ),
          children: [
            TextSpan(
              text: 'E',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
            TextSpan(
              text: 'state',
              style: TextStyle(color: ColorApp.primaryColor, fontSize: 30),
            ),
          ]),
    );
  }

  Widget _emailPasswordWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 7,right: 7),
      child: Column(

        children: <Widget>[
          Column(
            key:_key1,
            children: [
              _entryField("Email id" , emailController),
              _entryField("Password", passController , isPassword: true),

            ],
          ),
          SizedBox(
            height: 8.h,
          ),
          Container(
            height: 12.h,
            width: 47.v,
            decoration: BoxDecoration(
              color: Color(0xfff3f3f4),
              borderRadius: BorderRadius.circular(30)
            ),
            child:  Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(

                  value: typUser,
                  isDense: true,
                  onChanged: (String newValue) {
                    setState(() {
                      typUser = newValue;
                    });
                  },
                  items: <DropdownMenuItem<String>>[
                    DropdownMenuItem(
                      child: SizedBox(
                          child: Text('Company')),
                      value: 'company',
                    ),
                    DropdownMenuItem(
                      child: Text('Agent'),
                      value: 'agent',
                    ),
                    DropdownMenuItem(
                      child: Text('User'),
                      value: 'user',
                    ),
                  ],
                ),
              ),
            ),
/*
            DropdownButtonFormField(
              key: _key2,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      )
                  ),
                  fillColor: Color(0xfff3f3f4),
                  filled: true),
              value: typUser,
              items: <DropdownMenuItem<String>>[
                DropdownMenuItem(
                  child: SizedBox(
                      child: Text('Company')),
                  value: 'company',
                ),
                DropdownMenuItem(
                  child: Text('Agent'),
                  value: 'agent',
                ),
                DropdownMenuItem(
                  child: Text('User'),
                  value: 'user',
                ),
              ],
              onChanged: (value) {
                typUser = value;
              },

            ),
*/
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    SharedPreferences.getInstance().then((prefs){
      if(!prefs.containsKey("showlogincoach"))
      {
        initTargets();
        WidgetsBinding.instance.addPostFrameCallback((_) async{

          showTutorial();

        });
        prefs.setBool("showlogincoach", false);
      }
    });

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
      height: height,
      child: Stack(
        children: <Widget>[
          Positioned(
              top: -height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              child: BezierContainer()),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: height * .2),
                  _title(),
                  SizedBox(height: 50),
                  _emailPasswordWidget(),
                  SizedBox(height: 20),
                  _submitButton(),
                 /* Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    alignment: Alignment.centerRight,
                    child: Text('Forgot Password ?',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500)),
                  ),*/
             //     _divider(),
          //        _facebookButton(),
                  SizedBox(height: height * .055),
                  _createAccountLabel(),
                ],
              ),
            ),
          ),
          Positioned(top: 40, left: 0, child: _backButton()),
        ],
      ),
    ));
  }

  void initTargets() {

    targets.add(
      TargetFocus(
        identify: "Target 1",
        keyTarget: _key1,
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
                      "To LOG-IN You can put the necessary details required",
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
        identify: "Target 1",
        keyTarget: _key2,
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
                      "There is also an option wherein you can log as either of the following:",
                      style: TextStyle(color: Colors.white,fontSize: 20),
                    ),
                    ListTile(
                      leading: Icon(Icons.arrow_right_sharp,color: Colors.white,size: 40,),
                      title: Text("COMPANY", style: TextStyle(color: Colors.white,fontSize: 20),),
                    ),
                    ListTile(
                      leading: Icon(Icons.arrow_right_sharp,color: Colors.white,size: 40,),
                      title: Text("AGENT", style: TextStyle(color: Colors.white,fontSize: 20),),
                    ),
                    ListTile(
                      leading: Icon(Icons.arrow_right_sharp,color: Colors.white,size: 40,),
                      title: Text("USER", style: TextStyle(color: Colors.white,fontSize: 20),),
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
