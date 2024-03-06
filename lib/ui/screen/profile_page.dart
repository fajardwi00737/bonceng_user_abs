import 'package:absen_online/constant/color_constant.dart';
import 'package:absen_online/ui/screen/auth/login_page.dart';
import 'package:absen_online/ui/widget/button/custom_button_confirm.dart';
import 'package:absen_online/ui/widget/button/custom_button_primary.dart';
import 'package:absen_online/ui/widget/card/experience_card.dart';
import 'package:absen_online/utils/general_shared_preferences/general_shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void logout(BuildContext context)async{
    await GeneralSharedPreferences.remove("user_id");
    await GeneralSharedPreferences.remove("token_login");
    await GeneralSharedPreferences.remove("is_login");
    await GeneralSharedPreferences.remove("user_name");
    await GeneralSharedPreferences.remove("user_mail");
    await GeneralSharedPreferences.remove("user_phone");
    await GeneralSharedPreferences.remove("user_address");
    await GeneralSharedPreferences.remove("fcm_token");
    await GeneralSharedPreferences.remove("user_divisi");
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginPage()), (route) => false);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          height: 44,
          width: MediaQuery.of(context).size.width/2,
          child: CustomButtonPrimary(
            color: color_primary,
            title: "Logout".toUpperCase(),
            textColor: Colors.white,
            isEnable: true,
            btnLoading: false,
            onTap: (){
              logout(context);
            },
            borderRadius: 50,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Positioned(
                top: -70,
                left: -1,
                right: -1,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width/2,
                  decoration: BoxDecoration(
                    color: color_primary,
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(100),bottomRight: Radius.circular(100))
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 55,),
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey.shade400
                      ),
                      child: Center(child: Icon(Icons.person,color: Colors.white,size: 50,)),
                    ),
                    SizedBox(height: 32,),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 24),
                      child: Row(
                        children: [
                          Icon(Icons.person_outline_rounded,color: color_primary,),
                          SizedBox(width: 40,),
                          Expanded(
                              child: Text(GeneralSharedPreferences.readString("user_name") ?? "-",overflow: TextOverflow.ellipsis,))
                        ],
                      ),
                    ),
                    SizedBox(height: 8,),
                    Divider(),
                    SizedBox(height: 8,),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 24),
                      child: Row(
                        children: [
                          Icon(Icons.mail_outline_rounded,color: color_primary,),
                          SizedBox(width: 40,),
                          Expanded(
                              child: Text(GeneralSharedPreferences.readString("user_mail") ?? "-",overflow: TextOverflow.ellipsis,))
                        ],
                      ),
                    ),
                    SizedBox(height: 8,),
                    Divider(),
                    SizedBox(height: 8,),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 24),
                      child: Row(
                        children: [
                          Icon(Icons.phone_android_rounded,color: color_primary,),
                          SizedBox(width: 40,),
                          Expanded(
                              child: Text(GeneralSharedPreferences.readString("user_phone") ?? "-",overflow: TextOverflow.ellipsis,))
                        ],
                      ),
                    ),
                    SizedBox(height: 8,),
                    Divider(),
                    SizedBox(height: 8,),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 24),
                      child: Row(
                        children: [
                          Icon(Icons.home_outlined,color: color_primary,),
                          SizedBox(width: 40,),
                          Expanded(
                              child: Text(GeneralSharedPreferences.readString("user_address") ?? "-",overflow: TextOverflow.ellipsis,))
                        ],
                      ),
                    ),
                    SizedBox(height: 8,),
                    Divider(),
                    SizedBox(height: 8,),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 24),
                      child: Row(
                        children: [
                          Icon(Icons.work_outline_rounded,color: color_primary,),
                          SizedBox(width: 40,),
                          Expanded(
                              child: Text(GeneralSharedPreferences.readString("user_divisi") ?? "-",overflow: TextOverflow.ellipsis,))
                        ],
                      ),
                    ),
                    SizedBox(height: 8,),
                    Divider(),
                  ],
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}

