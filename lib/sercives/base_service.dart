import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:realstatefrombegin3/util/Constant.dart';
import 'package:realstatefrombegin3/util/app_exceptions.dart';
import 'package:http/http.dart' as http;

import 'package:realstatefrombegin3/util/size_config.dart';

final _HOST = "https://downloadforever.ir/saeed/RealEstate/public/api/panel/";

Future<Map<String, dynamic>> patternAll(String url,key,bool isGetReq,
    {Map<String, dynamic> data = const <String, dynamic>{},
    bool haveToken = false}) async {

  if (haveToken) {
    //data['token'] = Constant.user.token;
  }
  Response response;

  final queryParameters = {
    'range': '0',
  };
  if(isGetReq)
         {  response = await get(Uri.http(Constant.url, '$url',data),
          //Response response = await post(Uri.http("192.168.1.121:6565",'$url'),
           headers: {'Content-Type': 'application/json','accessToken':'TRPCoAu2BLN1qf2JOkkpYy5jRfWCPtDyQvAfm9BX20FJMipFH5pZkRXX95D9UD3FCftzmkczkgEZRs9E'});
           print("************");
           print(response);
     }
  else
     response = await post(Uri.http(Constant.url, '$url'),
        //Response response = await post(Uri.http("192.168.1.121:6565",'$url'),
        body: json.encode(data), headers: {'Content-Type': 'application/json','accessToken':'TRPCoAu2BLN1qf2JOkkpYy5jRfWCPtDyQvAfm9BX20FJMipFH5pZkRXX95D9UD3FCftzmkczkgEZRs9E'});



  //todo debug
  log(data.toString(), name: 'data request', time: DateTime.now());
  log(response.body, name: 'response request', time: DateTime.now());
  print(Constant.url+'$url');


  if (checkResponse(response,key)) {
    return json.decode(response.body);
  } else {
    throw AppException('unexceptional error');
  }
}

Future<Map<String, dynamic>> patternWithFile(String url,
    {File file,
    Map<String, dynamic> data = const <String, dynamic>{},
    bool isNeedValidation = true}) async {
  if (isNeedValidation) {
    //data['token'] = Constant.user.token;
  }

  var request = new MultipartRequest("POST", Uri.parse("$_HOST$url"));

  request.fields['data'] = json.encode(data);

  if (file != null) {
    request.files.add(await MultipartFile.fromPath(
      'file',
      file.path,
    ));
  }

  StreamedResponse response = await request.send();
  final respStr = await response.stream.bytesToString();
  final Map body = json.decode(respStr);

  //todo debug
  print('data to send : $data \n');
  print(
      "response of $url : statusCode->${response.statusCode} \n body->$respStr");

  if (body['result'] == 'ok') {
    return body;
  } else if (body.containsKey('result')) {
    throw AppException(body['result']);
  } else {
    throw AppException(response.statusCode);
  }
}

bool checkResponse(Response response,key) {

  if (response.statusCode == 200) {
    final Map body = json.decode(response.body);

    if (body['result'] == 'ok') {
      return true;
    } else if (body['result'] == 'error') {
      Scaffold.of(key).showSnackBar(SnackBar(content: Container(height: 5.v,child: Center(child : Text(body['error'])),),),);
      //throw AppException(body['message']);
      return true;
    }
  } else {

    throw AppException(response.statusCode);
  }
  return false;
}
