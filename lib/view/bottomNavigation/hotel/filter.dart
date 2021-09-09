import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:realstatefrombegin3/model/object/filter.dart';
import 'package:realstatefrombegin3/util/Constant.dart';

import 'package:realstatefrombegin3/util/size_config.dart';
import 'package:realstatefrombegin3/values/color_app.dart';
import 'package:realstatefrombegin3/values/icon_app_icons.dart';
import 'package:realstatefrombegin3/view/bottomNavigation/hotel/main.dart';
import 'package:realstatefrombegin3/widget/custom/button.dart';
import 'package:realstatefrombegin3/widget/custom/search_box.dart';
import 'package:realstatefrombegin3/widget/item/filter_page_item.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class FilterHotelPage extends StatefulWidget {
  static const ADDRESS = 'hotel/filter';

  @override
  _FilterHotelPageState createState() => _FilterHotelPageState();
}

class _FilterHotelPageState extends State<FilterHotelPage> {

  int active = 0;
  String currentCity="All";
  String currentBedCount="1";
  DateTime now;
  String startDate;
  String endDate;
  List<bool> starRatingList=[false,false,false,false,false];
  List<String> facilitiesName=["restaurant","cafe","parking","pool"];
  List<bool> facilities=[false,false,false,false];//restaurant,cafe,parking,pool
  List<String> roomFacilitiesName=["kitchen","brakfast","terrace","aircondition","wifi","tv","animal"];
  List<bool> roomFacilities=[false,false,false,false,false,false,false];//kitchen,brakfast,terrace,aircondition,wifi,tv,animal
  DateRangePickerController _dateRangePickerController= DateRangePickerController();

  @override
  void initState() {
    now = DateTime.now();

    startDate=DateFormat('yyyy-MM-dd').format(now);
    endDate=DateFormat('yyyy-MM-dd').format(now);
    Constant.hotelFilters=[
      FilterModel('1', 'bed', false),
      FilterModel('2', 'bed', false),
      FilterModel('3', 'bed', false),
      FilterModel('4', 'bed', false),
      FilterModel('5', 'bed', false),
      FilterModel('6', 'bed', false)];


    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    if(Constant.pop)
      {
        Navigator.pop(context);
        Constant.pop=false;
      }
    SizeConfig sizeConfig = new SizeConfig();
    sizeConfig.init(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 10.h, right: 5.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 8.v,
              ),

              Text( "City area",
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: Constant.fontSize,
                    color: Colors.black),),
              SizedBox(
                height: 1.v,
              ),

              DropdownButton(items:Constant.cites.map((e) => DropdownMenuItem(child: Text(e) , value: e,)).toList().cast<DropdownMenuItem<String>>(), onChanged: (i){
                setState(() {
                  currentCity=i;
                });
              },
                value: currentCity,
                isExpanded: true,),
              SizedBox(
                height: 10.h,
              ),

              Text( "Bed count",
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: Constant.fontSize,
                    color: Colors.black),),
              SizedBox(
                height: 2.v,
              ),
              DropdownButton(items:Constant.bedCounts.map((e) => DropdownMenuItem(child: Text(e) , value: e,)).toList().cast<DropdownMenuItem<String>>(), onChanged: (i){
                    setState(() {
                      currentBedCount=i;
                    });
                  },
                value: currentBedCount,
                isExpanded: true,),
              SizedBox(
                height: 5.v,
              ),
              InkWell(
                onTap: (){
                  showDialog(

                      context: context,
                      builder: (context) {
                        return StatefulBuilder(
                            builder: (context, myState) {
                              return
                                Scaffold(
                                  appBar: AppBar(
                                    iconTheme: IconThemeData(
                                      color: Colors.black, //change your color here
                                    ),
                                    backgroundColor: Colors.white,
                                    elevation: 0,
                                    centerTitle: true,
                                  ),
                                  body: Container(
                                    width: 200.h,
                                    height: 100.v,
                                    color: Colors.white,
                                    child: Stack(
                                      children: [
                                        Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Container(
                                              height: 70.v,
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 10.v,
                                                  horizontal: 5.h),
                                              child: SfDateRangePicker(
                                                controller: _dateRangePickerController,
                                                view: DateRangePickerView.month,
                                                monthViewSettings:
                                                DateRangePickerMonthViewSettings(
                                                    firstDayOfWeek: 1),
                                                rangeSelectionColor: ColorApp
                                                    .primaryColor
                                                    .withOpacity(.4),
                                                selectionMode:
                                                DateRangePickerSelectionMode
                                                    .range,
                                                onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {

                                                  myState(() {
                                                    if (args.value is PickerDateRange) {

                                                      setState(() {
                                                        startDate=args.value.startDate.toString().split(" ")[0];
                                                        endDate=args.value.endDate.toString().split(" ")[0];
                                                      });

                                                    }
                                                  });
                                                },

                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            IgnorePointer(
                                              ignoring:    !(startDate.contains("-") && endDate.contains("-")),
                                              child: FlatButton(
                                                  onPressed: (){
                                                    Navigator.pop(context);


                                                  },
                                                  child: Container(
                                                    width: 20.v,
                                                    margin: EdgeInsets.symmetric(
                                                        horizontal: 3.h, vertical: 1.v),
                                                    height: 6.v,
                                                    padding: EdgeInsets.symmetric(vertical: 2.v),
                                                    child: Center(
                                                      child: Text(
                                                        "select",
                                                        style: TextStyle(
                                                            color: Colors.white, fontSize: 16),
                                                      ),
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: (startDate.contains("-") && endDate.contains("-"))?ColorApp.primaryColor:Colors.grey,

                                                      borderRadius:
                                                      BorderRadius.all(Radius.circular(30)),
                                                    ),
                                                  )

                                              ),
                                            ),

                                          ],
                                        ),

                                      ],
                                    ),
                                  ),
                                );}
                        );
                      });
                },
                child: Container(
                  width: 35.v,
                  decoration: BoxDecoration(

                      border: Border.all(
                        color: Colors.grey[500],
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(30))
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(Icons.date_range,size: 5.h,),
                        Text(" "+startDate+" "),
                        Icon(Icons.arrow_forward,size: 5.h,),
                        Text(" "+endDate),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text( "Star rating ",
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: Constant.fontSize,
                    color: Colors.black),),
              checkBox("1 star", 0,starRatingList),
              checkBox("2 stars", 1,starRatingList),
              checkBox("3 stars", 2,starRatingList),
              checkBox("4 stars", 3,starRatingList),
              checkBox("5 stars", 4,starRatingList),


              SizedBox(
                height: 10.h,
              ),
              Text( "Facilities",
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: Constant.fontSize,
                    color: Colors.black),),
              checkBox("Restaurant", 0,facilities),
              checkBox("Cafe", 1,facilities),
              checkBox("Parking", 2,facilities),
              checkBox("Pool", 3,facilities),


              SizedBox(
                height: 10.h,
              ),
              Text( "Room facilities",
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: Constant.fontSize,
                    color: Colors.black),),
              checkBox("Kitchen", 0,roomFacilities),
              checkBox("BreakFast included", 1,roomFacilities),
              checkBox("Terrace", 2,roomFacilities),
              checkBox("Air condition", 3,roomFacilities),
              checkBox("Wifi", 4,roomFacilities),
              checkBox("TV", 5,roomFacilities),
              checkBox("Animal", 6,roomFacilities),


              SizedBox(
                height: SizeConfig.blockSizeVertical * 10,
              ),
              CustomButtonBig(child: Text('Search' , style: TextStyle(color: Colors.white),),color: ColorApp.primaryColor ,clickCallback:(){
                List<String>  tempList=[];
                for(final i in Constant.hotelFilters)
                {
                  if(i.active) tempList.add(i.name);
                }

                List<String>  tempList1=[];
                for(int i=0;i<starRatingList.length;i++)
                {
                  if(starRatingList[i])
                    tempList1.add((i+1).toString());
                }

                List<String>  tempList2=[];
                for(int i=0;i<facilities.length;i++)
                {
                  if(facilities[i])
                    tempList2.add(facilitiesName[i]);
                }

                List<String>  tempList3=[];
                for(int i=0;i<roomFacilities.length;i++)
                {
                  if(roomFacilities[i])
                    tempList3.add(roomFacilitiesName[i]);
                }
                Navigator.pop(context,[currentCity,currentBedCount,startDate,endDate,tempList1,tempList2,tempList3]);

              }, ),

            ],
          ),
        ),
      ),
    );
  }
  Widget checkBox(title,index,list){
    return GestureDetector(
      onTap: (){
        setState(() {
          list[index]=!list[index];
        });
      },
      child: ListTile(
        title: Align(
          child: Align(child: Text(title),alignment: Alignment.centerLeft,),
          alignment: Alignment(-1.5,0),
        ),
        leading: Icon(list[index]?Icons.check_box_outlined:Icons.check_box_outline_blank),
      ),
    );
  }
}
