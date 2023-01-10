import 'package:absen_online/constant/assets_constant.dart';
import 'package:absen_online/constant/color_constant.dart';
import 'package:flutter/material.dart';

class DashboardCard extends StatelessWidget {
  final String label1,label2,label3,value1,value2,value3;
  DashboardCard(this.label1,this.label2,this.label3,this.value1,this.value2,this.value3);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Flexible(
          child: Column(
            children: [
              Text(label1,style: TextStyle(color: color_black,fontSize: 14,fontFamily: baseUrlFontsPoppinsSemiBold),),
              Text("$value1 Hari",style: TextStyle(color: color_success,fontSize: 12,fontFamily: baseUrlFontsPoppinsRegular),),
              SizedBox(
                height: 5,
              ),
              Container(
                height: 6,
                width: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: color_success,
                ),
              )
            ],
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
        ),
        Flexible(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            height: 50,
            width: 1,
            color: Color(0xFFBEBEBE),
          ),
        ),
        // Flexible(
        //   child: Column(
        //     children: [
        //       Text(label2,style: TextStyle(color: color_black,fontSize: 14,fontFamily: baseUrlFontsPoppinsSemiBold),),
        //       Text("$value2 Hari",style: TextStyle(color: color_secondary,fontSize: 12,fontFamily: baseUrlFontsPoppinsRegular),),
        //       SizedBox(
        //         height: 5,
        //       ),
        //       Container(
        //         height: 6,
        //         width: 60,
        //         decoration: BoxDecoration(
        //           borderRadius: BorderRadius.circular(12),
        //           color: color_secondary,
        //         ),
        //       )
        //     ],
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //   ),
        // ),
        // Flexible(
        //   child: Container(
        //     margin: EdgeInsets.symmetric(horizontal: 10),
        //     height: 50,
        //     width: 1,
        //     color: Color(0xFFBEBEBE),
        //   ),
        // ),
        Flexible(
          child: Column(
            children: [
              FittedBox(fit: BoxFit.fitWidth,child: Text(label3,style: TextStyle(color: color_black,fontSize: 14,fontFamily: baseUrlFontsPoppinsSemiBold),)),
              Text("$value3 Hari",style: TextStyle(color: color_black,fontSize: 12,fontFamily: baseUrlFontsPoppinsRegular),),
              SizedBox(
                height: 5,
              ),
              Container(
                height: 6,
                width: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: color_black,
                ),
              )
            ],
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
        ),
      ],
    );
  }
}
