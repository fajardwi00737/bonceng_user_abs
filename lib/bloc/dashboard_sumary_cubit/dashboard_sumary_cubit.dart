import 'package:absen_online/utils/general_shared_preferences/general_shared_preferences.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert ;

part 'dashboard_sumary_state.dart';

class DashboardSumaryCubit extends Cubit<DashboardSumaryState>{
  DashboardSumaryCubit() :super(DashboardSumaryInitial());

  void getDashboardSumary()async{
    try{
      emit(DashboardSumaryLoading());
      http.Response response = await http.get(
        'https://api.simerahputih.com/absen/user/summary',
        headers: {
          "x-api-key" : GeneralSharedPreferences.readString("token_login")
        },
      );
      // print("success get data => "+convert.jsonDecode(response.body)['data']['count_cuti']);

      if(convert.jsonDecode(response.body)['meta']['code'] == 200){
        print("success get data asd");
        emit(DashboardSumarySuccess(convert.jsonDecode(response.body)['data']));
      } else {
        print("failed get data");
        emit(DashboardSumaryFailed());
      }
    } catch (e){
      emit(DashboardSumaryError(msg: e.toString()));
    }
  }
}