import 'package:flutter/material.dart';
import 'package:realstatefrombegin3/util/size_config.dart';

class CustomButtonBig extends StatelessWidget{

  final Widget child;
  final Function clickCallback;
  final Color color;
  final double height;


  CustomButtonBig({this.child, this.clickCallback, this.color,this.height});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: clickCallback,
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 3.h , vertical: 1.v),
        height: height,
        padding: EdgeInsets.symmetric(vertical: 2.v),
        child: Center(child: child),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
      ),
    );
  }

}
