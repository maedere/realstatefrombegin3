import 'package:flutter/material.dart';
import 'package:realstatefrombegin3/util/Constant.dart';
import 'package:realstatefrombegin3/view/bottomNavigation/home/map.dart';

import 'package:realstatefrombegin3/view/bottomNavigation/profile/loginPage.dart';
import 'package:realstatefrombegin3/view/bottomNavigation/profile/main.dart';
import 'package:realstatefrombegin3/view/bottomNavigation/profile/profile_after_login.dart';
import 'package:realstatefrombegin3/view/bottomNavigation/profile/signup.dart';

class BasePageProfile extends StatelessWidget{

   final GlobalKey<NavigatorState> keyNav;


   BasePageProfile(this.keyNav);

  @override
  Widget build(BuildContext context) {

    return Navigator(
      key: keyNav,
      initialRoute: (Constant.login)?ProfilePage.ADDRESS:ProfileMainPage.ADDRESS,
      onPopPage: (route, result) {
            return true;
      },
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case ProfileMainPage.ADDRESS:
            builder = (BuildContext _) => ProfileMainPage();
            break;
          case LoginPage.ADDRESS:
            builder = (BuildContext _) => LoginPage();
            break;
          case SignUpPage.ADDRESS:
            builder = (BuildContext _) => SignUpPage();
            break;
          case ProfilePage.ADDRESS:
            builder = (BuildContext _) => ProfilePage();
            break;
          /*case ProfilePage.ADDRESS:
            builder = (BuildContext _) => ProfilePage();
            break;
          case FormPage.ADDRESS:
            builder = (BuildContext _) => FormPage(type: Constant.type);
            break;
          case ListDataPage.ADDRESS:
            builder = (BuildContext _) => ListDataPage();
            break;
          case FavoritePage.BASE_ADDRESS:
            builder = (BuildContext _) => FavoritePage();
            break;*/
          case MapPage.ADDRESS:
            builder = (BuildContext _) => MapPage(type: 2,);
            break;
          default:
            throw Exception('Invalid route: ${settings.name}');
        }
        return MaterialPageRoute(builder: builder, settings: settings);
      },
    );
  }

  changePage({@required String address , bool replace = false ,  Object arguments }){
    if(replace) keyNav.currentState.pushReplacementNamed(address , arguments: arguments);
        else  keyNav.currentState.pushNamed(address , arguments: arguments);
  }

    bool canPop(){
   return keyNav.currentState.canPop();
  }

   pop(){
    keyNav.currentState.pop();
  }

}