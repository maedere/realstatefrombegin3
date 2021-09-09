import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:realstatefrombegin3/model/object/filter.dart';

import 'package:realstatefrombegin3/util/Constant.dart';
import 'package:realstatefrombegin3/util/size_config.dart';
import 'package:realstatefrombegin3/values/color_app.dart';
import 'package:realstatefrombegin3/values/filter_icon_icons.dart';
import 'package:realstatefrombegin3/widget/custom/button.dart';
import 'package:realstatefrombegin3/widget/item/car_filter_page_item.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';


class FilterCarPage extends StatefulWidget {
  static const String ADDRESS = 'car/filter';

  @override
  _FilterCarPageState createState() => _FilterCarPageState();
}

class _FilterCarPageState extends State<FilterCarPage> {
  List<int> indexes=[];
  List<double> height=[];
  List<bool> seats=[false,false,false,false,false,false];//2,3,4,6,8,10
  List<bool> doors=[false,false];//2,4,
  String transmission = '0';
  String insurance = '0';

  String currentCity="All";

  SfRangeValues _values = SfRangeValues(100.0, 200000.0);
  @override
  void initState() {

    Constant.carFilters=[
      FilterModel('Tesla', 'company', false, null),
    FilterModel('Audi', 'company', false, null),
    FilterModel('BMW', 'company', false, null),
    FilterModel('Toyota', 'company', false, null),
    FilterModel('Daimler', 'company', false, null),
    FilterModel('Ferrari', 'company', false, null),
    FilterModel('Ford', 'company', false, null),
    FilterModel('Porsche', 'company', false, null),
    FilterModel('Honda', 'company', false, null),
    FilterModel('Lamborghini', 'company', false, null),
    FilterModel('Bentley', 'company', false, null),
    FilterModel('Jeep', 'company', false, null),
    FilterModel('Subaru', 'company', false, null),
    FilterModel('Mazda', 'company', false, null),
    FilterModel('Nissan', 'company', false, null),
    FilterModel('2000', 'year', false, null),
    FilterModel('2001', 'year', false, null),
    FilterModel('2002', 'year', false, null),
    FilterModel('2003', 'year', false, null),
    FilterModel('2004', 'year', false, null),
    FilterModel('2005', 'year', false, null),
    FilterModel('2006', 'year', false, null),
    FilterModel('2007', 'year', false, null),
    FilterModel('2008', 'year', false, null),
    FilterModel('2009', 'year', false, null),
    FilterModel('2010', 'year', false, null),
    FilterModel('2011', 'year', false, null),
    FilterModel('2012', 'year', false, null),
    FilterModel('2013', 'year', false, null),
    FilterModel('2014', 'year', false, null),
    FilterModel('2015', 'year', false, null),
    FilterModel('2016', 'year', false, null),
    FilterModel('2017', 'year', false, null),
    FilterModel('2018', 'year', false, null),
    FilterModel('2019', 'year', false, null),
    FilterModel('2020', 'year', false, null),
    FilterModel('black', 'color', false, null),
    FilterModel('white', 'color', false, null),
    FilterModel('silver', 'color', false, null),
    FilterModel('blue', 'color', false, null),
    FilterModel('gray', 'color', false, null),
    FilterModel('red', 'color', false, null),
    FilterModel('brown', 'color', false, null),
    FilterModel('green', 'color', false, null),
    FilterModel('beige', 'color', false, null),
    FilterModel('orange', 'color', false, null),
    FilterModel('gold', 'color', false, null),
    FilterModel('yellow', 'color', false, null),
    FilterModel('purple', 'color', false, null),
    FilterModel('1', 'feature', false, FilterIcon.icon_1_02),
    FilterModel('2', 'feature', false, FilterIcon.icon_1_11),
    FilterModel('3', 'feature', false, FilterIcon.icon_1_12),
    FilterModel('4', 'feature', false, FilterIcon.icon_1_13),
    FilterModel('5', 'feature', false, FilterIcon.icon_1_14),
    FilterModel('6', 'feature', false, FilterIcon.icon_1_15),
    FilterModel('7', 'feature', false, FilterIcon.icon_1_16),
    FilterModel('8', 'feature', false, FilterIcon.icon_1_17),
    FilterModel('9', 'feature', false, FilterIcon.icon_2_01),
    FilterModel('10', 'feature', false, FilterIcon.icon_1_17),
    FilterModel('11', 'feature', false, FilterIcon.icon_2_01),
    FilterModel('12', 'feature', false, FilterIcon.icon_2_02),
    FilterModel('13', 'feature', false, FilterIcon.icon_2_03),
    FilterModel('14', 'feature', false, FilterIcon.icon_2_04),
    FilterModel('15', 'feature', false, FilterIcon.icon_2_05),
    FilterModel('16', 'feature', false, FilterIcon.icon_2_06),
    FilterModel('17', 'feature', false, FilterIcon.icon_2_07),
    FilterModel('18', 'feature', false, FilterIcon.icon_2_07),
    FilterModel('19', 'feature', false, FilterIcon.icon_2_07),
    FilterModel('20', 'feature', false, FilterIcon.icon_2_07)];
    height.add(0);
    height.add(0);
    height.add(0);
    height.add(0);
    height.add(0);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
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
                height: 4.v,
              ),
              Text( "Price range",
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: Constant.fontSize,
                    color: Colors.black),),

              SizedBox(
                height: 2.v,
              ),
              SfRangeSlider(
                  min: 100.0,
                  max: 200000.0,
                  values: _values,
                  interval: 49975,
                  showTicks: true,
                  showLabels: true,
                  minorTicksPerInterval: 4,
                onChanged: (SfRangeValues values){
                  setState(() {
                    _values = values;
                  });
                },
              ),
              SizedBox(
                height: 4.v,
              ),

              InkWell(
                onTap: () {
                  changeItemsHeghts(1,9);},
                child: Row(
                  children: [
                    Text( "Brand choose",
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: Constant.fontSize,
                          color: Colors.black),),

                    Expanded(child: SizedBox()),
                    Icon(Icons.arrow_downward_outlined)
                  ],
                ),
              ),
              SizedBox(
                height: 4.v,
              ),
              Wrap(
                    direction: Axis.horizontal,
                    children: Constant.carFilters
                        .where((element) => element.type == 'company')
                        .map((e) {
                      return CarFilterPageItem(model: e,height: height[1]);
                    }).toList(),
                  ),

              InkWell(
                onTap: () {changeItemsHeghts(2,9);},
                child:  Row(
                  children: [
                    Text( "Year choose",
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: Constant.fontSize,
                          color: Colors.black),),

                    Expanded(child: SizedBox()),
                    Icon(Icons.arrow_downward_outlined)
                  ],
                ),
              ),
              SizedBox(
                height: 4.v,
              ),
              Wrap(
                    direction: Axis.horizontal,
                    children: Constant.carFilters
                        .where((element) => element.type == 'year')
                        .map((e) {
                      return CarFilterPageItem(model: e,height:height[2]);
                    }).toList(),
                  ),

              InkWell(
                onTap: () {changeItemsHeghts(3,9);},
                child: Row(
                  children: [
                    Text( "Color choose",
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: Constant.fontSize,
                          color: Colors.black),),

                    Expanded(child: SizedBox()),
                    Icon(Icons.arrow_downward_outlined)
                  ],
                ),
              ),
              SizedBox(
                height: 4.v,
              ),
             Wrap(
                    direction: Axis.horizontal,
                    children: Constant.carFilters
                        .where((element) => element.type == 'color')
                        .map((e) {
                      return CarFilterPageItem(model: e,height:height[3]);
                    }).toList(),
                  ),

              SizedBox(
                height: 4.v,
              ),
              Text( "Seats",
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: Constant.fontSize,
                    color: Colors.black),),
              checkBox("2", 0,seats),
              checkBox("3", 1,seats),
              checkBox("4", 2,seats),
              checkBox("6", 3,seats),
              checkBox("8", 4,seats),
              checkBox("10", 5,seats),

              SizedBox(
                height: 4.v,
              ),

              Text( "Doors",
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: Constant.fontSize,
                    color: Colors.black),),
              checkBox("2", 0,doors),
              checkBox("4", 1,doors),

              SizedBox(
                height: 4.v,
              ),
              Text( "Transmission",
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: Constant.fontSize,
                    color: Colors.black),),
              SizedBox(
                height: 1.v,
              ),
              Center(
                child: Container(
                  height: 12.h,
                  width: 44.v,
                  decoration: BoxDecoration(
                      //color: Color(0xfff3f3f4),
                      borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: ColorApp.primaryColor,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(

                        value: transmission,
                        isDense: true,
                        onChanged: (String newValue) {
                          setState(() {
                            transmission = newValue;
                          });
                        },
                        items: <DropdownMenuItem<String>>[
                          DropdownMenuItem(
                            child: SizedBox(
                                child: Text('Manual')),
                            value: '1',
                          ),
                          DropdownMenuItem(
                            child: Text('Automatic'),
                            value: '0',
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: 4.v,
              ),
              Text( "Insurance",
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: Constant.fontSize,
                    color: Colors.black),),
              SizedBox(
                height: 1.v,
              ),
              Center(
                child: Container(
                  height: 12.h,
                  width: 44.v,
                  decoration: BoxDecoration(
                      //color: Color(0xfff3f3f4),
                      borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: ColorApp.primaryColor,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(

                        value: insurance,
                        isDense: true,
                        onChanged: (String newValue) {
                          setState(() {
                            insurance = newValue;
                          });
                        },
                        items: <DropdownMenuItem<String>>[
                          DropdownMenuItem(
                            child: SizedBox(
                                child: Text('YES')),
                            value: '1',
                          ),
                          DropdownMenuItem(
                            child: Text('NO'),
                            value: '0',
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 6.v,
              ),
              CustomButtonBig(child: Text('Search' , style: TextStyle(color: Colors.white),),color: ColorApp.primaryColor ,clickCallback:f, )


            ],
          ),
        ),
      ),
    );
  }
  void changeItemsHeghts(int index,int h)
  {


    setState(() {
      if(height[index]==0)
      {
        indexes.add(index);
       // CarFilterClickEvent((h+3).h,21.h,indexes);
        (index!=4)?height[index]=(h+3).h:height[index]=22.h;
      }
      else
      {
        indexes.remove(index);
        height[index]=0;
        //CarFilterClickEvent(0,21.h,indexes);
      }

    });


  }
    CarFilterClickEvent(double height1,double height2, List<int> index){


      setState(() {
        if(height==null)
        {
          height=[0,0,0,0,0];
        }
        for(final i in index) {
          if (i != 4)
          {
            height[i] = height1;
          }
          else
          {
            height[4] = height2;
          }
        }
      });


    }

  Function f()
  {
    List<FilterModel>  tempList=[];
    for(final i in Constant.carFilters)
    {
      if(i.active)
        tempList.add(i);
    }

    List<String>  tempList2=[];
    for(int i=0;i<seats.length;i++)
      {
        if(seats[i])
          if(i==0)
            tempList2.add("2");
          else if(i==1)
            tempList2.add("3");
          else
            tempList2.add((i*2).toString());
      }

    List<String>  tempList3=[];
    for(int i=0;i<doors.length;i++)
    {
      if(doors[i])
        if(i==0)
          tempList3.add("2");
        else
          tempList3.add("4");
    }

    Navigator.pop(context,[tempList,currentCity,_values.end,_values.start,tempList2,tempList3,transmission,insurance]);
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

  @override
  void dispose() {
    super.dispose();
  }
}
