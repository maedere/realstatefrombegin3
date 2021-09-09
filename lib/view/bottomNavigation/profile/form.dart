import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:realstatefrombegin3/util/Constant.dart';
import 'package:realstatefrombegin3/util/size_config.dart';


import 'package:http/http.dart' as http;
import 'package:realstatefrombegin3/values/color_app.dart';
import 'package:realstatefrombegin3/view/floatingActionButton/choose_location.dart';
import 'package:realstatefrombegin3/widget/custom/button.dart';

class FormPage extends StatefulWidget {
  final String type;
  static const String ADDRESS = 'profile/form_page';

  FormPage({@required this.type});

  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController countryController = TextEditingController();

  TextEditingController addressController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController bedroomController = TextEditingController();
  TextEditingController bathroomController = TextEditingController();
  TextEditingController desController = TextEditingController();
  TextEditingController sizeController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController yearBuiltController = TextEditingController();
  TextEditingController garageCapacityController = TextEditingController();

  TextEditingController controllerDoor = TextEditingController();
  TextEditingController controllerSeat = TextEditingController();
  TextEditingController controllerPower = TextEditingController();
  TextEditingController controllerOdometer = TextEditingController();
  TextEditingController controllerYear = TextEditingController();
  TextEditingController controllerCompanyName = TextEditingController();
  TextEditingController controllerModel = TextEditingController();
  TextEditingController controllerColor = TextEditingController();
  TextEditingController controllerPhone = TextEditingController();
  TextEditingController controllerAgeLimit = TextEditingController();
  TextEditingController controller = TextEditingController();
  TextEditingController controllerCost = TextEditingController();
  TextEditingController controllerLimitDistance = TextEditingController();

  List<File> images = [];
  File imageAgent;

  String catProperty = 'buy';

  int valueInsurance = 0;
  int valueType = 1;
  int valueTrans = 0;//auto , manual
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool isLoading=false;
  @override
  void initState() {
    Constant.latLng=LatLng(25.23333456111011, 55.41756201535463);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Constant.type.contains("company")
        ? _formAgent()
        : Constant.type.contains("user")
        ? _formCar()
            : _formHome();
  }

  //types
  //agent
  Widget _formAgent() {

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
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: SizeConfig.blockSizeVertical * 3,
            ),
            Icon(
              Icons.person_pin,
              size: SizeConfig.blockSizeHorizontal * 20,
              color: ColorApp.primaryColor,
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * .5,
            ),
            Text(
              "add Agent",
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 4,
            ),
            _formField(controller: usernameController, text: 'username'),
            _formField(controller: passwordController, text: 'password'),
            _formField(controller: mobileController, text: 'name', ),
            _formField(controller: countryController, text: 'country'),
            _formField(controller: controllerPhone, text: 'phone',num: true),
            Row(
              children: [
                SizedBox(
                  width: SizeConfig.blockSizeHorizontal * 5,
                ),
                Container(
                  width: SizeConfig.blockSizeHorizontal * 12,
                  height: SizeConfig.blockSizeHorizontal * 12,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: imageAgent == null
                              ? AssetImage(
                                  Constant.IMAGE_ADDRESS + 'person.png')
                              : FileImage(imageAgent))),
                ),
                Expanded(child: SizedBox()),
                GestureDetector(
                  onTap: () async {
                    final _picker = ImagePicker();
                    final pickedFile =
                        await _picker.getImage(source: ImageSource.gallery);
                    setState(() {
                      if (pickedFile != null) {
                        imageAgent = File(pickedFile.path);
                      } else {
                        print('No image selected.');
                      }
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(
                        vertical: SizeConfig.blockSizeVertical),
                    width: SizeConfig.blockSizeHorizontal * 40,
                    padding: EdgeInsets.symmetric(
                        vertical: SizeConfig.blockSizeVertical),
                    decoration: BoxDecoration(
                      color: ColorApp.primaryColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Center(
                        child: Text(
                      'Select Image',
                      style: TextStyle(color: Colors.white),
                    )),
                  ),
                ),
                SizedBox(
                  width: SizeConfig.blockSizeHorizontal * 5,
                )
              ],
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 5,
            ),
            _submitButton(context, 'agent'),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 5,
            ),
          ],
        ),
      ),
    );
  }

  //property
  Widget _formHome() {
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
      key: _scaffoldKey,
      body: SingleChildScrollView(


        child: Column(
          children: [
            SizedBox(
              height: SizeConfig.blockSizeVertical * 3,
            ),
            Icon(
              Icons.home,
              size: SizeConfig.blockSizeHorizontal * 25,
              color: ColorApp.primaryColor,
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * .5,
            ),
            Text(
              "add Home",
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 3,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.blockSizeHorizontal * 5,
                  vertical: SizeConfig.blockSizeVertical),
              child: DropdownButtonFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    fillColor: Color(0xfff3f3f4),
                    filled: true),
                value: catProperty,
                items: <DropdownMenuItem<String>>[
                  DropdownMenuItem(
                    child: Text('Buy'),
                    value: 'buy',
                  ),
                  DropdownMenuItem(
                    child: Text('Rent'),
                    value: 'rent',
                  ),
                  DropdownMenuItem(
                    child: Text('Commercial'),
                    value: 'commercial',
                  ),
                ],
                onChanged: (value) {
                  catProperty = value;
                },
              ),
            ),
            _formField(controller: nameController, text: 'name'),
            _formField(
                controller: bathroomController, text: 'bathroom', num: true),
            _formField(
                controller: bedroomController, text: 'bedroom', num: true),
            _formField(controller: priceController, text: 'price', num: true),
            _formField(controller: addressController, text: 'address'),
            _formField(controller: desController, text: 'description'),
            _formField(controller: sizeController, text: 'size (foot)'),
            //_formField(controller: sizeController, text: 'type'),
            _formField(controller: cityController, text: 'city'),
            _formField(controller: yearBuiltController, text: 'year built'),
            _formField(controller: garageCapacityController, text: 'garage capacity'),
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: SizeConfig.blockSizeHorizontal * 5,
                  vertical: SizeConfig.blockSizeVertical),
              child: Row(
                children: [
                  Expanded(
                      flex: 2,
                      child: Text(
                        'type',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      )),
                  Expanded(flex: 1, child: SizedBox()),
                  Expanded(
                    flex: 4,
                    child: DropdownButtonFormField<int>(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          fillColor: Color(0xfff3f3f4),
                          filled: true),
                      onChanged: (e){
                        setState(() {
                          valueType = e;
                        });
                      },
                      value: valueType,
                      items: [
                        DropdownMenuItem(child: Text("Apartment") , value: 1,),
                        DropdownMenuItem(child: Text("House") , value: 2,),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Container(
              width: 50.v,
              height: 50.v,
              child: ChooseLocation(),
            ),
            SizedBox(height: 5.h,),

            GestureDetector(
              onTap: () async {
                final _picker = ImagePicker();
                final pickedFile =
                    await _picker.getImage(source: ImageSource.gallery);
                setState(() {
                  if (pickedFile != null) {
                    images.add(File(pickedFile.path));
                  } else {
                    print('No image selected.');
                  }
                });
              },
              child: Container(
                margin: EdgeInsets.symmetric(
                    vertical: SizeConfig.blockSizeVertical),
                width: SizeConfig.blockSizeHorizontal * 50,
                padding: EdgeInsets.symmetric(
                    vertical: SizeConfig.blockSizeVertical),
                decoration: BoxDecoration(
                  color: ColorApp.primaryColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                    child: Text(
                  'Select Image',
                  style: TextStyle(color: Colors.white),
                )),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: images.map((e) {
                  return Column(
                    children: [
                      Container(
                          width: SizeConfig.blockSizeHorizontal * 30,
                          height: SizeConfig.blockSizeVertical * 10,
                          margin: EdgeInsets.symmetric(
                              horizontal: SizeConfig.blockSizeHorizontal * 3),
                          child: Image.file(e)),
                      Positioned(
                        bottom: -10,
                        right: 50,
                        child: InkWell(child: Icon(Icons.delete_forever,size: 5.h,),
                          onTap: (){
                            setState(() {
                              images.remove(e);

                            });
                          },),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
            //for feather use choose and create one item
            SizedBox(
              height: SizeConfig.blockSizeVertical * 5,
            ),
            _submitButton(context, 'property'),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 5,
            ),
          ],
        ),
      ),
    );
  }

  //userAddCar
  Widget _formCar() {
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
      key: _scaffoldKey,
      body: SingleChildScrollView(

        child: Column(
          children: [
            SizedBox(
              height: SizeConfig.blockSizeVertical * 3,
            ),
            Icon(
              Icons.directions_car_rounded,
              size: SizeConfig.blockSizeHorizontal * 25,
              color: ColorApp.primaryColor,
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * .5,
            ),
            Text(
              "Add Car",
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 3,
            ),
            _formField(controller: controllerCompanyName, text: 'name company'),
            _formField(controller: controllerModel, text: 'model'),
            _formField(controller: controllerYear, text: 'year', num: true),
            _formField(controller: controllerSeat, text: 'seats', num: true),
            _formField(controller: controllerDoor, text: 'doors', num: true),
            _formField(controller: controllerPower, text: 'power', num: true),
            _formField(controller: controllerOdometer, text: 'odometer', num: true),
        Container(
          margin: EdgeInsets.symmetric(
              horizontal: SizeConfig.blockSizeHorizontal * 5,
              vertical: SizeConfig.blockSizeVertical),
          child: Row(
            children: [
              Expanded(
                  flex: 2,
                  child: Text(
                    'insurance',
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  )),
              Expanded(flex: 1, child: SizedBox()),
              Expanded(
                flex: 4,
                child: DropdownButtonFormField<int>(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        fillColor: Color(0xfff3f3f4),
                        filled: true),
                  onChanged: (e){
                      setState(() {
                        valueInsurance = e;
                      });
                  },
                  value: valueInsurance,
                  items: [
                    DropdownMenuItem(child: Text("NO") , value: 0,),
                    DropdownMenuItem(child: Text("YES") , value: 1,),
                  ],
                ),
              ),
            ],
          ),
        ),
            _formField(controller: desController, text: 'description'),
            _formField(controller: addressController, text: 'address'),
            _formField(controller: cityController, text: 'city'),
            _formField(controller: controllerCost, text: 'price', num: true),
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: SizeConfig.blockSizeHorizontal * 5,
                  vertical: SizeConfig.blockSizeVertical),
              child: Row(
                children: [
                  Expanded(
                      flex: 2,
                      child: Text(
                        'transmission',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      )),
                  Expanded(flex: 1, child: SizedBox()),
                  Expanded(
                    flex: 4,
                    child: DropdownButtonFormField<int>(

                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          fillColor: Color(0xfff3f3f4),
                          filled: true),
                      onChanged: (e){
                        setState(() {
                          valueTrans = e;

                        });
                      },
                      value: valueTrans,
                      items: [
                        DropdownMenuItem(child: Text("Automatic") , value: 0,),
                        DropdownMenuItem(child: Text("Manual") , value: 1,),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            _formField(
                controller: controllerLimitDistance,
                text: 'limit distance(KM)',
                num: true),
            _formField(
                controller: controllerAgeLimit, text: 'age limit', num: true),
            _formField(controller: controllerColor, text: 'color'),
            _formField(controller: controllerPhone, text: 'phone number'),

            Container(
              width: 50.v,
              height: 50.v,
              child: ChooseLocation(),
            ),
            SizedBox(height: 5.h,),

            GestureDetector(
              onTap: () async {

                final _picker = ImagePicker();
                final pickedFile =
                    await _picker.getImage(source: ImageSource.gallery);
                setState(() {
                  if (pickedFile != null) {
                    images.add(File(pickedFile.path));
                  } else {
                    print('No image selected.');
                  }
                });
              },
              child: Container(
                margin: EdgeInsets.symmetric(
                    vertical: SizeConfig.blockSizeVertical),
                width: SizeConfig.blockSizeHorizontal * 50,
                padding: EdgeInsets.symmetric(
                    vertical: SizeConfig.blockSizeVertical),
                decoration: BoxDecoration(
                  color: ColorApp.primaryColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                    child: Text(
                  'Select Image',
                  style: TextStyle(color: Colors.white),
                )),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: images.map((e) {
                  return Column(
                    children: [
                      Container(
                          width: SizeConfig.blockSizeHorizontal * 30,
                          height: SizeConfig.blockSizeVertical * 10,
                          margin: EdgeInsets.symmetric(
                              horizontal: SizeConfig.blockSizeHorizontal * 3),
                          child: Image.file(e)),
                      Positioned(
                        bottom: -10,
                        right: 50,
                        child: InkWell(child: Icon(Icons.delete_forever,size: 5.h,),
                          onTap: (){
                          setState(() {
                            images.remove(e);

                          });
                        },),
                      ),

                    ],
                  );
                }).toList(),
              ),
            ),
            //for feather use choose and create one item
            SizedBox(
              height: SizeConfig.blockSizeVertical * 5,
            ),
            _submitButton(context, 'car'),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 5,
            ),
          ],
        ),
      ),
    );
  }

  //customs
  Widget _formField(
      {TextEditingController controller, String text, bool num = false}) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: SizeConfig.blockSizeHorizontal * 5,
          vertical: SizeConfig.blockSizeVertical),
      child: Row(
        children: [
          Expanded(
              flex: 2,
              child: Text(
                text,
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              )),
          Expanded(flex: 1, child: SizedBox()),
          Expanded(
            flex: 4,
            child: Container(
              height: SizeConfig.blockSizeVertical * 6,
              child: TextField(
                controller: controller,
                keyboardType: num ? TextInputType.number : TextInputType.text,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    fillColor: Color(0xfff3f3f4),
                    focusColor: ColorApp.accentColor,
                    filled: true),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _submitButton(BuildContext context, String type) {
    return
      Padding(
        padding:  EdgeInsets.only(left: 5.v,right: 5.v),
        child: CustomButtonBig(child: isLoading
            ? Container(
          width: 1.v,
            height: 1.v,
            child: CircularProgressIndicator(strokeWidth: .5,))
            :Text('CONFIRM' , style: TextStyle(color: Colors.white),),color: ColorApp.primaryColor ,clickCallback:(){
          type == 'agent'
              ? _addAgent(context)
              : type == 'property'
              ? _addProperty(context)
              : _addCar(context);
        }),
      );

  }

  void _addProperty(BuildContext context) async {

    if(nameController.text.isNotEmpty && priceController.text.isNotEmpty && sizeController.text.isNotEmpty && bedroomController.text.isNotEmpty &&
        bathroomController.text.isNotEmpty && desController.text.isNotEmpty && addressController.text.isNotEmpty && bathroomController.text.isNotEmpty &&
        cityController.text.isNotEmpty && yearBuiltController.text.isNotEmpty && garageCapacityController.text.isNotEmpty)
   {
     setState(() {
     isLoading=true;
    });
     var uri = Uri.parse(Constant.BASE_ADDRESS_ADMIN1 + 'createProperty');
    var request = http.MultipartRequest('POST', uri)
      ..fields['name'] = nameController.text.trim()
      //todo bejai mobile .. name taraft
      ..fields['price'] = priceController.text.trim()
      ..fields['size'] = sizeController.text.trim()
      ..fields['bedroom'] = bedroomController.text.trim()
      ..fields['bathroom'] = bathroomController.text.trim()
      ..fields['description'] = desController.text
      ..fields['address'] = addressController.text
      ..fields['category'] = catProperty
      ..fields['type'] = valueType.toString()
      ..fields['bathroom'] = bathroomController.text.trim()
      ..fields['token'] = Constant.token
      ..fields['lat'] = Constant.latLng.latitude.toString()
      ..fields['lng'] = Constant.latLng.longitude.toString()
      ..fields['city'] = cityController.text
      ..fields['garage_capacity'] = garageCapacityController.text
      ..fields['year_built'] = yearBuiltController.text
      ..fields['due_date'] = "123";

    //files after
    if(images.length!=0)
      request.files.add(await http.MultipartFile.fromPath(
        'image0',
        images[0].path,
      ));
    var response = await request.send();
    print(request.toString());
    print(request);
    final respStr = await response.stream.bytesToString();
    var res=jsonDecode(respStr);
    print(res);
     setState(() {
       isLoading=false;
     });
     if (res["result"] == "ok")
       Navigator.pop(context);
   }
    else
      _scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text("Please fill in all the items")));

  }

  void _addAgent(BuildContext context) async {
    if(usernameController.text.isNotEmpty && mobileController.text.isNotEmpty && countryController.text.isNotEmpty && passwordController.text.isNotEmpty && controllerPhone.text.isNotEmpty && imageAgent!=null)
    {
      setState(() {
        isLoading=true;
      });
      var uri = Uri.parse(Constant.BASE_ADDRESS_ADMIN1 + 'addAgent');
    var request = http.MultipartRequest('POST', uri)
      ..fields['email'] = usernameController.text.trim()
      //todo bejai mobile .. name taraft
      ..fields['name'] = mobileController.text
      ..fields['type'] = 'file'
      ..fields['country'] = countryController.text
      ..fields['password'] = passwordController.text
      ..fields['token'] = Constant.token
      ..fields['phone'] = controllerPhone.text;
    if(imageAgent!=null)
      request.files.add(await http.MultipartFile.fromPath(
        'image',
        imageAgent.path,
      ));


    var response = await request.send();
    final respStr = await response.stream.bytesToString();
    var res=jsonDecode(respStr);
    print(res);
      setState(() {
        isLoading=false;
      });
    if (res["result"] == "ok")
      Navigator.pop(context);}
    else
      _scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text("Please fill in all the items")));


  }

  void _addCar(BuildContext context) async {

    if(controllerDoor.text.isNotEmpty && controllerSeat.text.isNotEmpty && controllerPower.text.isNotEmpty && controllerOdometer.text.isNotEmpty &&
        controllerYear.text.isNotEmpty && controllerCompanyName.text.isNotEmpty && controllerModel.text.isNotEmpty && controllerColor.text.isNotEmpty &&
        controllerAgeLimit.text.isNotEmpty && controllerCost.text.isNotEmpty && desController.text.isNotEmpty &&  addressController.text.isNotEmpty &&
        controllerLimitDistance.text.isNotEmpty && controllerPhone.text.isNotEmpty && cityController.text.isNotEmpty) {
      setState(() {
        isLoading=true;
      });
      var uri = Uri.parse(
          Constant.BASE_ADDRESS_ADMIN1 + 'createCarWithoutVIN');
      //var uri = Uri.parse("http://downloadforever.ir/saeed/RealEstate/public/api/panel_admin/createCarWithoutVIN" );


      print(Constant.token);
      var request = http.MultipartRequest('POST', uri)
        ..fields['door'] = controllerDoor.text.trim()
        ..fields['seat'] = controllerSeat.text.trim()
        ..fields['power'] = controllerPower.text.trim()
        ..fields['odometer'] = controllerOdometer.text
        ..fields['year'] = controllerYear.text.trim()
        ..fields['company'] = controllerCompanyName.text
        ..fields['model'] = controllerModel.text
        ..fields['color'] = controllerColor.text
        ..fields['age_limit'] = controllerAgeLimit.text.trim()
        ..fields['cost'] = controllerCost.text.trim()
        ..fields['description'] = desController.text
        ..fields['address'] = addressController.text
        ..fields['city'] = cityController.text
        ..fields['limit_distance'] = controllerLimitDistance.text
        ..fields['transmission'] = valueTrans.toString()
        ..fields['insurance'] = valueInsurance.toString()
        ..fields['lat'] = Constant.latLng.latitude.toString()
        ..fields['lng'] = Constant.latLng.longitude.toString()
        ..fields['token'] = Constant.token
        ..fields['phone'] = controllerPhone.text
        ..fields['isAvailable'] = "1"
        ..fields['type'] = 'file';
      for (int i = 0; i < images.length; i++) {
        print(images[i].path);
        request.files.add(await http.MultipartFile.fromPath(
          'image' + i.toString(),
          images[i].path,
        ));
      }


      print(request.toString());
      print(request);

      var response = await request.send();
      final respStr = await response.stream.bytesToString();
      var res = jsonDecode(respStr);
      setState(() {
        isLoading=false;
      });
      if (res["result"] == "ok")
        Navigator.pop(context);
    }else {

      _scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text("Please fill in all the items")));

    }

  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    mobileController.dispose();
    countryController.dispose();
    addressController.dispose();
    nameController.dispose();
    priceController.dispose();
    desController.dispose();
    bedroomController.dispose();
    bathroomController.dispose();
    sizeController.dispose();
    controllerColor.dispose();
    controllerPhone.dispose();
    controllerAgeLimit.dispose();
    controllerLimitDistance.dispose();
    controllerCost.dispose();
    controllerPower.dispose();
    controllerDoor.dispose();
    controllerSeat.dispose();
    controllerYear.dispose();
    controllerModel.dispose();
    controllerCompanyName.dispose();
    controllerOdometer.dispose();
    super.dispose();
  }
}
