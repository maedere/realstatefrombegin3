import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:realstatefrombegin3/util/Constant.dart';
import 'package:realstatefrombegin3/util/Tools.dart';
import 'package:realstatefrombegin3/util/size_config.dart';

import 'package:realstatefrombegin3/model/object/home.dart';
import 'package:realstatefrombegin3/values/icon_app_icons.dart';
import 'package:realstatefrombegin3/view/bottomNavigation/home/detail.dart';
import 'package:realstatefrombegin3/view/bottomNavigation/profile/fav_page.dart';
class HomeItem extends StatefulWidget {
  final MiniHome miniHome;

  const HomeItem({Key key, this.miniHome}) : super(key: key);

  @override
  _HomeItemState createState() => _HomeItemState();
}

class _HomeItemState extends State<HomeItem> {
  bool fav = false;

  void updateLikes(){
    setState(() {
      Constant.favorites.contains(widget.miniHome) ? fav =true : fav = false;

    });
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailHomePage(widget.miniHome.id))).then((value) {
          updateLikes();

        });
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /*Container(

            width: double.infinity,
            height: 27.v,
            margin: EdgeInsets.only(bottom: 1.v),
            child: miniHome.image == null
                ? Image(
                    image: AssetImage(
                      Constant.IMAGE_ADDRESS + "h5.jpg",
                    ),
                    fit: BoxFit.fill,
                    width: double.infinity,
                    height: double.infinity,
                  )
                : Image(
                    image: NetworkImage(
                      Constant.BASE_IMAGE_ADDRESS + miniHome.image,
                    ),
                    fit: BoxFit.fill,
                    width: double.infinity,
                    height: double.infinity,
                  ),
          ),*/
          Stack(
            children: [

              Container(
                width: double.infinity,
                height: 27.v,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),

                  child: Image(
                    image:  ( widget.miniHome.image == null )? AssetImage(
                      Constant.IMAGE_ADDRESS + "h5.jpg",
                    ) : NetworkImage(
                      Constant.BASE_IMAGE_ADDRESS + widget.miniHome.image,
                    ),
                    fit: BoxFit.fill,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
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
                      Tools.editFavorite( widget.miniHome, fav);
                    });
                  },
                  child: Icon(IconApp.favorite,
                      size: 20,
                      color: fav ? Colors.redAccent : Colors.white),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 1.v,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  ' \$${widget.miniHome.price}',
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
                SizedBox(
                  width: 2.h,
                ),
                SizedBox(
                  width: 60.h,
                  child: Text(
                    widget.miniHome.address,
                    style: TextStyle(color: Colors.grey, fontSize: 15),
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 1.v,
          ),
          Text(
              ("${widget.miniHome.bathroom} bathroom / ${widget.miniHome.bedroom} bedroom / ${widget.miniHome.size} foot")),
          SizedBox(
            height: 3.v,
          ),
        ],
      ),
    );
  }
}


