import 'package:absen_online/constant/assets_constant.dart';
import 'package:absen_online/constant/color_constant.dart';
import 'package:absen_online/main.dart';
import 'package:absen_online/ui/screen/auth/login_page.dart';
import 'package:absen_online/ui/screen/home_navigation.dart';
import 'package:absen_online/utils/general_shared_preferences/general_shared_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Splashscreen extends StatefulWidget {
  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initLocalNotification();
    firstActionThisPage();
    firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
    firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(
            sound: true, badge: true, alert: true, provisional: true));
    firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
  }

  initLocalNotification()async{
    var androidInit = new AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOSInit = new IOSInitializationSettings();
    var initSetttings = new InitializationSettings(androidInit, iOSInit);
    await flutterLocalNotificationsPlugin.initialize(initSetttings,
        onSelectNotification: onSelectNotification);
  }

  Future onSelectNotification(String payload) async {
    print("tes selection notif");
  }

  firstActionThisPage()async{
    await Future.delayed(Duration(seconds: 2), () {});
    if(GeneralSharedPreferences.checkContain("is_login")){
      if(GeneralSharedPreferences.readBool("is_login") == true){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeNavigation()));
      } else {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => LoginPage()));
      }
    }else {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (BuildContext context) => LoginPage()));
    }


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 120,
                  width: 120,
                  padding: EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: color_primary
                  ),
                  child: Image.asset(
                    baseUrlPrimaryIconWhite,
                    width: 56.0,
                    height: 56.0,
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                RichText(
                  text: TextSpan(
                    style: new TextStyle(
                        height: 1.1
                    ),
                    children: <TextSpan>[
                      new TextSpan(
                        text: 'absen online'.toUpperCase(),
                        style: TextStyle(
                          color: color_primary,
                          fontSize: 17,
                          fontFamily: baseUrlFontsPoppinsSemiBold,
                          letterSpacing: 0.5,
                        ),
                      ),
                      new TextSpan(
                        text: '\nbonceng'.toUpperCase(),
                        style: new TextStyle(
                            color: color_primary,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            fontFamily: baseUrlFontsPoppinsSemiBold,
                            letterSpacing: 0.5
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
