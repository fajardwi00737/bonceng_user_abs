import 'package:absen_online/constant/assets_constant.dart';
import 'package:absen_online/constant/color_constant.dart';
import 'package:flutter/material.dart';

class HistoryCuti extends StatelessWidget {
  final String? fromDate,toDate,cutiReason,rejectReason,statusCuti;
  HistoryCuti(this.fromDate,this.toDate,this.cutiReason,this.statusCuti,{this.rejectReason});
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
              Flexible(child: Text("Status pengajuan",overflow: TextOverflow.ellipsis,style: TextStyle(color: color_black,fontSize: 15,fontFamily: baseUrlFontsPoppinsSemiBold),)),
              Container(
                // height: 40,
                // width: 150,
                decoration: BoxDecoration(
                    color: statusCuti == "Approved" ? color_green: statusCuti == "Reject" ? color_primary : statusCuti == "Alpha" ? Colors.black: Colors.grey,
                    borderRadius: BorderRadius.circular(8)
                ),
                padding: EdgeInsets.symmetric(horizontal: 8,vertical: 5),
                child: Text(statusCuti!,style: TextStyle(color: Colors.white,fontSize:11,fontFamily: baseUrlFontsPoppinsSemiBold)),
              )
            ],
          ),
          Container(margin: EdgeInsets.symmetric(vertical: 5),child: Divider(thickness: 1.5,color: Color(0xFFBEBEBE),)),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text("Pengajuan",style: TextStyle(color: color_grey,fontSize:15,fontFamily: baseUrlFontsPoppinsSemiBold,fontWeight: FontWeight.bold)),
                SizedBox(height: 6,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,

                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(child: Text("Dari tanggal",style: TextStyle(color: color_black,fontSize:12,fontFamily: baseUrlFontsPoppinsRegular,fontWeight: FontWeight.bold))),
                    Flexible(child: Text(fromDate!,overflow: TextOverflow.ellipsis,maxLines: 1,style: TextStyle(color: color_black,fontSize:12,fontFamily: baseUrlFontsPoppinsRegular,fontWeight: FontWeight.bold)))
                  ],
                ),
                SizedBox(height: 6,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(child: Container(child: Text("Sampai tanggal",style: TextStyle(color: color_black,fontSize:12,fontFamily: baseUrlFontsPoppinsRegular,fontWeight: FontWeight.bold)))),
                    Flexible(child: Container(child: Text(toDate!,overflow: TextOverflow.ellipsis,maxLines: 1,style: TextStyle(color: color_black,fontSize:12,fontFamily: baseUrlFontsPoppinsRegular,fontWeight: FontWeight.bold))))
                  ],
                ),
                SizedBox(height: 6,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(flex:1,child: Container(margin: EdgeInsets.only(top: 8),child: Text("Alasan Cuti",style: TextStyle(color: color_black,fontSize:12,fontFamily: baseUrlFontsPoppinsRegular,fontWeight: FontWeight.bold)))),
                    Flexible(
                      flex: 2,
                      child: Container(
                        padding: EdgeInsets.all(8),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadiusDirectional.circular(8),
                          color: color_grey.withOpacity(0.2)
                        ),
                        child: Text(cutiReason!,style: TextStyle(color: color_black,fontSize:12,fontFamily: baseUrlFontsPoppinsRegular,fontWeight: FontWeight.bold)),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),

          statusCuti == "Reject" ?Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Container(margin: EdgeInsets.symmetric(vertical: 5),child: Divider(thickness: 0.5,color: Color(0xFFBEBEBE),)),
                SizedBox(height: 6,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(flex:1,child: Container(margin: EdgeInsets.only(top: 8),child: Text("Alasan Reject",style: TextStyle(color: color_black,fontSize:12,fontFamily: baseUrlFontsPoppinsRegular,fontWeight: FontWeight.bold)))),
                    Flexible(
                      flex: 2,
                      child: Container(
                        padding: EdgeInsets.all(8),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadiusDirectional.circular(8),
                            color: color_grey.withOpacity(0.2)
                        ),
                        child: Text(rejectReason!,style: TextStyle(color: color_black,fontSize:12,fontFamily: baseUrlFontsPoppinsRegular,fontWeight: FontWeight.bold)),
                      ),
                    )
                  ],
                )
              ],
            ),
          ):Container()
        ],
      ),
    );
  }
}
