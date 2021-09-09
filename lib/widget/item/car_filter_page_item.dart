import 'package:flutter/material.dart';
import 'package:realstatefrombegin3/model/object/filter.dart';
import 'package:realstatefrombegin3/util/size_config.dart';
import 'package:realstatefrombegin3/values/color_app.dart';
import 'package:realstatefrombegin3/util/Constant.dart';

class CarFilterPageItem extends StatefulWidget {
  final FilterModel model;
  double height;
  final Function() notifyParent;

  CarFilterPageItem({ @required this.model,@required this.height, this.notifyParent});
  @override
  _CarFilterPageItemState createState() => _CarFilterPageItemState();
}

class _CarFilterPageItemState extends State<CarFilterPageItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        setState(() {
          widget.model.active=!widget.model.active;
          Constant.carFilters[Constant.carFilters.indexWhere((element) => (element.type == widget.model.type && element.name == widget.model.name))] = widget.model;
        });

      },
      child: AnimatedContainer(duration: const Duration(milliseconds: 500),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 1.5.v /*, horizontal: 5.h*/),
          margin: EdgeInsets.symmetric(horizontal: 1.h , vertical: .5.v),
          //height: height,
          width: 20.h,
          decoration: BoxDecoration(
            color: widget.model.active ? ColorApp.accentColor.withOpacity(.3) : Colors.white,
            border: Border.all(color: ColorApp.accentColor.withOpacity(.4)),
            borderRadius: BorderRadius.circular(30),
          ),

          child:(widget.model.type=="feature"  )?
          Stack(children: [
            Align(
              alignment: Alignment.topCenter,
              child: Icon(
                widget.model.icon,
                size:widget.height/2,
                color: Color.fromRGBO(10, 100, 54, 10),
              ),
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Text(widget.model.name , style: TextStyle(color: ColorApp.accentColor),))],):
          Center(child: Text(widget.model.name , style: TextStyle(color: ColorApp.accentColor),),),
        ),
        height: widget.height,
      ),
    );
  }
}


