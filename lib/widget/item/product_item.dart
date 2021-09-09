import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:realstatefrombegin3/model/object/hotel.dart';
import 'package:realstatefrombegin3/util/Constant.dart';
import 'package:realstatefrombegin3/util/Tools.dart';
import 'package:realstatefrombegin3/util/size_config.dart';
import 'package:realstatefrombegin3/values/icon_app_icons.dart';
import 'package:realstatefrombegin3/view/bottomNavigation/hotel/detail.dart';
import 'package:realstatefrombegin3/view/bottomNavigation/profile/fav_page.dart';


class ProductItem extends StatefulWidget {
  final MiniHotel hotel;
  final String startDate,endDate;

  final  key1;

  ProductItem({@required this.hotel, this.key1, this.startDate, this.endDate});

  @override
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  bool fav = false;

  @override
  void initState() {
    updateLikes();
    super.initState();
  }

  void updateLikes(){
    setState(() {
      Constant.favorites.contains(widget.hotel) ? fav =true : fav = false;

    });

  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailHotelPage(id: widget.hotel.id.toString(),startDate: widget.startDate,endDate: widget.endDate,))).then((value) {
          updateLikes();
        });

      },
      child: Container(
        key: widget.key1,

        width: double.infinity,
        height: 27.v,
        margin: EdgeInsets.only(bottom: 1.v),
        child: Stack(
          children: [
        ClipRRect(
        borderRadius: BorderRadius.circular(5),
          child:widget.hotel.images.length==0
              ? Image(
            image: AssetImage(
              Constant.IMAGE_ADDRESS + "h5.jpg",
            ),
            fit: BoxFit.fitWidth,
            width: double.infinity,
            height: double.infinity,
          )
              : Image(
            image: NetworkImage(
                Constant.BASE_IMAGE_ADDRESS + widget.hotel.images[0]),
            fit: BoxFit.fill,
            width: double.infinity,
            height: double.infinity,
          ) ,
        ),

            Positioned(
              right: 2.h,
              top: 2.h,
              child:GestureDetector(
                onLongPress: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>FavoritePage()));
                },

                onTap: () {
                  setState(() {
                    fav = !fav;
                    Tools.editFavorite( widget.hotel, fav);
                  });
                },
                child: Icon(IconApp.favorite,
                    size: 20,
                    color: fav ? Colors.redAccent : Colors.white),
              ),
            ),

            Positioned(
              left: 2.h,
              bottom: 2.h,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.hotel.name,
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
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
                    initialRating: widget.hotel.level.toDouble(),
                    allowHalfRating: false,
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
