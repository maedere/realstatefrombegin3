import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realstatefrombegin3/model/NavigationProvider.dart';
import 'package:realstatefrombegin3/util/Constant.dart';
import 'package:realstatefrombegin3/util/size_config.dart';
import 'package:realstatefrombegin3/view/base_navigation.dart';


class MainCatItem extends StatelessWidget {
  final String image;
  final String name;
  final String count;
  final int index;

  MainCatItem(
      {@required this.image, @required this.name, @required this.count , @required this.index});

  @override
  Widget build(BuildContext context) {
    final myModel = Provider.of<NavigationProviderModel>(context, listen: false);

    return GestureDetector(
      onTap: () {

        myModel.changeIndex(index);
        Navigator.push(context, MaterialPageRoute(builder: (context) => BaseNavigation()));
      },
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(Constant.IMAGE_ADDRESS + image),
              fit: BoxFit.fill),
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  shadows: <Shadow>[
                    Shadow(
                        color: Colors.black,
                        blurRadius: 15,
                        offset: Offset(4, 4)),
                    Shadow(
                        color: Colors.black,
                        blurRadius: 15,
                        offset: Offset(-4, -4)),
                  ],
                ),
              ),
              SizedBox(
                height: 1.v,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 0.5.v, horizontal: 5.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(color: Colors.grey[200]),
                ),
                child: Text(
                  '$count items',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    shadows: <Shadow>[
                      Shadow(
                          color: Colors.black,
                          blurRadius: 15,
                          offset: Offset(4, 4)),
                      Shadow(
                          color: Colors.black,
                          blurRadius: 15,
                          offset: Offset(-4, -4)),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
