
import 'package:absen_online/bloc/cuti_cubit/cuti_cubit.dart';
import 'package:absen_online/bloc/cuti_list_cubit/cuti_list_cubit.dart';
import 'package:absen_online/bloc/dashboard_sumary_cubit/dashboard_sumary_cubit.dart';
import 'package:absen_online/bloc/presence_list_bloc/presence_list_cubit.dart';
import 'package:absen_online/constant/assets_constant.dart';
import 'package:absen_online/constant/color_constant.dart';
import 'package:absen_online/ui/widget/button/custom_button_primary.dart';
import 'package:absen_online/ui/widget/card/dashboard_card.dart';
import 'package:absen_online/ui/widget/card/history_absen_card.dart';
import 'package:absen_online/ui/widget/card/history_cuti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AttendanceRecapPage extends StatefulWidget {
  @override
  _AttendanceRecapPageState createState() => _AttendanceRecapPageState();
}

class _AttendanceRecapPageState extends State<AttendanceRecapPage> {
  // List<DropdownMenuItem<String>> get dropdownItems{
  //   List<DropdownMenuItem<String>> menuItems = [
  //     DropdownMenuItem(child: Text("USA"),value: "USA"),
  //     DropdownMenuItem(child: Text("Canada"),value: "Canada"),
  //     DropdownMenuItem(child: Text("Brazil"),value: "Brazil"),
  //     DropdownMenuItem(child: Text("England"),value: "England"),
  //   ];
  //   return menuItems;
  // }

  ScrollController scrollController = ScrollController();
  List<DateRecapModel> listOptionHistoryTransaksi = [];
  DateRecapModel? optionHistoryTransaksi;
  String monthName = "";

  bool isAbsen = true, isCuti = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firstTimeOpenThisPage();
  }

  _isTypeSelected(int type){
    if(type == 1){
      setState(() {
        isAbsen = true;
        isCuti = false;
      });
      context.read<PresenceListCubit>().getListPresence();
    } else {
      setState(() {
        isAbsen = false;
        isCuti = true;
      });
      context.read<CutiListCubit>().getListCuti();
    }
  }

  firstTimeOpenThisPage()async{
    listOptionHistoryTransaksi.add(DateRecapModel("1", "September"));
    listOptionHistoryTransaksi.add(DateRecapModel("2", "Januari"));
    listOptionHistoryTransaksi.add(DateRecapModel("3", "Desember"));
    setState(() {
      optionHistoryTransaksi = listOptionHistoryTransaksi[0];
      monthName = listOptionHistoryTransaksi[0].name;
    });
    context.read<PresenceListCubit>().getListPresence();
    // context.read<CutiListCubit>().getListCuti();
  }
  String selectedValue = "USA";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          controller: scrollController,
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8,),
                Container(
                  margin: EdgeInsets.all(16),
                  child: IconButton(icon: Icon(Icons.arrow_back_rounded),
                      onPressed: (){
                        Navigator.pop(context);
                      }),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  padding: EdgeInsets.all(16),
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Flexible(flex:1,child: Text("Rekap Absensi",overflow: TextOverflow.ellipsis,style: TextStyle(color: color_black,fontSize: 17,fontFamily: baseUrlFontsPoppinsSemiBold),)),
                      //     Flexible(
                      //       flex: 1,
                      //       child: Container(
                      //         height: 40,
                      //         width: 150,
                      //         child: InkWell(
                      //           onTap: ()async{
                      //             bool res = await showModalBottomSheet(
                      //                 context: context,
                      //                 isScrollControlled: true,
                      //                 builder: (BuildContext bc) => bottomSheetSettingHistoryTranksaki(context)
                      //             );
                      //             if(res != null){
                      //               print("12 => "+ optionHistoryTransaksi.name);
                      //               setState(() {
                      //                 monthName = optionHistoryTransaksi.name;
                      //               });
                      //             }
                      //           },
                      //           child: Container(
                      //             height: 32,
                      //             margin: EdgeInsets.only(right: 7, top: 1, bottom: 1),
                      //             padding: EdgeInsets.only(left: 16, right: 7),
                      //             decoration: BoxDecoration(
                      //                 color: color_gold,
                      //                 borderRadius: BorderRadius.circular(16),
                      //             ),
                      //             child: Row(
                      //               mainAxisAlignment: MainAxisAlignment.center,
                      //               children: [
                      //                 Text(
                      //                   monthName,
                      //                   style: TextStyle(
                      //                     color: Colors.white, // Color(0xFF919EAB),
                      //                     fontSize: 12,
                      //                     fontFamily: 'PoppinsSemiBold',
                      //                   ),
                      //                 ),
                      //                 RotationTransition(
                      //                   turns: AlwaysStoppedAnimation(90/360),
                      //                   child: Icon(
                      //                     Icons.chevron_right,
                      //                     color: Colors.white,
                      //                     size: 18,
                      //                   ),
                      //                 )
                      //               ],
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //     )
                      //   ],
                      // ),
                      // Container(margin: EdgeInsets.symmetric(vertical: 5),child: Divider(thickness: 1,color: Color(0xFFBEBEBE),)),
                      BlocBuilder<DashboardSumaryCubit,DashboardSumaryState>(
                      builder: (context, state){
                        if(state is DashboardSumaryLoading){
                          return DashboardCard("Hadir", "Alpa", "Sisa Cuti", "0", "0", "0");
                        } else if(state is DashboardSumarySuccess){
                          return DashboardCard("Hadir", "Alpa", "Sisa Cuti", state.dashboardInfo['presence'].toString(), "0", state.dashboardInfo['count_cuti'].toString());
                        } else if(state is DashboardSumaryFailed){
                          return DashboardCard("Hadir", "Alpa", "Sisa Cuti", "0", "0", "0");
                        } else if(state is DashboardSumaryError){
                          print(state.msg);
                          return DashboardCard("Hadir", "Alpa", "Sisa Cuti", "-", "-", "-");
                        }
                        return DashboardCard("Hadir", "Alpa", "Sisa Cuti", "0", "0", "0");
                      })
                    ],
                  ),
                ),
                // Container(
                //   child: HistoryCuti(),
                // ),
                SizedBox(height: 16,),
                Container(
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        height: 40,
                        width: 70,
                        child: CustomButtonPrimary(
                          color: isAbsen ? color_primary : Colors.white,
                          hasWidth: true,
                          hasHeight: true,
                          isBorder: isAbsen ? false:true,
                          title: "Absen".toUpperCase(),
                          customTextSize: 10,
                          textColor: isAbsen ? Colors.white : Colors.black,
                          isEnable: true,
                          btnLoading: false,
                          onTap: (){
                            // logout(context);
                            _isTypeSelected(1);
                          },
                          borderRadius: 50,
                        ),
                      ),
                      Container(
                        height: 40,
                        width: 70,
                        child: CustomButtonPrimary(
                          hasWidth: true,
                          hasHeight: true,
                          color: isCuti ? color_primary :Colors.white,
                          isBorder: isCuti ? false : true,
                          title: "Cuti".toUpperCase(),
                          customTextSize: 10,
                          textColor: isCuti ? Colors.white : Colors.black,
                          isEnable: true,
                          btnLoading: false,
                          onTap: (){
                            // logout(context);
                            _isTypeSelected(2);
                          },
                          borderRadius: 50,
                        ),
                      ),
                    ],
                  ),
                ),
                isCuti ? Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 16,),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        child: Text("Riwayat Cuti",style: TextStyle(fontSize: 17,color: color_black,fontFamily: baseUrlFontsPoppinsSemiBold,fontWeight: FontWeight.bold),),
                      ),
                      SizedBox(height: 16,),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(bottom: 32),
                          child: BlocBuilder<CutiListCubit,CutiListState>(
                              builder: (context,state){
                                if(state is CutiListLoading){
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
                                } else if(state is CutiListFailed){
                                  print("failed cuy");

                                  return Container(
                                    width: MediaQuery.of(context).size.width,
                                    alignment: Alignment.topCenter,
                                    child: Text("Belum ada Data",style: TextStyle(fontSize: 15,color: color_grey,fontFamily: baseUrlFontsPoppinsRegular,fontWeight: FontWeight.bold),),
                                  );
                                } else if (state is CutiListError){
                                  print("error cuy");
                                  print("error cuy => "+state.msg!);

                                  return Container();
                                } else if(state is CutiListSucces){
                                  print("sucess cuy");

                                  return ListView.builder(
                                    controller: scrollController,
                                      shrinkWrap: true,
                                      physics: ScrollPhysics(),
                                      itemCount: state.userInfo.length,
                                      itemBuilder: (context, index) {
                                        return HistoryCuti(
                                          state.userInfo[index]['start_date'] ?? "-",
                                          state.userInfo[index]['end_date'] ?? "-",
                                          state.userInfo[index]['reason'] ?? "-",
                                          state.userInfo[index]['status_name'] ?? "-",
                                          rejectReason: state.userInfo[index]['reason_refusing'] ?? "-",
                                        );
                                      });
                                }
                                return Container();
                              }
                          ),
                        ),
                      ),
                    ],
                  ),
                ):
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 16,),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        child: Text("Riwayat Absen",style: TextStyle(fontSize: 17,color: color_black,fontFamily: baseUrlFontsPoppinsSemiBold,fontWeight: FontWeight.bold),),
                      ),
                      SizedBox(height: 16,),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(bottom: 32),
                          child: BlocBuilder<PresenceListCubit,PresenceListState>(
                              builder: (context,state){
                                if(state is PresenceListLoading){
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
                                } else if(state is PresenceListFailed){
                                  print("failed cuy");

                                  return Container(
                                    width: MediaQuery.of(context).size.width,
                                    alignment: Alignment.topCenter,
                                    child: Text("Belum ada Data",style: TextStyle(fontSize: 15,color: color_grey,fontFamily: baseUrlFontsPoppinsRegular,fontWeight: FontWeight.bold),),
                                  );
                                } else if (state is PresenceListError){
                                  print("error cuy");
                                  print("error cuy => "+state.msg!);

                                  return Container();
                                } else if(state is PresenceListSucces){
                                  print("sucess cuy");

                                  return ListView.builder(
                                      shrinkWrap: true,
                                      controller: scrollController,
                                      physics: ScrollPhysics(),
                                      itemCount: state.userInfo.length,
                                      itemBuilder: (context, index) {
                                        return HistoryAbsenCard(
                                          state.userInfo[index]['generated_date'] ?? "-",
                                          state.userInfo[index]['in'] != null ? state.userInfo[index]['in']['time'] : "-",
                                          state.userInfo[index]['out'] != null ? state.userInfo[index]['out']['time'] : "-",
                                          state.userInfo[index]['in'] != null ? state.userInfo[index]['in']['location'] : "-",
                                          state.userInfo[index]['out'] != null ? state.userInfo[index]['out']['location'] : "-",
                                          state.userInfo[index]['status'] ?? "-",
                                        );
                                      });
                                }
                                return Container();
                              }
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget bottomSheetSettingHistoryTranksaki(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.45,
      child: StatefulBuilder(
        builder: (context, setState) {
          return Container(
              color: Colors.white,
              child: Stack(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin:
                              EdgeInsets.only(left: 16, top: 20, right: 16),
                              child: InkWell(
                                onTap: () {
                                  // _panelController.close();
                                  Navigator.pop(context);
                                },
                                child: Icon(Icons.close),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 16, right: 16),
                              child: Text(
                                "Pilih waktu transaksi",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontFamily: 'PoppinsSemiBold',
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: listOptionHistoryTransaksi.length,
                          itemBuilder: (context, i) {
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  optionHistoryTransaksi = listOptionHistoryTransaksi[i];
                                });
                                var id = listOptionHistoryTransaksi[i].id;
                                print(id);
                                print(listOptionHistoryTransaksi[i].name);
                                print(optionHistoryTransaksi!.name);

                                Future.delayed(Duration(milliseconds: 300),(){
                                  Navigator.of(context).pop(true);
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.only(bottom: 16),
                                padding: EdgeInsets.only(left: 16, right: 16),
                                height: 52,
                                color: optionHistoryTransaksi!.id == listOptionHistoryTransaksi[i].id ? Color(0xFFEDEDED) : Colors.white,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Expanded(
                                      child: Text(
                                        listOptionHistoryTransaksi[i].name,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontFamily: 'PoppinsRegular'),
                                      ),
                                    ),
                                    Container(
                                        height: 20,
                                        width: 20,
                                        padding: EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: color_grey
                                        ),
                                        child: optionHistoryTransaksi!.id == listOptionHistoryTransaksi[i].id ? Container(
                                            height: 10,
                                            width: 10,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.white
                                            )
                                        ) :
                                        Container()
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ],
              ));
        },
      ),
    );
  }
}

class DateRecapModel{
  String id;
  String name;
  DateRecapModel(this.id, this.name);
}