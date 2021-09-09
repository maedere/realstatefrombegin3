import 'package:flutter/material.dart';
import 'package:realstatefrombegin3/view/bottomNavigation/home/map.dart';
import 'package:realstatefrombegin3/view/bottomNavigation/hotel/detail.dart';
import 'package:realstatefrombegin3/view/bottomNavigation/hotel/main.dart';
import 'package:realstatefrombegin3/view/bottomNavigation/hotel/filter.dart';

class BasePageHotel extends StatelessWidget{

   final GlobalKey<NavigatorState> keyNav;


   BasePageHotel(this.keyNav);

  @override
  Widget build(BuildContext context) {

    return
      Navigator(
        key: keyNav,
        onPopPage: (route, result) {
          print('route');
          print(route);
          print('result');
          print(result);
          return true;
        },
        initialRoute: HotelMainPage.ADDRESS,
        onGenerateRoute: (RouteSettings settings) {
          WidgetBuilder builder;
          switch (settings.name) {
            case HotelMainPage.ADDRESS:
              builder = (BuildContext _) => HotelMainPage();
              break;
            case DetailHotelPage.ADDRESS:
              builder = (BuildContext _) => DetailHotelPage(id :settings.arguments);
              break;
            case MapPage.ADDRESS:
              builder = (BuildContext _) => MapPage(type: 1,);
              break;
            case FilterHotelPage.ADDRESS:
              builder = (_) => FilterHotelPage();
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