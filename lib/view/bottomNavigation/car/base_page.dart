import 'package:flutter/material.dart';
import 'package:realstatefrombegin3/view/bottomNavigation/car/detail.dart';
import 'package:realstatefrombegin3/view/bottomNavigation/car/filter.dart';
import 'package:realstatefrombegin3/view/bottomNavigation/car/main.dart';
import 'package:realstatefrombegin3/view/bottomNavigation/home/map.dart';

class BasePageCar extends StatelessWidget{

  final GlobalKey<NavigatorState> keyNav;


  BasePageCar(this.keyNav);

  @override
  Widget build(BuildContext context) {

    return Navigator(
      key: keyNav,
      initialRoute: CarMainPage.ADDRESS,
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case CarMainPage.ADDRESS:
            builder = (BuildContext _) => CarMainPage();
            break;
          case CarDetailPage.ADDRESS:
            builder = (BuildContext _) => CarDetailPage(settings.arguments);
            break;
          case FilterCarPage.ADDRESS:
            builder = (BuildContext _) => FilterCarPage();
            break;
          case MapPage.ADDRESS:
            builder = (BuildContext _) => MapPage(type: 3,);
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
