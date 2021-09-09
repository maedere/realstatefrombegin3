
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intro_slider/dot_animation_enum.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:realstatefrombegin3/values/color_app.dart';
import 'package:realstatefrombegin3/util/size_config.dart';
import 'package:realstatefrombegin3/view/main_cat_choose.dart';

class IntroScreen extends StatefulWidget{
  @override
  IntroScreenState createState() => IntroScreenState();
}
class IntroScreenState extends State<IntroScreen> {
  List<Slide> slides = new List();

  Function goToTab;

  @override
  void initState() {
    super.initState();
    slides.add(
      new Slide(
        title: "SCHOOL",
        styleTitle:
        TextStyle(color: ColorApp.primaryColor, fontSize: 22.0, fontWeight: FontWeight.bold),
        description:
        "Do you have Real Properties you want to Sell?",
        styleDescription:
        TextStyle(color: ColorApp.tosiColor, fontSize: 20.0, fontStyle: FontStyle.italic),
        pathImage: "assets/gifs/g1.gif",
      ),
    );
    slides.add(
      new Slide(
        title: "MUSEUM",
        styleTitle:
        TextStyle(color: ColorApp.primaryColor, fontSize: 22.0, fontWeight: FontWeight.bold),
        description: "Do you want to upgrade your old Real Properties?",
        styleDescription:
        TextStyle(color: ColorApp.tosiColor, fontSize: 20.0, fontStyle: FontStyle.italic),
        pathImage: "assets/gifs/g2.gif",
      ),
    );
    slides.add(
      new Slide(
        title: "COFFEE SHOP",
        styleTitle:
        TextStyle(color: ColorApp.primaryColor, fontSize: 22.0, fontWeight: FontWeight.bold),
        description:
        "Are you looking for a New Place to buy?",
        styleDescription:
        TextStyle(color: ColorApp.tosiColor, fontSize: 20.0, fontStyle: FontStyle.italic),
        pathImage: "assets/gifs/g3.gif",
      ),
    );
    slides.add(
      new Slide(
        title: "COFFEE SHOP",
        styleTitle:
        TextStyle(color: ColorApp.primaryColor, fontSize: 22.0, fontWeight: FontWeight.bold),
        description:
        "Are you looking for a new space to rent?",
        styleDescription:
        TextStyle(color: ColorApp.tosiColor, fontSize: 20.0, fontStyle: FontStyle.italic),
        pathImage: "assets/gifs/g4.gif",
      ),
    );


  }

  void onDonePress() {
   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainCatChoose(),));
  }

  void onTabChangeCompleted(index) {
    // Index of current tab is focused
  }

  Widget renderNextBtn() {
    return Icon(
      Icons.navigate_next,
      color: ColorApp.accentColor,
      size: 35.0,
    );
  }

  Widget renderDoneBtn() {
    return Icon(
      Icons.done,
      color: ColorApp.accentColor,
    );
  }

  Widget renderSkipBtn() {
    return Icon(
      Icons.skip_next,
      color: ColorApp.accentColor,
    );
  }

  List<Widget> renderListCustomTabs() {
    List<Widget> tabs = new List();
    for (int i = 0; i < slides.length; i++) {
      Slide currentSlide = slides[i];
      tabs.add(Container(
        width: double.infinity,
        height: double.infinity,
        child: Container(
          margin: EdgeInsets.only(bottom: 60.0, top: 60.0),
          child: ListView(
            children: <Widget>[
              GestureDetector(
                  child: Image.asset(
                    currentSlide.pathImage,
                    width: 40.v,
                    height: 40.v,
                    fit: BoxFit.contain,
                  )),
              SizedBox(height: 5.v,),
              Container(
                child: Text(
                 //todo  currentSlide.title,
                  currentSlide.description,
                  style: currentSlide.styleTitle,
                  textAlign: TextAlign.center,
                ),
                margin: EdgeInsets.only(top: 20.0,left: 6.v,right: 6.v),
              ),

            ],
          ),
        ),
      ));
    }
    return tabs;
  }

  @override
  Widget build(BuildContext context) {
    return new IntroSlider(
      // List slides
      slides: this.slides,

      // Skip button
      renderSkipBtn: this.renderSkipBtn(),
      colorSkipBtn: ColorApp.primaryColor,
      highlightColorSkipBtn: ColorApp.accentColor,

      // Next button
      renderNextBtn: this.renderNextBtn(),

      // Done button
      renderDoneBtn: this.renderDoneBtn(),
      onDonePress: this.onDonePress,
      colorDoneBtn: ColorApp.primaryColor,
      highlightColorDoneBtn: ColorApp.accentColor,

      // Dot indicator
      colorDot: ColorApp.accentColor,
      sizeDot: 10.0,
      typeDotAnimation: dotSliderAnimation.SIZE_TRANSITION,

      // Tabs
      listCustomTabs: this.renderListCustomTabs(),
      backgroundColorAllSlides: Colors.white,
      refFuncGoToTab: (refFunc) {
        this.goToTab = refFunc;
      },

      // Show or hide status bar
      //shouldHideStatusBar: false,

      // On tab change completed
      onTabChangeCompleted: this.onTabChangeCompleted,
    );
  }
}