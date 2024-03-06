import 'package:absen_online/utils/general_shared_preferences/general_shared_preferences.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert ;

part 'absen_state.dart';

class AbsenCubit extends Cubit<AbsenState>{
  AbsenCubit() :super(AbsenInitial());

  void actionAbsen(String userId, String date, String time, String type, String location)async{
    try{
      emit(AbsenLoading());
      Map<String, dynamic>    formMap = {
        "user_id": userId,
        "generated_date": date,
        "generated_time": time,
        "type": type,
        // "location": location,
      };

      http.Response response = await http.post(
        // 'https://api.simerahputih.com/absen/user/presence',
        // 'http://47.243.59.72:3024/absen/user/presence',
        // 'http://192.168.18.190:3101/absen/user/presence',
        Uri.parse('http://185.201.9.1:3101/absen/user/presence'),
        body: formMap,
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "x-api-key" : GeneralSharedPreferences.readString("token_login")!
        },
        encoding: convert.Encoding.getByName("utf-8"),
      );
      print("RESPONSE ${response.statusCode} ; BODY = ${response.body}");
      if(convert.jsonDecode(response.body)['meta']['code'] == 201){
        print("success Absen");
        emit(AbsenSucces(convert.jsonDecode(response.body)['meta']['message']));
      } else {
        print("gagal Absen");
        emit(AbsenFailed(convert.jsonDecode(response.body)['meta']['message']));
      }

    }catch (e){
      emit(AbsenError(msg: e.toString()));
    }
  }
}