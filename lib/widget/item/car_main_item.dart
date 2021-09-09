import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:realstatefrombegin3/model/object/car.dart';
import 'package:realstatefrombegin3/util/Constant.dart';
import 'package:realstatefrombegin3/util/Tools.dart';
import 'package:realstatefrombegin3/util/size_config.dart';
import 'package:realstatefrombegin3/values/icon_app_icons.dart';
import 'package:realstatefrombegin3/view/bottomNavigation/car/detail.dart';
import 'package:realstatefrombegin3/view/bottomNavigation/profile/fav_page.dart';

class CarItem extends StatefulWidget {
  final MiniCar miniCar;

  @override
  _CarItemState createState() => _CarItemState();
  CarItem({@required this.miniCar});

}

class _CarItemState extends State<CarItem> {
  bool fav = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder:(context) =>CarDetailPage(widget.miniCar.id.toString()))).then((value) {
          setState(() {
            fav=false;
            for (final i in Constant.favorites)
            {
              if(i is MiniCar && i.id==widget.miniCar.id)
              {
                fav=true;
                break;
              }
            }
            // Constant.favorites.contains(miniCar) ? fav =true : fav = false;
          });
        });
      },
      child: Container(
        width: double.infinity,
        height: 27.v,
        margin: EdgeInsets.only(bottom: 1.v),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image(
                image:  ( widget.miniCar.images.length > 0 )? NetworkImage(
                  Constant.BASE_IMAGE_ADDRESS + widget.miniCar.images[0],
                ) : AssetImage(Constant.IMAGE_ADDRESS + 'fiat2.jpg'),
                fit: BoxFit.fill,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
            Positioned(
              right: 2.h,
              top: 2.h,
              child: StatefulBuilder(
                builder: (contextChild, setState) {
                  return GestureDetector(
                    onLongPress: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>FavoritePage()));
                    },

                    onTap: () {
                      setState(() {
                        fav = !fav;
                        Tools.editFavorite(widget.miniCar, fav);
                      });
                    },
                    child: Icon(IconApp.favorite,
                        size: 20,
                        color: fav ? Colors.redAccent : Colors.white),
                  );
                },
              ),
            ),
            Positioned(
              right: 2.h,
              bottom: 2.h,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "\$"+widget.miniCar.cost.toString()+"/day",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.miniCar.totalTrips.toString()=="null"?"no trips":widget.miniCar.totalTrips.toString()+"trips",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 2.h,
              bottom: 2.h,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    widget.miniCar.company+" "+widget.miniCar.model+" "+widget.miniCar.year.toString(),
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  SizedBox(
                    height: 10,
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


