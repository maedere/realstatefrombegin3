


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:realstatefrombegin3/model/object/hotel.dart';
import 'package:realstatefrombegin3/model/object/reserve.dart';
import 'package:realstatefrombegin3/util/Constant.dart';
import 'package:realstatefrombegin3/util/size_config.dart';
import 'package:realstatefrombegin3/values/icon_app_icons.dart';
import 'package:realstatefrombegin3/view/bottomNavigation/profile/suiteDetail.dart';

class HistoryItem extends StatefulWidget {
  final Reserve reserve;

  const HistoryItem({Key key, this.reserve}) : super(key: key);
  @override
  _HistoryItemState createState() => _HistoryItemState();
}

class _HistoryItemState extends State<HistoryItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailSuitePage(reserve: widget.reserve,)));
      },
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Card(
          child: Padding(
            padding:  EdgeInsets.only(left: 1.v,right: 1.v),
            child: IntrinsicHeight(
              child:Row(
                      children: [
                        Padding(
                          padding:  EdgeInsets.only(top: 1.v,bottom: 1.v,right: 1.v),
                          child: GestureDetector(
                            child: Container(

                              width: 29.h,
                              height: 29.h,
                              child:
                              ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child:widget.reserve.image==""
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
                                    Constant.BASE_IMAGE_ADDRESS + widget.reserve.image),
                                fit: BoxFit.fill,
                                width: double.infinity,
                                height: double.infinity,
                              ),)
                            ),
                          ),
                        ),
                        Padding(
                          padding:  EdgeInsets.only(top:1.v,bottom: 1.v ),
                          child: Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,// for left side
                              children: [
                                Text(widget.reserve.hotelName,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 1.8.v+1.2.h),),
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
                                  initialRating: 3,
                                  allowHalfRating: false,
                                  itemPadding: EdgeInsets.symmetric(horizontal: 1),
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.date_range,size: 5.h,),
                                    Text(" "+widget.reserve.startDate+" "),
                                    Icon(Icons.arrow_forward,size: 5.h,),
                                    Text(" "+widget.reserve.endDate),
                                  ],
                                ),
                                Container(
                                  child:  Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Text(widget.reserve.bed.toString() + " bed"+(widget.reserve.bed>1?"s":"")),
                                  ),),
                                Row(
                                  children: [
                                    Icon(Icons.monetization_on_outlined,size: 5.h,),
                                    Text(" "+widget.reserve.priceAll+"\$"),
                                  ],),

                              ],
                            ),
                          ),
                        )
                      ],
                    ),)
          ),
        ),
      ),
    );

  }
}
