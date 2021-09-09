import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:realstatefrombegin3/model/object/agent.dart';
import 'package:realstatefrombegin3/model/object/car.dart';
import 'package:realstatefrombegin3/model/object/home.dart';
import 'package:realstatefrombegin3/model/object/hotel.dart';
import 'package:realstatefrombegin3/util/Constant.dart';
import 'package:realstatefrombegin3/util/size_config.dart';
import 'package:realstatefrombegin3/values/color_app.dart';
import 'package:realstatefrombegin3/values/icon_app_icons.dart';
import 'package:realstatefrombegin3/view/bottomNavigation/car/detail.dart';
import 'package:realstatefrombegin3/view/bottomNavigation/home/detail.dart';
import 'package:realstatefrombegin3/view/bottomNavigation/hotel/detail.dart';


// ignore: must_be_immutable
class HomeListItemWidget extends StatelessWidget {
  String heroTag;
  MiniHome home;
  MiniHotel hotel;
  MiniCar car;
  String type;
  Agent agent;

  HomeListItemWidget({Key key, this.heroTag, this.home , this.car ,this.hotel , @required this.type , this.agent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("build HomeListItemWidget");
    return type == 'home' ? _buildHome(context) : type == 'car' ? _buildCar(context) :type == 'hotel' ? _buildHotel(context) : _buildAgent(context);
  }

  Widget _buildHome(BuildContext context){

    return InkWell(
      splashColor: Theme.of(context).accentColor,
      focusColor: Theme.of(context).accentColor,
      highlightColor: Theme.of(context).primaryColor,
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailHomePage(home.id)));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Hero(
              tag: 'Home' + home.id,
              child: Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  image: DecorationImage(image:  (home.image == null)
                      ? AssetImage(
                      Constant.IMAGE_ADDRESS + "h5.jpg")
                      : NetworkImage(
                      Constant.BASE_IMAGE_ADDRESS + home.image.toString()), fit: BoxFit.cover),
                ),
              ),
            ),
            SizedBox(width: 15),
            Flexible(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          home.address,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        Text(
                          'beedroom:${home.bedroom} bathroom:${home.bathroom}',
                          overflow: TextOverflow.fade,
                          softWrap: false,
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 8),
                  Text('\$${home.price}', style: TextStyle(fontWeight: FontWeight.w800 , fontSize: 15)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildCar(BuildContext context){
    return InkWell(
      splashColor: Theme.of(context).accentColor,
      focusColor: Theme.of(context).accentColor,
      highlightColor: Theme.of(context).primaryColor,
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>CarDetailPage(car.id.toString())));

      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Hero(
              tag: 'car' + car.id.toString(),
              child: Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  image: DecorationImage(image:  (car.images.length  == 0)
                      ? AssetImage(
                      Constant.IMAGE_ADDRESS + "fiat.jpg")
                      : NetworkImage(
                      Constant.BASE_IMAGE_ADDRESS + car.images[0].toString()), fit: BoxFit.cover),
                ),
              ),
            ),
            SizedBox(width: 15),
            Flexible(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          car.model,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        /*RatingBar.builder(
                          onRatingUpdate: null,
                          itemSize: 12,
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return Icon(
                              IconApp.star,
                              color: ColorApp.accentColor,
                            );
                          },
                         // initialRating: car..toDouble(),
                          allowHalfRating: false,
                          itemPadding: EdgeInsets.symmetric(horizontal: 1),
                        )*/
                      ],
                    ),
                  ),
                  SizedBox(width: 8),
                  Text('\$${car.cost}', style: TextStyle(fontWeight: FontWeight.w800 , fontSize: 15)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildAgent(BuildContext context){

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Hero(
            tag: 'agent' + agent.email,
            child: Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                image: DecorationImage(image:  (agent.image=="")
                    ? AssetImage(
                    Constant.IMAGE_ADDRESS + "person.png")
                    : NetworkImage(
                    Constant.BASE_IMAGE_ADDRESS + agent.image.toString()), fit: BoxFit.cover),
              ),
            ),
          ),
          SizedBox(width: 15),
          Flexible(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        agent.name,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      Text(
                        agent.email,
                        overflow: TextOverflow.fade,
                        softWrap: false,
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 8),
                Text(agent.company, style: TextStyle(fontWeight: FontWeight.w800 , fontSize: 15)),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildHotel(BuildContext context){
    return InkWell(
      splashColor: Theme.of(context).accentColor,
      focusColor: Theme.of(context).accentColor,
      highlightColor: Theme.of(context).primaryColor,
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailHotelPage(id:hotel.id.toString())));

      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Hero(
              tag: 'hotel' + hotel.id.toString(),
              child: Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  image: DecorationImage(image:  (hotel.images.length==0)
                      ? AssetImage(
                      Constant.IMAGE_ADDRESS + "h5.jpg")
                      : NetworkImage(
                      Constant.BASE_IMAGE_ADDRESS + hotel.images[0].toString()), fit: BoxFit.cover),
                ),
              ),
            ),
            SizedBox(width: 15),
            Flexible(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          hotel.name,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        RatingBar.builder(
                          onRatingUpdate: null,
                          itemSize: 12,
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return Icon(
                              IconApp.star,
                              color: ColorApp.accentColor,
                            );
                          },
                          initialRating: hotel.level.toDouble(),
                          allowHalfRating: false,
                          itemPadding: EdgeInsets.symmetric(horizontal: 1),
                        )
                      ],
                    ),
                  ),
                  SizedBox(width: 8),
                  Text('\$${hotel.priceAll}', style: TextStyle(fontWeight: FontWeight.w800 , fontSize: 15)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

}
