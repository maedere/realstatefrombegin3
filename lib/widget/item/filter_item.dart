
import 'package:flutter/material.dart';
import 'package:realstatefrombegin3/model/object/filter.dart';
import 'package:realstatefrombegin3/util/size_config.dart';
import 'package:realstatefrombegin3/values/color_app.dart';

class FilterItem extends StatelessWidget{

  final FilterModel model;

  FilterItem({ @required this.model});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        model.active = true;
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 2.h , vertical: .5.v),
        padding: EdgeInsets.symmetric(horizontal: 5.h , vertical: 1.v),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: ColorApp.accentColor.withOpacity(.4)),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(child: Text(model.toString() , style: TextStyle(color: ColorApp.accentColor),)),
      ),
    );
  }

}