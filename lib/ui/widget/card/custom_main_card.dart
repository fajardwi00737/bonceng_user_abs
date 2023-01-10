import 'package:absen_online/constant/assets_constant.dart';
import 'package:absen_online/constant/color_constant.dart';
import 'package:flutter/material.dart';

  class CustomMainCard extends StatelessWidget {
  CustomMainCard({this.iconData,this.label,this.onTap,this.contentColor = color_black,this.iconSize = 50,this.fontSize = 15});
  final Function onTap;
  final IconData iconData;
  final String label;
  final Color contentColor;
  final double iconSize,fontSize;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Icon(iconData, size: iconSize, color:contentColor),
            ),
            Container(
              child: Text(label,style: TextStyle(color: contentColor,fontFamily: baseUrlFontsPoppinsRegular,fontWeight: FontWeight.bold,fontSize: fontSize)),
            )
          ],
        ),
      ),
    );
  }
}
