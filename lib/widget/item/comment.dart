import 'package:flutter/material.dart';
import 'package:realstatefrombegin3/model/object/comment.dart';
import 'package:realstatefrombegin3/util/size_config.dart';
import 'package:realstatefrombegin3/values/color_app.dart';
import 'package:realstatefrombegin3/view/splash.dart';


class CommentItem extends StatelessWidget {

  final Comment comment;


  CommentItem({@required this.comment});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,

      margin: EdgeInsets.symmetric(vertical: 1.v, horizontal: 10.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ColorApp.primaryColor.withOpacity(.3)),
            child: Center(
              child: Text(
                comment.name == null ? comment.userId.substring(0,1):
                comment.name.substring(0,1).toUpperCase(),
                style: TextStyle(
                  fontSize: 18,
                  shadows: <Shadow>[
                    Shadow(
                      color: Colors.black.withOpacity(.4),
                      blurRadius: 2,
                    ),
                  ],
                ),
              ),
            ),
            width: 6.v,
            height: 6.v,
          ),
          SizedBox(
            width: 3.h,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(  comment.name == null ? comment.userId : comment.name),
              SizedBox(
                height: 5,
              ),
              Container(
                width: 28.v,
                child: Text(
                  comment.message,
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
