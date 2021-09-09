import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:realstatefrombegin3/model/object/home.dart';
import 'package:realstatefrombegin3/model/object/hotel.dart';
import 'package:realstatefrombegin3/util/Constant.dart';
import 'package:realstatefrombegin3/util/size_config.dart';
import 'package:realstatefrombegin3/values/icon_app_icons.dart';
import 'package:realstatefrombegin3/view/bottomNavigation/home/detail.dart';
import 'package:realstatefrombegin3/view/bottomNavigation/hotel/detail.dart';

class BannerItem extends StatefulWidget {
  final MiniHotel hotel;
  final MiniHome home;
  final String type;

  BannerItem({this.hotel, this.home, @required this.type});

  @override
  _BannerItemState createState() => _BannerItemState();
}

class _BannerItemState extends State<BannerItem> {
  bool fav = false;

  @override
  Widget build(BuildContext context) {
    return widget.type == 'home' ? _homeBuild(context) : _hotelBuild(context);
  }

  Widget _homeBuild(BuildContext context) {

    Constant.favorites.contains(widget.home) ? fav = true:fav = false;

    return GestureDetector(
      onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (context)=> widget.type=="home"?DetailHomePage(widget.home.id):DetailHotelPage(id:widget.hotel.id.toString())));
      },
      child: Container(
        width: 42.h,
        height: 15.v,
        margin: EdgeInsets.symmetric(horizontal: 2.h),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image(
                image: widget.home.image == null
                    ? AssetImage(
                        Constant.IMAGE_ADDRESS + "h5.jpg",
                      )
                    : NetworkImage(
                        Constant.BASE_IMAGE_ADDRESS + widget.home.image),
                fit: BoxFit.fill,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
            /*Positioned(
              right: 2.h,
              top: 2.h,
              child: GestureDetector(

                child: Icon(IconApp.favorite,
                    size: 20, color: fav ? Colors.redAccent : Colors.white),
              ),
            ),*/
            Positioned(
              right: 2.h,
              bottom: 2.h,
              child: Text(
                widget.home.price,
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            Positioned(
              left: 2.h,
              bottom: 2.h,
              child: Text(
                widget.home.address,
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _hotelBuild(BuildContext context) {

    Constant.favorites.contains(widget.hotel) ? fav = true:fav = false;

    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=> widget.type=="home"?DetailHomePage(widget.home.id):DetailHotelPage(id:widget.hotel.id.toString())));

      },
      child: Container(
        width: 42.h,
        height: 15.v,
        margin: EdgeInsets.symmetric(horizontal: 2.h),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5),

              child: Image(
                image: widget.hotel.images.length==0
                    ? AssetImage(
                        Constant.IMAGE_ADDRESS + "h5.jpg",
                      )
                    : NetworkImage(
                        Constant.BASE_IMAGE_ADDRESS + widget.hotel.images[0]),
                fit: BoxFit.fill,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
            /*Positioned(
              right: 2.h,
              top: 2.h,
              child: GestureDetector(

                child: Icon(IconApp.favorite,
                    size: 20, color: fav ? Colors.redAccent : Colors.white),
              ),
            ),*/
            Positioned(
              right: 2.h,
              bottom: 2.h,
              child: Text(
                widget.hotel.priceAll.toString(),
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            Positioned(
              left: 2.h,
              bottom: 2.h,
              child: Text(
                widget.hotel.name,
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
