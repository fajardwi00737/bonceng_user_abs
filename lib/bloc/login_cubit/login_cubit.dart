import 'package:absen_online/utils/general_shared_preferences/general_shared_preferences.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert ;

import '../../main.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState>{
  LoginCubit() :super(LoginInitial());


  void login(String email, String password,String fcmToken)async{
    try{
      emit(LoginLoading());

      // client.login(phone, password).then((value){
      Map<String, dynamic>    formMap = {
        "email": email,
        "password": password,
        "fcm_token": fcmToken,
      };

      http.Response response = await http.post(
        'https://api.simerahputih.com/absen/user/login',
        body: formMap,
        headers: {
          "Content-Type": "application/x-www-form-urlencoded"
        },
        encoding: convert.Encoding.getByName("utf-8"),
      );
      print("RESPONSE ${response.statusCode} ; BODY = ${response.body}");
      print("21as "+convert.jsonDecode(response.body)['meta']['code'].toString());
      print("21as "+convert.jsonDecode(response.body)['meta']['message']);
      if(convert.jsonDecode(response.body)['meta']['code'] == 200){
        print("success");
        GeneralSharedPreferences.writeString("token_login", convert.jsonDecode(response.body)['token']);
        GeneralSharedPreferences.writeBool("is_login", true);
        GeneralSharedPreferences.writeInt("user_id", convert.jsonDecode(response.body)['data'][0]['id']);
        GeneralSharedPreferences.writeString("user_name", convert.jsonDecode(response.body)['data'][0]['fullname']);
        GeneralSharedPreferences.writeString("user_mail", convert.jsonDecode(response.body)['data'][0]['email']);
        GeneralSharedPreferences.writeString("user_phone", convert.jsonDecode(response.body)['data'][0]['phone']);
        GeneralSharedPreferences.writeString("user_address", convert.jsonDecode(response.body)['data'][0]['address']);
        GeneralSharedPreferences.writeString("fcm_token", convert.jsonDecode(response.body)['data'][0]['fcm_token']);

        http.Response response2 = await http.get(
          'https://api.simerahputih.com/absen/admin/detail_divisi?id='+convert.jsonDecode(response.body)['data'][0]['divisi_id'].toString(),
          headers: {
            "x-api-key" : GeneralSharedPreferences.readString("token_login")
          },
        );

        GeneralSharedPreferences.writeString("user_divisi", convert.jsonDecode(response2.body)['data']['name']);
        emit(LoginSucces());
      } else {
        print("gagal");
        emit(LoginFailed(convert.jsonDecode(response.body)['meta']['message']));
      }
      // });
    }catch(e){
      emit(LoginError(msg: e.toString()));
    }
  }
}