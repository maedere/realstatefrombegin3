import 'package:flutter/material.dart';
import 'package:realstatefrombegin3/model/object/filter.dart';
import 'package:realstatefrombegin3/util/Constant.dart';
import 'package:realstatefrombegin3/util/size_config.dart';
import 'package:realstatefrombegin3/values/color_app.dart';

class FilterPageItem extends StatefulWidget {
  final FilterModel model;

  FilterPageItem({ @required this.model});
  @override
  _FilterPageItemState createState() => _FilterPageItemState();
}

class _FilterPageItemState extends State<FilterPageItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        setState(() {
          widget.model.active=!widget.model.active;
          Constant.homeFilters[Constant.homeFilters.indexWhere((element) => (element.type == widget.model.type && element.name == widget.model.name))] = widget.model;

        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 1.5.v /*, horizontal: 5.h*/),
        margin: EdgeInsets.symmetric(horizontal: 1.h , vertical: .5.v),
        width: 20.h,
        decoration: BoxDecoration(
          color: widget.model.active ? ColorApp.accentColor.withOpacity(.3) : Colors.white,
          border: Border.all(color: ColorApp.accentColor.withOpacity(.4)),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(child: Text(widget.model.name , style: TextStyle(color: ColorApp.accentColor),)),
      ),
    );
  }
}

