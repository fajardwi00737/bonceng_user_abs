import 'package:absen_online/utils/general_shared_preferences/general_shared_preferences.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert ;

part 'inbox_state.dart';

class InboxCubit extends Cubit<InboxState>{
  InboxCubit() :super(InboxInitial());

  void getInboxList()async{
    try{
      print("id User nya => "+GeneralSharedPreferences.readInt("user_id").toString());
      emit(InboxLoading());
      http.Response response = await http.get(
          Uri.parse('http://185.201.9.1:3101/absen/user/inbox?user_id='+GeneralSharedPreferences.readInt("user_id").toString()),
        headers: {
          "x-api-key" : GeneralSharedPreferences.readString("token_login")!
        },
      );
      // print("listdasd inbox "+convert.jsonDecode(response.body).toString());
      // print("listdasd inbox "+convert.jsonDecode(response.body)['data'][1]['reason'].toString());
      if(convert.jsonDecode(response.body)['meta']['code'] == 200){
        print("success get data asd");
        emit(InboxSuccess(convert.jsonDecode(response.body)['data']));
      } else {
        print("failed get data");
        emit(InboxFailed());
      }
      // emit(InboxSuccess(inboxList));
    }catch (e){
      print("error inbox "+e.toString());
      emit(InboxError(msg: "error"+e.toString()));
    }
  }
}