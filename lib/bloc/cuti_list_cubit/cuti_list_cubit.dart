import 'package:absen_online/utils/general_shared_preferences/general_shared_preferences.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert ;
part 'cuti_list_state.dart';

class CutiListCubit extends Cubit<CutiListState>{
  CutiListCubit() :super(CutiListInitial());

  void getListCuti()async{
    try{
      emit(CutiListLoading());
      http.Response response = await http.get(
        // 'https://api.simerahputih.com/absen/user/cuti_list',
          Uri.parse('http://185.201.9.1:3101/absen/user/cuti_list'),
        headers: {
          "x-api-key" : GeneralSharedPreferences.readString("token_login")!
        },
      );

      print("get cuti list  "+convert.jsonDecode(response.body)['meta']['code'].toString());
      print("get cuti list "+convert.jsonDecode(response.body)['meta']['message'].toString());
      // print("adwd =adwi "+convert.jsonDecode(response.body)['data'][0]['generated_date'].toString());
      // print("adwd =adwi "+convert.jsonDecode(response.body)['data'][0]['in']['location'].toString());
      // print("adwd =adwi "+convert.jsonDecode(response.body)['data'][0]['in']['time'].toString());
      if(convert.jsonDecode(response.body)['meta']['code'] == 200){
        print("success get data");
        emit(CutiListSucces(convert.jsonDecode(response.body)['data']));
      } else {
        print("failed get data cuti list");
        emit(CutiListFailed());
      }
    } catch (e){
      emit(CutiListError(msg: e.toString()));
    }
  }
}