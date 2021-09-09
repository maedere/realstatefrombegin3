import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:realstatefrombegin3/model/NavigationProvider.dart';

import 'package:realstatefrombegin3/model/object/filter.dart';
import 'package:realstatefrombegin3/util/Constant.dart';
import 'package:realstatefrombegin3/values/color_app.dart';
import 'package:realstatefrombegin3/values/icon_app_icons.dart';
import 'package:realstatefrombegin3/view/bottomNavigation/home/main.dart';

import 'package:realstatefrombegin3/widget/custom/float_action_button_with_item.dart';

import 'bottomNavigation/banner/base_page.dart';
import 'bottomNavigation/banner/main.dart';
import 'bottomNavigation/car/base_page.dart';
import 'bottomNavigation/car/main.dart';
import 'bottomNavigation/home/base_page.dart';
import 'bottomNavigation/hotel/base_page.dart';
import 'bottomNavigation/hotel/main.dart';
import 'bottomNavigation/profile/base_page.dart';
import 'bottomNavigation/profile/main.dart';

class BaseNavigation extends StatefulWidget {
  @override
  _BaseNavigationState createState() => _BaseNavigationState();
}

class _BaseNavigationState extends State<BaseNavigation> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  Future<bool> _onWillPopMain(BuildContext context, myModel) async {
    if (!_navigatorKeys[myModel.index].currentState.canPop()) {
      return (await showDialog(
            context: context,
            builder: (context) => new AlertDialog(
              title: new Text('Are you sure?'),
              content: new Text('Do you want to exit an App'),
              actions: <Widget>[
                new FlatButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: new Text('No'),
                ),
                new FlatButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: new Text('Yes'),
                ),
              ],
            ),
          )) ??
          false;
    } else {
      _navigatorKeys[myModel.index].currentState.pop();
      return false;
    }
  }

  static List<Widget> _widgetOptions = <Widget>[
    Scaffold(body: HomeMainPage()),
    Scaffold(body: HotelMainPage()),
    Scaffold(body: BannerMainPage()),
    Scaffold(body: CarMainPage()),
    Scaffold(body: ProfileMainPage()),
  ];

  void _onItemTapped(int index, myModel) {
    myModel.changeIndex(index);

  }

  @override
  void initState() {
    super.initState();
  }

  final List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationProviderModel>(//                  <--- Consumer
        builder: (context, myModel, child) {
      return Scaffold(
          body: WillPopScope(
            onWillPop: () => _onWillPopMain(context, myModel),
            child: IndexedStack(
              index: myModel.index,
              children: [
                BasePageHome(_navigatorKeys[0]),
                BasePageHotel(_navigatorKeys[1]),
                BasePageBanner(_navigatorKeys[2]),
                BasePageCar(_navigatorKeys[3]),
                BasePageProfile(_navigatorKeys[4]),
              ],
            ),
          ),
          /*WillPopScope(
          onWillPop: () => _onWillPopMain(context),
          child: Center(
            child: _widgetOptions.elementAt(_selectedIndex),
          ),
        ),*/
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: myModel.index,
            backgroundColor: Colors.white,
            selectedItemColor: ColorApp.accentColor,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(
                    IconApp.home,
                    color: Colors.black,
                  ),
                  label: "home"),
              BottomNavigationBarItem(
                  icon: Icon(
                    IconApp.travel,
                    color: Colors.black,
                  ),
                  label: "Trip"),
              BottomNavigationBarItem(
                  icon: Icon(
                    IconApp.open_menu,
                    color: Colors.black,
                  ),
                  label: "real estate"),
              BottomNavigationBarItem(
                  icon: Image(
                    image: AssetImage(Constant.IMAGE_ADDRESS + "car.png"),
                    width: 35,
                    height: 35,
                  ),
                  label: "car"),
              BottomNavigationBarItem(
                icon: Icon(
                  IconApp.user,
                  color: Colors.black,
                ),
                label: 'profile',
              ),
            ],
            onTap: (index) {
              _onItemTapped(index, myModel);
            },
          ),
          floatingActionButton: Constant.login
              ? CustomMultiFloatActionButton(
                  key: GlobalKey(),
                )
              : SizedBox());
    });
  }

  void click(BuildContext context, int index) {
    if (index == 0) Constant.homeController.add(true);

    if (index == 3) Constant.carController.add(true);
  }
}
