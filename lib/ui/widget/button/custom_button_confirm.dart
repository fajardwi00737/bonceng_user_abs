import 'package:absen_online/constant/color_constant.dart';
import 'package:flutter/material.dart';

class CustomButtonConfirm extends StatelessWidget {
  final bool? isEnable, isLoading;
  final Function? onTap;
  final String? title;
  final Color? buttonColor,textColor;
  CustomButtonConfirm({
    this.isEnable,this.isLoading,this.onTap,this.title,this.buttonColor,this.textColor
  });


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 60,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: isEnable! ? buttonColor : color_grey,
            elevation: 5,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100))
        ),
        onPressed: onTap!(),
        child: isLoading! ? Container(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(backgroundColor: Colors.white)) : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.fingerprint,color: textColor),
            SizedBox(
              height: 2,
            ),
            Text(title!,style: TextStyle(color: textColor,fontSize: 9))
          ],
        ),
      ),
    );
  }
}
