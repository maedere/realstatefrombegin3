import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:realstatefrombegin3/model/object/car.dart';
import 'package:realstatefrombegin3/model/object/filter.dart';
import 'package:realstatefrombegin3/model/object/home.dart';
import 'package:realstatefrombegin3/model/object/hotel.dart';
import 'package:realstatefrombegin3/util/size_config.dart';



class Constant {
  static StreamController<bool> carController = StreamController<bool>();
  static Stream<bool> updatecarController = carController.stream.asBroadcastStream();

  static StreamController<bool> homeController = StreamController<bool>();
  static Stream<bool> updatehomeController = homeController.stream.asBroadcastStream();


  static final String FONT_ADDRESS = 'assets/fonts/';
  static final String IMAGE_ADDRESS = 'assets/images/';

  static final String url="downloadforever.ir";
  //static final String url="192.168.1.112:6565";
  //todo edit
  //static const String HOST = "http://192.168.1.115:6565/";
  static const String HOST = "saeed/RealEstate/public/api/";
  //static const String HOST = "";
  static const String HOST2 = "http://downloadforever.ir/saeed/RealEstate/public/";
  //static const String HOST2 = "http://192.168.1.112:6565/";
  static const String BASE_ADDRESS = "${HOST}app/";
  static const String BASE_ADDRESS_HOTEL = "${HOST}hotels/";
  static const String BASE_ADDRESS_SUITE = "${HOST}suites/";
  static const String BASE_IMAGE_ADDRESS = "${HOST2}images/";
  static const String BASE_ADDRESS_ADMIN = "${HOST}panel_admin/";
  static const String BASE_ADDRESS_ADMIN1 = "${HOST2}api/panel_admin/";
  static const String BASE_ADDRESS_PANEL = "${HOST}panel/";
  static String token;
  static String userName;
  static LatLng latLng;

  static bool pop=false;

  static int index = 2;

  static bool login = false;
  static String type;

  static List<MiniHome> homes = [];
  static List<MiniHotel> hotels = [];

  static List<Object> favorites = [];

  static List<String> cites = [
    'Dubai',
    'Abu Dhabi',
    'Sharjah',
    'Al Ain',
    'Ajman',
    'RAK City',
    'Fujairah',
    'Umm al-Quwain',
    'Khor Fakkan',
    'Kalba',
    'Jebel Ali',
    'Dibba Al-Fujairah',
    'Madinat Zayed',
    'Ruwais',
    'Liwa Oasis',
    'Dhaid',
    'Ghayathi',
    'Ar-Rams',
    'Dibba Al-Hisn',
    'Hatta',
    '	Al Madam',
    'All'
  ];

  static List<String> bedCounts = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "10",
    "11",
    "12",
    "13",
    "14",
    "15",
    "16",
  ];

  static List<String> types = [
    "Apartment",//apartment 1
    "House"//house 2
  ];


  static List<MiniCar> cars = [];
  static List<FilterModel> carFilters=[];
  static List<FilterModel> homeFilters=[];
  static List<FilterModel> hotelFilters=[];

  static double fontSize= 2.h+1.8.v;


}
