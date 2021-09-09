import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:realstatefrombegin3/model/object/hotel.dart';
import 'package:realstatefrombegin3/util/Constant.dart';
import 'package:realstatefrombegin3/util/size_config.dart';
import 'package:realstatefrombegin3/values/icon_app_icons.dart';
import 'package:realstatefrombegin3/view/bottomNavigation/car/detail.dart';
import 'package:realstatefrombegin3/view/bottomNavigation/home/detail.dart';
import 'package:realstatefrombegin3/view/bottomNavigation/hotel/detail.dart';


class MapItem extends StatelessWidget {
  final bool fav;
  final HotelModel hotel;
  final int type;

  MapItem({this.fav = false, @required this.hotel,this.type});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        switch (type) {
          case 0:
            Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailHomePage(hotel.id.toString())));

            break;
          case 1:
            Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailHotelPage(id:hotel.id.toString())));

            break;
          case 3:
            Navigator.push(context, MaterialPageRoute(builder: (context)=>CarDetailPage(hotel.id.toString())));

            break;

        }


      },
      child: Container(
        width: 70.h,
        height: 27.v,
        margin: EdgeInsets.symmetric(horizontal: 2.h),
        child: Stack(
          children: [
        ClipRRect(
        borderRadius: BorderRadius.circular(5),
          child: hotel.images.length==0
              ? Image(
            image: AssetImage(
              Constant.IMAGE_ADDRESS + (type==3?"fiat.jpg":"h5.jpg"),
            ),
            fit: BoxFit.fill,
            width: double.infinity,
            height: double.infinity,
          )
              : Image(
            image: NetworkImage(
              Constant.BASE_IMAGE_ADDRESS + hotel.images[0],
            ),
            fit: BoxFit.fill,
            width: double.infinity,
            height: double.infinity,
          ),
        )
            ,

            Positioned(
              left: 2.h,
              bottom: 2.h,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    hotel.name,
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  hotel.level == 0 ? SizedBox():
                  RatingBar.builder(
                    onRatingUpdate: null,
                    itemSize: 12,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Icon(
                        IconApp.star,
                        color: Colors.yellow[600],
                      );
                    },
                    initialRating: hotel.level.toDouble(),
                    allowHalfRating: true,
                    itemPadding: EdgeInsets.symmetric(horizontal: 1),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
