import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class GeneralSharedPreferences{

  static SharedPreferences sharedPreferences = SharedPreferences.getInstance() as SharedPreferences;

  static Future<void> setUp()async{
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static int? readInt(String key){
    return sharedPreferences.getInt(key);
  }

  static String? readString(String key){
    return sharedPreferences.getString(key);
  }

  static bool? readBool(String key){
    return sharedPreferences.getBool(key);
  }

  static readObject(String key)async{

    var data = await json.decode(sharedPreferences.get(key).toString());
    return data;
  }

  static Future<void> writeString(String key, String value)async{
    await sharedPreferences.setString(key, value);
  }

  static Future<void> writeInt(String key, int value)async{
    await sharedPreferences.setInt(key, value);
  }

  static Future<void> writeBool(String key, bool value)async{
    await sharedPreferences.setBool(key, value);
  }

  static Future<void> writeObject(String key, objectValue)async{
    await sharedPreferences.setString(key, json.encode(objectValue));
  }

  static Future<void> remove(String key)async{
    await sharedPreferences.remove(key);
  }

  static bool checkContain(String key){
    return sharedPreferences.containsKey(key);
  }

}