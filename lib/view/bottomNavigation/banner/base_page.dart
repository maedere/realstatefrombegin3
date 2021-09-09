import 'package:flutter/material.dart';
import 'package:realstatefrombegin3/view/bottomNavigation/banner/main.dart';
import 'package:realstatefrombegin3/view/bottomNavigation/home/map.dart';

class BasePageBanner extends StatelessWidget{

   final GlobalKey<NavigatorState> keyNav;

  BasePageBanner(this.keyNav);

  @override
  Widget build(BuildContext context) {

    return Navigator(
      key: keyNav,
      initialRoute: BannerMainPage.ADDRESS,
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case BannerMainPage.ADDRESS:
            builder = (BuildContext _) => BannerMainPage();
            break;
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