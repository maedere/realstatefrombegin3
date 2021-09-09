import 'package:flutter/material.dart';
import 'package:realstatefrombegin3/util/size_config.dart';

class CustomButtonMini extends StatelessWidget{

  final Widget child;
  final Color color;


  CustomButtonMini({this.child, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40.v,
      height: 12.h,
    padding: EdgeInsets.symmetric(vertical: 1.v , horizontal: 20.h),
      child: Center(child: child),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(200)),
      ),
    );
  }

}