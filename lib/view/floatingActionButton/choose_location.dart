




import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:realstatefrombegin3/util/Constant.dart';
import 'package:realstatefrombegin3/values/color_app.dart';
import 'package:realstatefrombegin3/util/size_config.dart';
import 'dart:ui' as ui;

class ChooseLocation extends StatefulWidget {


  ChooseLocation();

  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Map<MarkerId, Marker> _markers = <MarkerId, Marker>{};
  int _markerIdCounter = 0;
  Completer<GoogleMapController> _controller = Completer();
  LatLng showLoc;
  Marker marker;

  //center pos
  CameraPosition centerLatLng;

  final myController = TextEditingController();

  Uint8List customIcon;

  Future<void> goCurrentLocation() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(showLoc.latitude, showLoc.longitude),
      zoom: 15.4746,
    )));
  }

  //todo handle
  void _getLocation() async {
    var currentLoc = await Geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best);

    goCurrentLocation();

/*    setState(() {
      showLoc = new LatLng(currentLoc.latitude, currentLoc.longitude);
    });*/
  }

  createMarket(BuildContext context) {

    if (customIcon == null) {
      /*ImageConfiguration imageConfiguration =
      createLocalImageConfiguration(context);
      BitmapDescriptor.fromAssetImage(
          imageConfiguration, 'assets/images/location.png')
          .then((value) => setState(() {
        customIcon = value;
      }));*/

      getBytesFromAsset('assets/images/location.png', 80).then((value) {
        customIcon=value;
      });
    }
  }
  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png)).buffer.asUint8List();
  }
  @override
  void initState() {
    showLoc = Constant.latLng;
    _getLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    createMarket(context);
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMap(
              myLocationButtonEnabled: true,
              zoomControlsEnabled: false,
              markers: Set<Marker>.of(_markers.values),
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: showLoc,
                zoom: 15.5,
              ),
              myLocationEnabled: true,
              onCameraMove: (CameraPosition position) {
                centerLatLng = position;
                Constant.latLng=position.target;
                if (_markers.length > 0) {
                  MarkerId markerId = MarkerId(_markerIdVal());
                  Marker marker = _markers[markerId];
                  Marker updatedMarker = marker.copyWith(
                    positionParam: position.target,
                  );
                  setState(() {
                    _markers[markerId] = updatedMarker;
                  });
                }
              },
              gestureRecognizers: Set()
                ..add(Factory<EagerGestureRecognizer>(
                        () => EagerGestureRecognizer())),
            ),

          ],
        ),
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) async {
    _controller.complete(controller);
    if (showLoc != null) {
      MarkerId markerId = MarkerId(_markerIdVal());
      LatLng position = showLoc;
      Marker marker = Marker(
        markerId: markerId,
        position: position,
        icon: BitmapDescriptor.fromBytes(customIcon),
        draggable: false,
      );

      setState(() {
        _markers[markerId] = marker;
      });

      Future.delayed(Duration(seconds: 1), () async {
        GoogleMapController controller = await _controller.future;
        controller.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: position,
              zoom: 15.0,
            ),
          ),
        );
      });
    }
  }

  String _markerIdVal({bool increment = false}) {
    String val = 'marker_id_$_markerIdCounter';
    if (increment) _markerIdCounter++;
    return val;
  }


  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  _submitLocation(BuildContext context) async {
    print(centerLatLng.target.latitude);
    print(centerLatLng.target.longitude);

  }
}
