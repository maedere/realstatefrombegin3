import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:realstatefrombegin3/util/Constant.dart';

class EmptyShow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image(
            image: AssetImage(Constant.IMAGE_ADDRESS + 'empty.png'),
            width: 100,
            height: 100,
          ),
          Text(
            'Is Empty',
            style: TextStyle(
                color: Colors.black, fontSize: 25, fontWeight: FontWeight.w800),
          ),
        ],
      ),
    );
  }
}
