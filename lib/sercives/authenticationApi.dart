


import 'package:realstatefrombegin3/util/Constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'base_service.dart';

class AuthenticationApi {

  static Future<String> login(typUser,email, passsword,key) async {


    final Map<String, dynamic> data = {
      'role': typUser,
      'email': email,
      'password': passsword,
    };
    final res = await patternAll(Constant.BASE_ADDRESS_ADMIN+"login",key,false,data: data);
    if(res["result"]=="ok")
      {
        Constant.login=true;
        Constant.type=typUser;

        SharedPreferences preferences = await SharedPreferences.getInstance();
        switch (Constant.type) {
          case 'company':
            Constant.token = res['company']['token'];
            await preferences.setString('token',res['company']['token']);
            Constant.userName=res['company']['email'];
            //todo fill company
            break;
          case 'agent':
            Constant.token = res['agent']['token'];
            await  preferences.setString('token', res['agent']['token']);
            Constant.userName=res['agent']['email'];
            //todo fill agent
            break;
          case 'user':
            Constant.token = res['user']['Token'];
            await  preferences.setString('token',res['user']['Token']);
            Constant.userName=res['user']['Email'];
            //todo fill user
            break;
        }
      }

    return res["result"];
  }
  static Future<String> singUp(typUser,email, passsword,phone,name,key) async {
    final Map<String, dynamic> data = {
      'role': typUser,
      'email':email,
      'password':passsword,
      'phone' : phone,
      'name' : name
    };

    final res = await patternAll(Constant.BASE_ADDRESS+"register",key,false,data: data);
    if(res["result"]=="ok")
    {
      Constant.login=true;
      Constant.type=typUser;

      SharedPreferences preferences = await SharedPreferences.getInstance();
      switch (Constant.type) {
        case 'company':
          Constant.token = res['company']['token'];
          await preferences.setString('token',res['company']['token']);
          Constant.userName=res['company']['email'];
          //todo fill company
          break;
        case 'user':
          Constant.token = res['user']['Token'];
          await  preferences.setString('token',res['user']['Token']);
          Constant.userName=res['user']['Email'];
          //todo fill user
          break;
        case 'agent':
          Constant.token = res['agent']['token'];
          await  preferences.setString('token',res['agent']['token']);
          Constant.userName=res['agent']['email'];
          //todo fill user
          break;
      }
    }

    return res["result"];
  }

}

