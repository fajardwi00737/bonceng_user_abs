import 'package:absen_online/constant/color_constant.dart';
import 'package:absen_online/ui/screen/notification_detail.dart';
import 'package:flutter/material.dart';

class CustomNotifCard extends StatelessWidget {
  final String title,body,reason,dateTime;
  CustomNotifCard(this.title,this.body,this.reason,this.dateTime);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>NotificationDetail(title, body, reason ?? "-", dateTime)));
      },
      child: Container(
        padding: EdgeInsets.only(top: 12),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: color_grey,width: 0.2
          ))
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 10,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: color_black),maxLines: 2,overflow: TextOverflow.ellipsis,),
                      SizedBox(height: 8,),
                      Text(body,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 14,fontWeight: FontWeight.w700,color: color_grey)),
                    ],
                  ),
                ),
                Flexible(
                    flex: 2,
                    child: Text(dateTime,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 12,fontWeight: FontWeight.w300,color: color_grey))),
              ],
            ),
            SizedBox(height: 12,),
          ],
        ),
      ),
    );
  }
}
