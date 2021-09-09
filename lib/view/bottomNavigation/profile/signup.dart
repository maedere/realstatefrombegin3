import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realstatefrombegin3/model/NavigationProvider.dart';

import 'package:realstatefrombegin3/model/object/agent.dart';
import 'package:realstatefrombegin3/model/object/company.dart';
import 'package:realstatefrombegin3/model/object/user.dart';
import 'package:realstatefrombegin3/sercives/authenticationApi.dart';
import 'package:realstatefrombegin3/util/Constant.dart';
import 'package:realstatefrombegin3/util/Tools.dart';
import 'package:realstatefrombegin3/values/color_app.dart';
import 'package:realstatefrombegin3/view/bottomNavigation/profile/loginPage.dart';
import 'package:realstatefrombegin3/view/bottomNavigation/profile/profile_after_login.dart';
import 'package:realstatefrombegin3/widget/custom/Colors.dart';
import 'package:realstatefrombegin3/widget/custom/bezierContainer.dart';
import 'package:http/http.dart' as http;
import 'package:realstatefrombegin3/widget/custom/button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'package:realstatefrombegin3/util/size_config.dart';

class SignUpPage extends StatefulWidget {
  static const String ADDRESS = 'profile/sign_up';

  SignUpPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  String typUser = 'company';
  bool _loading = false;

  TutorialCoachMark tutorialCoachMark;
  List<TargetFocus> targets = [];
  GlobalKey  _key1 = GlobalKey();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();

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

  Widget _entryField(String title,TextEditingController controller, {bool isPassword = false}) {
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
                      ),                  fillColor: Color(0xfff3f3f4),
                      filled: true)),
            )
          ],
        ),
      ),
    );
  }

  Widget _submitButton(BuildContext context) {
    return
      CustomButtonBig(child: _loading
          ? SizedBox(height:4.h,width: 4.h,child: CircularProgressIndicator(strokeWidth: .5,valueColor: AlwaysStoppedAnimation<Color>(Colors.white)))
          :Text('Register Now' , style: TextStyle(color: Colors.white),),color: ColorApp.primaryColor ,
          clickCallback:(){
              if(emailController.text.isNotEmpty && passwordController.text.isNotEmpty && phoneController.text.isNotEmpty && nameController.text.isNotEmpty)
              {setState(() {
                _loading=true;
              });
              AuthenticationApi.singUp(typUser, emailController.text.trim(), passwordController.text.trim(),phoneController.text.trim(),nameController.text.trim(),context).then((value) {
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

              });}
              else{
                Scaffold.of(context).showSnackBar(SnackBar(content: Container(height: 5.v,child: Center(child : Text("Please enter all items")),),),);

              }
          });
  }

  Widget _loginAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Already have an account ?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Login',
              style: TextStyle(
                  color: Color(0xfff79c4f),
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
    return Column(
      children: <Widget>[
        Column(
          key: _key1,
          children: [
            _entryField("Email id" , emailController),
            _entryField("Password",passwordController, isPassword: true),

          ],
        ),
        _entryField("Name" , nameController),
        _entryField("Phone Number" , phoneController),
        SizedBox(
          height: 8.h,
        ),
        Container(
          height: 12.h,
          width: 48.v,
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
                    child: Text('User'),
                    value: 'user',
                  ),
                ],
              ),
            ),
          ))

      ],
    );
  }

  @override
  void initState() {
    SharedPreferences.getInstance().then((prefs){
      if(!prefs.containsKey("showregistercoach"))
      {
        initTargets();
        WidgetsBinding.instance.addPostFrameCallback((_) async{

          showTutorial();

        });
        prefs.setBool("showregistercoach", false);
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
              top: -MediaQuery.of(context).size.height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              child: BezierContainer(),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: height * .2),
                    _title(),
                    SizedBox(
                      height: 50,
                    ),
                    _emailPasswordWidget(),
                    SizedBox(
                      height: 20,
                    ),
                    _submitButton(context),
                    SizedBox(height: height * .14),
                    _loginAccountLabel(),
                  ],
                ),
              ),
            ),
            Positioned(top: 40, left: 0, child: _backButton()),
          ],
        ),
      ),
    );
  }

 /* _register(BuildContext context) async {

    setState(() {
      _loading = true;
    });

    final Map<String, dynamic> data = {
      'role': typUser,
      'email': emailController.text.trim(),
      'password': passwordController.text.trim(),
      'phone' : phoneController.text,
      'name' : nameController.text
    };

    final http.Response res =
    await http.post(Constant.BASE_ADDRESS + 'register', body: data);
    try {
      if (Tools.checkResponse(res)) {
        Constant.login = true;
        Map<String, dynamic> response = json.decode(res.body);
        Constant.type = response['role'];
        SharedPreferences preferences = await SharedPreferences.getInstance();
        switch (Constant.type) {
          case 'company':
            Constant.token = response['company']['token'];
            await preferences.setString('token',response['company']['token']);
            //todo fill company
            BlocProvider.of<UserBloc>(context).add(UserLoginRequestEvent(user: Company.fromJson(response['company'])));
            break;
          case 'agent':
            Constant.token = response['agent']['token'];
          await  preferences.setString('token', response['agent']['token']);
            //todo fill agent
            BlocProvider.of<UserBloc>(context).add(UserLoginRequestEvent(user: Agent.fromJson(response['agent'])));
            break;
          case 'user':
            Constant.token = response['user']['token'];
            await  preferences.setString('token',response['user']['token']);
            //todo fill user
            BlocProvider.of<UserBloc>(context).add(UserLoginRequestEvent(user: User.fromJson(response['user'])));
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
                padding: const EdgeInsets.only(top: 50.0),
                child: Column(
                  children: [

                    Text(
                      "TO REGISTER You can put the necessary details required as usual.",
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
