import 'package:flutter/material.dart';
import 'package:realstatefrombegin3/util/Constant.dart';
import 'package:realstatefrombegin3/util/size_config.dart';
import 'package:realstatefrombegin3/values/color_app.dart';


class DetailHomeItem extends StatelessWidget {
  final String data;
  final String name;

  DetailHomeItem({this.data, this.name});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 5.h),
      child: Column(
        children: [
          Container(
            width: 7.v,
            height: 7.v,
            decoration: BoxDecoration(
              border: Border.all(color: ColorApp.accentColor.withOpacity(.4)),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Center(
              child: Text(data , style: TextStyle(fontWeight: FontWeight.w800 , fontSize: Constant.fontSize/1.5),),
            ),
          ),
          SizedBox(
            height: 2.v,
          ),
          Text(name,style: TextStyle(fontSize: Constant.fontSize/2),)
        ],
      ),
    );
  }
}
