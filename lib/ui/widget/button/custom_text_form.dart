import 'package:absen_online/constant/assets_constant.dart';
import 'package:flutter/material.dart';

class CustomTextForm extends StatelessWidget {
  CustomTextForm(
    this.lable,this.hintText,{this.onChanged,this.textEditingController,this.type = 1,this.suffixIcon = const Icon(Icons.visibility, size: 16,),this.showPassword}
  );
  final int type; // 1. defaul field, 2. password field
  final String lable,hintText;
  final ValueChanged<String> onChanged;
  final TextEditingController textEditingController;
  final Widget suffixIcon;
  final bool showPassword;
  // final FormFieldSetter<int> onSaved;
  // final FormFieldValidator<String> validator;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: type == 1 ? false : showPassword,
      controller: textEditingController,
      style: TextStyle(
        fontFamily: baseUrlFontsPoppinsRegular,
      ),
      decoration: InputDecoration(
        suffix: type == 2 ? suffixIcon : null,
        contentPadding: EdgeInsets.all(12),
        labelText: lable,
        hintText:hintText,
        hintStyle: TextStyle(
          fontFamily: baseUrlFontsPoppinsRegular,
        ),
        labelStyle: TextStyle(
          fontFamily: baseUrlFontsPoppinsRegular,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onChanged: onChanged,
      validator: (value) =>
        value.isEmpty ? '$lable tidak boleh kosong' : null,
    );
  }
}
