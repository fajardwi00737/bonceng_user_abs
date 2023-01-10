import 'package:absen_online/constant/assets_constant.dart';
import 'package:absen_online/constant/color_constant.dart';
import 'package:flutter/material.dart';

class HistoryAbsenCard extends StatelessWidget {
  final String date,timeIn,timeOut,locIn,locOut;
  final int status;
  HistoryAbsenCard(this.date,this.timeIn,this.timeOut,this.locIn,this.locOut,this.status);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 16,right: 16,bottom: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 0,
            blurRadius: 1,
            offset: Offset(1, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                  flex:5,child: Row(
                children: [
                  Flexible(flex:2,child: Icon(Icons.date_range_rounded)),
                  SizedBox(width: 10,),
                  Flexible(flex:5,child: Container(child: Text(date,overflow: TextOverflow.ellipsis,style: TextStyle(color: color_black,fontSize: 15,fontFamily: baseUrlFontsPoppinsSemiBold),))),
                ],
              )),
              Flexible(flex:3,
                child: Container(
                  // height: 40,
                  // width: 150,
                  decoration: BoxDecoration(
                      color: status == 2 ? color_green: status == 3 ? color_primary : status == 1 ? Colors.black: Colors.grey,
                      borderRadius: BorderRadius.circular(8)
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 8,vertical: 5),
                  child: Text(status == 2 ? "Approved": status == 3 ? "Rejected" : status == 1 ? "Need Approval": "Need Approval",style: TextStyle(color: Colors.white,fontSize:11,fontFamily: baseUrlFontsPoppinsSemiBold)),
                ),
              )
            ],
          ),
          Container(margin: EdgeInsets.symmetric(vertical: 5),child: Divider(thickness: 1.5,color: Color(0xFFBEBEBE),)),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text("Presensi Masuk",style: TextStyle(color: color_grey,fontSize:12,fontFamily: baseUrlFontsPoppinsSemiBold,fontWeight: FontWeight.bold)),
                SizedBox(height: 6,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,

                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.access_time_rounded),
                    Text(timeIn,style: TextStyle(color: color_black,fontSize:20,fontFamily: baseUrlFontsPoppinsRegular,fontWeight: FontWeight.bold))
                  ],
                ),
                SizedBox(height: 6,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.location_on_outlined),
                    Text(locIn,style: TextStyle(color: color_black,fontSize:15,fontFamily: baseUrlFontsPoppinsRegular,fontWeight: FontWeight.bold))
                  ],
                )
              ],
            ),
          ),
          Container(margin: EdgeInsets.symmetric(vertical: 5),child: Divider(thickness: 0.5,color: Color(0xFFBEBEBE),)),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text("Presensi Pulang",style: TextStyle(color: color_grey,fontSize:12,fontFamily: baseUrlFontsPoppinsSemiBold,fontWeight: FontWeight.bold)),
                SizedBox(height: 6,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,

                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.access_time_rounded),
                    Text(timeOut,style: TextStyle(color: color_black,fontSize:20,fontFamily: baseUrlFontsPoppinsRegular,fontWeight: FontWeight.bold))
                  ],
                ),
                SizedBox(height: 6,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.location_on_outlined),
                    Text(locOut,style: TextStyle(color: color_black,fontSize:15,fontFamily: baseUrlFontsPoppinsRegular,fontWeight: FontWeight.bold))
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
