import 'dart:convert';
import 'package:path/path.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:realstatefrombegin3/model/object/car.dart';

import 'Constant.dart';
import 'app_exceptions.dart';

class Tools{

  static bool checkResponse(http.Response response){

    if (response.statusCode == 200) {
      final Map body = json.decode(response.body);

      if (body['result'] == 'ok') {
        return true;
      }else if (body['result'] == 'error') {

        throw AppException(body['error']);
        //todo translate persian
      /*  switch(body['message'] as String){

        }*/

        return false;
      }

    }  else{

      return false;
    }

    return false;
  }

  static String getPriceImage(String id){
    return Constant.BASE_IMAGE_ADDRESS + 'cache/cache${id}price.png';
  }

  static void editFavorite(Object object , bool fav){
    if (fav) {
      bool exist=false;
      if(object is MiniCar)
        for(final i in Constant.favorites)
          if(i is MiniCar && i.id==object.id)
            {
              exist=true;
              break;
            }

      else exist = Constant.favorites.contains(object);
      if (!exist) {
        Constant.favorites.add(object);
      }
    }else{
      if(object is MiniCar)
        Constant.favorites.removeWhere((item)=>
          item is MiniCar && item.id==object.id
        );

      else Constant.favorites.remove(object);
    }

  }

  static upload(File imageFile , String address , Map<String , dynamic> data) async {
    var stream = new http.ByteStream(imageFile.openRead());
    var length = await imageFile.length();

    var uri = Uri.parse(Constant.BASE_ADDRESS + address);

    var request = new http.MultipartRequest("POST", uri);
    var multipartFile = new http.MultipartFile('file', stream, length,
        filename: basename(imageFile.path));

    //contentType: new MediaType('image', 'png'));

    request.fields.addAll(data);
    request.files.add(multipartFile);
    var response = await request.send();
    print(response.statusCode);
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });
  }

}