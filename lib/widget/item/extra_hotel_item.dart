import 'package:flutter/material.dart';
import 'package:realstatefrombegin3/util/Constant.dart';
import 'package:realstatefrombegin3/util/size_config.dart';
import 'package:realstatefrombegin3/values/color_app.dart';


class ExtraHotelItem extends StatelessWidget {
  final String name;
  final IconData icon;

  ExtraHotelItem({this.name, this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 5.h),
      child: Container(
        width: 8.v,
        height: 20.h,
        child: Column(
          children: [
            Container(
              width: 6.v,
              height: 6.v,
              decoration: BoxDecoration(
                border: Border.all(color: ColorApp.primaryColor,
                ),
                shape: BoxShape.circle
              ),
              child: Center(
                child: Icon(icon , color: Colors.black, size: 18,),
              ),
            ),
            SizedBox(
              height: 1.v,
            ),
            Center(child: Text(name,textAlign: TextAlign.center,style: TextStyle(fontSize: Constant.fontSize/2),))
          ],
        ),
      ),
    );
  }
}
