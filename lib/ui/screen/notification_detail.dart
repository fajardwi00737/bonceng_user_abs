import 'package:absen_online/constant/color_constant.dart';
import 'package:flutter/material.dart';

class NotificationDetail extends StatefulWidget {
  final String title,body,reason,date;
  const NotificationDetail(this.title,this.body,this.reason,this.date);

  @override
  State<NotificationDetail> createState() => _NotificationDetailState();
}

class _NotificationDetailState extends State<NotificationDetail> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_rounded,color: color_black,),
            onPressed: (){
              print(widget.reason);
              Navigator.pop(context);
            },
          ),
          title: Text("Detail Notifikasi",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: color_black)),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 32,),

              Text(widget.title,style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: color_black),maxLines: 2,overflow: TextOverflow.ellipsis,),
              SizedBox(height: 10,),
              Text(widget.date,style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400,color: color_grey),maxLines: 2,overflow: TextOverflow.ellipsis,),
              SizedBox(height: 24,),
              Text(widget.body,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: color_black),maxLines: 2,overflow: TextOverflow.ellipsis,),
              SizedBox(height: 16,),
              Text("Alasan : "+widget.reason,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: color_black),maxLines: 2,overflow: TextOverflow.ellipsis,),
            ],
          ),
        ),
      ),
    );
  }
}
