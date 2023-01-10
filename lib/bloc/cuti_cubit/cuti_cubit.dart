import 'package:absen_online/utils/general_shared_preferences/general_shared_preferences.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert ;

part 'cuti_state.dart';

class CutiCubit extends Cubit<CutiState>{
  CutiCubit() :super(CutiInitial());

  void actionCuti(String startDate, String endtDate, String reason)async{
    try{
      emit(CutiLoading());
      Map<String, dynamic>    formMap = {
        "start_date": startDate,
        "start_time": "08:00:00",
        "end_date": endtDate,
        "end_time": "08:00:00",
        "reason": reason,
      };

      http.Response response = await http.post(
        'https://api.simerahputih.com/absen/user/cuti',
        body: formMap,
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "x-api-key" : GeneralSharedPreferences.readString("token_login")
        },
        encoding: convert.Encoding.getByName("utf-8"),
      );
      print("RESPONSE ${response.statusCode} ; BODY = ${response.body}");
      if(convert.jsonDecode(response.body)['meta']['code'] == 201){
        print("success Cuti");
        emit(CutiSucces(convert.jsonDecode(response.body)['meta']['message']));
      } else {
        print("gagal Cuti");
        emit(CutiFailed(convert.jsonDecode(response.body)['meta']['message']));
      }

    }catch (e){
      emit(CutiError(msg: e.toString()));
    }
  }
}