
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchBox extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   return Container(
     decoration: BoxDecoration(
       color: Colors.white ,
       borderRadius: BorderRadius.circular(5),
       border: Border.all(color: Colors.grey[500])
     ),
     padding: EdgeInsets.symmetric(horizontal: 15, vertical: 3),
     child: TextField(
       decoration: InputDecoration(
         hintText: "${0xe800} Search hotel" ,
         hintStyle: TextStyle(color:  Colors.grey[400], fontSize: 14,fontFamily: 'IconApp' , package: null),
         border: InputBorder.none
       ),
     )
   );
  }

}