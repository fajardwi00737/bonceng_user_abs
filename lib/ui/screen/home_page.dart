import 'package:absen_online/bloc/dashboard_sumary_cubit/dashboard_sumary_cubit.dart';
import 'package:absen_online/constant/assets_constant.dart';
import 'package:absen_online/constant/card_content/card_content.dart';
import 'package:absen_online/constant/color_constant.dart';
import 'package:absen_online/ui/screen/absensi_page.dart';
import 'package:absen_online/ui/screen/animation.dart';
import 'package:absen_online/ui/screen/attendance_recap_page.dart';
import 'package:absen_online/ui/screen/pengajuan_cuti_page.dart';
import 'package:absen_online/ui/widget/card/custom_main_card.dart';
import 'package:absen_online/ui/widget/card/dashboard_card.dart';
import 'package:absen_online/utils/general_shared_preferences/general_shared_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:absen_online/main.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  final List<CardContent> cardContent = [
    CardContent(1,Icons.fingerprint, "Absen"),
    CardContent(2,Icons.receipt, "Rekap Absen"),
    CardContent(3,Icons.assignment_ind, "Cuti/Izin"),
    // CardContent(Icons.article_outlined, "Daftar"),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        var ketNotif;
        var msgBody;
        final data = message['data'];
        ketNotif = data['ket_notif'].toString();
        msgBody = data['message'].toString();

        print("onMessage home: $message");
        showNotification(ketNotif,msgBody);
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch home: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume home: $message");
      },
    );
    getLocations();
    context.read<DashboardSumaryCubit>().getDashboardSumary();
  }



  showNotification(String nama, String message, {String payload}) async {


    var android = new AndroidNotificationDetails(
        'channel_id', 'channel_approval', 'CHANNEL_APPROVAL_NOTIF',
        priority: Priority.High, importance: Importance.Max);
    var iOS = new IOSNotificationDetails();
    var platform = new NotificationDetails(android, iOS);
    await flutterLocalNotificationsPlugin.show(0, nama, message, platform);
  }

  Future onSelectNotification(String payload) async {
    print("tes selection notif");
  }

  // orderMasuk(String title, String body)async{
  //   var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
  //       'FLN OM 1',
  //       'APPROVAL NOTIF',
  //       'Show notification for approval',
  //       // sound: RawResourceAndroidNotificationSound("ringtone_order_masuk"),
  //       importance: Importance.Max,
  //       priority: Priority.High,
  //       largeIcon: DrawableResourceAndroidBitmap("logo_notif")
  //   );
  //   var iOSPlatformChannelSpecifics =
  //   new IOSNotificationDetails(sound: "slow_spring_board.aiff");
  //   var platformChannelSpecifics = new NotificationDetails(
  //       androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
  //   await flutterLocalNotificationsPlugin.show(
  //     1,
  //     '$title',
  //     '$body',
  //     platformChannelSpecifics,
  //     payload: 'approval_notif',
  //   );
  // }

  getLocations() async{
    Position res = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    print("lat => "+res.latitude.toString());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 16,horizontal: 16),
                child: InkWell(
                  onTap: (){
                    print(" oke");
                  },
                  child: Container(
                      margin: EdgeInsets.only(top: 52.0),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 3,
                              blurRadius: 5,
                              offset: Offset(0, 0),)
                          ],
                          color: color_primary,
                          borderRadius: BorderRadius.all(
                              Radius.circular(36))),
                      child: Container(
                        margin: EdgeInsets.only(
                            left: 10.0,
                            right: 10.0,
                            top: 10.0,
                            bottom: 10.0),
                        child: Container(
                          width: MediaQuery.of(context)
                              .size
                              .width,
                          child: Row(
                            children: <Widget>[
                              Flexible(
                                flex: 9,
                                child: Container(
                                  child: Row(
                                    children: <Widget>[
                                      Flexible(
                                        flex: 2,
                                        child: Container(
                                          height: 40,
                                          width: 40,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius
                                                  .circular(
                                                  500),
                                              color: Colors.white),
                                          child: Center(
                                            child: Text(
                                              "F",
                                              style: TextStyle(
                                                  fontSize:
                                                  18,
                                                  color: color_primary,
                                                  fontFamily:baseUrlFontsPoppinsSemiBold),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        flex: 9,
                                        child: Container(
                                          margin:
                                          EdgeInsets.only(
                                              left: 16),
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment
                                                .start,
                                            children: <
                                                Widget>[
                                              Container(
                                                child: Text(
                                                  "Hallo,",
                                                  style: TextStyle(
                                                      fontSize:
                                                      13,
                                                      fontFamily:baseUrlFontsPoppinsRegular,
                                                      color: Colors.white),
                                                ),
                                              ),
                                              Container(
                                                child: Text(
                                                  GeneralSharedPreferences.readString("user_name") ?? "-",
                                                  overflow:
                                                  TextOverflow
                                                      .ellipsis,
                                                  style: TextStyle(
                                                      fontSize:
                                                      17,
                                                      fontFamily:baseUrlFontsPoppinsSemiBold,
                                                      fontWeight:
                                                      FontWeight
                                                          .bold,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: Container(
                                  margin: EdgeInsets.only(
                                      right: 8),
                                  child: Icon(
                                    Icons.chevron_right,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )),
                ),
              ),
              SizedBox(height: 24,),
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
                    Text("Rekap Absen Bulan Ini",style: TextStyle(color: color_black,fontSize: 17,fontFamily: baseUrlFontsPoppinsSemiBold),),
                    Container(margin: EdgeInsets.symmetric(vertical: 5),child: Divider(thickness: 1,color: Color(0xFFBEBEBE),)),
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
                      },
                    )
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  // margin: EdgeInsets.all(16),
                  child: GridView.count(
                    crossAxisCount: 2,
                    children: List.generate(cardContent.length, (index){
                      return Container(
                        margin: EdgeInsets.only(bottom: 16,right: index % 2 == 0 ?8:16,left: index % 2 != 0 ?8:16),
                        child: CustomMainCard(
                          iconData : cardContent[index].iconData,
                          label : cardContent[index].label,
                          onTap:(){
                            print(cardContent[index].label);
                            navigateToPage(cardContent[index].id);
                          },
                          iconSize: 100,
                        ),
                      );
                    }
                  ),
              ),
                )
              )
            ],
          ),
        ),
      ),
    );
  }

  navigateToPage(int id){
    if(id == 1){
      Navigator.push(context, MaterialPageRoute(builder: (context) => AbsensiPage()));
    } else if (id == 2){
      Navigator.push(context, MaterialPageRoute(builder: (context) => AttendanceRecapPage()));
    } else if(id == 3){
      Navigator.push(context, MaterialPageRoute(builder: (context) => PengajuanCutiPage()));
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (context) => AbsensiPage()));

    }
  }
}
