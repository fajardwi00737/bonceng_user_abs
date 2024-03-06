import 'package:absen_online/bloc/inbox_cubit/inbox_cubit.dart';
import 'package:absen_online/constant/assets_constant.dart';
import 'package:absen_online/constant/color_constant.dart';
import 'package:absen_online/ui/widget/card/custom_notif_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class InboxPage extends StatefulWidget {
  @override
  _InboxPageState createState() => _InboxPageState();
}

class _InboxPageState extends State<InboxPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    context.read<InboxCubit>().getInboxList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded,color: color_black,),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        title: Text("Notifikasi",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: color_black)),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 16),
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 32),
                child: BlocBuilder<InboxCubit,InboxState>(
                    builder: (context,state){
                      if(state is InboxLoading){
                        print("loading cuy");
                        return Center(
                          child: Container(
                            height: 25,
                            width: 25,
                            child: CircularProgressIndicator(
                              // valueColor: Colors.white,
                              backgroundColor: Colors.blue,
                            ),
                          ),
                        );
                      } else if(state is InboxFailed){
                        print("failed cuy asdasd");

                        return Container(
                          width: MediaQuery.of(context).size.width,
                          alignment: Alignment.topCenter,
                          child: Text("Belum ada Data",style: TextStyle(fontSize: 15,color: color_grey,fontFamily: baseUrlFontsPoppinsRegular,fontWeight: FontWeight.bold),),
                        );
                      } else if (state is InboxError){
                        print("error cuy");
                        print("error cuy => "+state.msg!);

                        return Container();
                      } else if(state is InboxSuccess){
                        print("sucess cuy");

                        return ListView.builder(
                            shrinkWrap: true,
                            // controller: scrollController,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: state.inboxList.length,
                            itemBuilder: (context, index) {
                              return  CustomNotifCard(state.inboxList[index]['title'], state.inboxList[index]['body'], state.inboxList[index]['reason'], state.inboxList[index]['time_format']);
                            });
                      }
                      return Container();
                    }
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}