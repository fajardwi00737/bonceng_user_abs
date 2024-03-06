import 'package:absen_online/constant/assets_constant.dart';
import 'package:absen_online/constant/color_constant.dart';
import 'package:flutter/material.dart';

class CustomDatePickerForm extends StatelessWidget {
  CustomDatePickerForm({this.onTap,this.controller});
  final Function? onTap;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlignVertical: TextAlignVertical.center,
      style: TextStyle(fontFamily: baseUrlFontsPoppinsSemiBold,fontSize: 17),
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.date_range_outlined,color: color_black,size: 20,),
        contentPadding: EdgeInsets.all(12),
        hintText:"pilih tanggal",
        hintStyle: TextStyle(
          fontFamily: baseUrlFontsPoppinsRegular,
        ),
        labelStyle: TextStyle(
          fontFamily: baseUrlFontsPoppinsRegular,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      readOnly: true,
      onTap: onTap!()
    );
  }
}
