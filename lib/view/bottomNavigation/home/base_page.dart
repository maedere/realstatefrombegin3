import 'package:flutter/material.dart';
import 'package:realstatefrombegin3/view/bottomNavigation/home/detail.dart';
import 'package:realstatefrombegin3/view/bottomNavigation/home/filter.dart';
import 'package:realstatefrombegin3/view/bottomNavigation/home/main.dart';
import 'package:realstatefrombegin3/view/bottomNavigation/home/map.dart';

class BasePageHome extends StatelessWidget{

   final GlobalKey<NavigatorState> keyNav;
   BasePageHome(this.keyNav);

  @override
  Widget build(BuildContext context) {

    return Navigator(
      key: keyNav,
      initialRoute: HomeMainPage.ADDRESS,
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case HomeMainPage.ADDRESS:
            builder = (BuildContext _) => HomeMainPage();
            break;
          case DetailHomePage.ADDRESS:
            builder = (BuildContext _) => DetailHomePage(settings.arguments);
            break;
          case FilterHomePage.ADDRESS:
            builder = (BuildContext _) => FilterHomePage();
            break;
          case MapPage.ADDRESS:
            builder = (BuildContext _) => MapPage(type: 0,);
            break;
          default:
            throw Exception('Invalid route: ${settings.name}');
        }
        return MaterialPageRoute(builder: builder, settings: settings);
      },
    );
  }

  changePage({@required String address , bool replace = false ,  Object arguments }){
  /*  if(replace) keyNav.currentState.pushReplacementNamed(address , arguments: arguments);
    else */ keyNav.currentState.pushNamed(address , arguments: arguments);
  }

    bool canPop(){
   return keyNav.currentState.canPop();
  }

   pop(){
    keyNav.currentState.pop();
  }

}