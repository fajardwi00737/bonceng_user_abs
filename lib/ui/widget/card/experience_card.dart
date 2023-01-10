import 'package:absen_online/constant/color_constant.dart';
import 'package:flutter/material.dart';

  class ExperienceCard extends StatelessWidget {
    final String location,description,price;
    final Widget likeIcon;
    ExperienceCard(this.location,this.description,this.price,this.likeIcon);
    @override
    Widget build(BuildContext context) {
      return GestureDetector(
        onTap: (){

        },
        child: Container(
          decoration: BoxDecoration(
              color:Colors.white,
              borderRadius: BorderRadius.circular(12)
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 200,
                decoration: BoxDecoration(
                  color:color_grey,
                  borderRadius: BorderRadius.circular(12)
                ),
                child: Stack(
                  children: [
                    Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                            margin: EdgeInsets.all(8),
                            child: likeIcon))
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text(location,maxLines: 1,style: TextStyle(fontSize: 12,color: Color(0xFF181818)),),
                    Text(description,maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 14,color: Colors.black),),
                    Text(price,maxLines: 1,style: TextStyle(fontSize: 16,color: Colors.amber),)
                  ],
                ),
              )
            ],
          ),
        ),
      );
    }
  }
