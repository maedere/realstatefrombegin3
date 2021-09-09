import 'package:flutter/material.dart';
import 'package:realstatefrombegin3/values/color_app.dart';
import 'package:realstatefrombegin3/values/icon_app_icons.dart';
import 'package:realstatefrombegin3/view/bottomNavigation/home/map.dart';
import 'package:realstatefrombegin3/view/bottomNavigation/profile/form.dart';
import 'package:realstatefrombegin3/view/bottomNavigation/profile/list_data_added.dart';
import 'package:realstatefrombegin3/view/bottomNavigation/profile/reserve_histrory.dart';

class CustomMultiFloatActionButton extends StatefulWidget {
  final Function() onPressed;
  final String tooltip;
  final IconData icon;
  final Key key;

  CustomMultiFloatActionButton(
      {this.onPressed, this.tooltip, this.icon, this.key})
      : super(key: key);

  @override
  _CustomMultiFloatActionButton createState() =>
      _CustomMultiFloatActionButton();
}

class _CustomMultiFloatActionButton extends State<CustomMultiFloatActionButton>
    with SingleTickerProviderStateMixin {
  bool isOpened = false;
  AnimationController _animationController;
  Animation<Color> _buttonColor;
  Animation<double> _animateIcon;
  Animation<double> _translateButton;
  Curve _curve = Curves.easeOut;
  double _fabHeight = 56.0;

  @override
  initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500))
          ..addListener(() {
            setState(() {});
          });
    _animateIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _buttonColor = ColorTween(
      begin: ColorApp.primaryColor,
      end: Colors.red,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.00,
        1.00,
        curve: Curves.linear,
      ),
    ));
    _translateButton = Tween<double>(
      begin: _fabHeight,
      end: -14.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.0,
        0.75,
        curve: _curve,
      ),
    ));
    super.initState();
  }

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  animate() {
    if (!isOpened) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    isOpened = !isOpened;
  }

  Widget add(BuildContext context) {
    return Container(
      child: FloatingActionButton(
        heroTag: "btnAdd",
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>FormPage()),);
        },
        tooltip: 'Add',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget image(BuildContext context) {
    return Container(
      child: FloatingActionButton(
        heroTag: "btnList",
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>ListDataPage()));
        },
        tooltip: 'List',
        child: Icon(Icons.view_list),
      ),
    );
  }

  Widget inbox(BuildContext context) {
    return Container(
      child: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>MapPage(type:2)));

        },
        heroTag: "btnMap",
        tooltip: 'map',
        child: Icon(IconApp.compass),
      ),
    );
  }

  Widget history(BuildContext context) {
    return Container(
      child: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>History()));

        },
        heroTag: "btnHistory",
        tooltip: 'history',
        child: Icon(Icons.history_toggle_off),
      ),
    );
  }
  Widget toggle() {
    return Container(
      child: FloatingActionButton(
        heroTag: "btnFloat",
        backgroundColor: _buttonColor.value,
        onPressed: animate,
        tooltip: 'Toggle',
        child: AnimatedIcon(
          icon: AnimatedIcons.menu_close,
          progress: _animateIcon,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value * 4.0,
            0.0,
          ),
          child: add(context),
        ),
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value * 3.0,
            0.0,
          ),
          child: history(context),
        ),
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value * 2.0,
            0.0,
          ),
          child: image(context),
        ),
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value,
            0.0,
          ),
          child: inbox(context),
        ),

        toggle(),
      ],
    );
  }
}
