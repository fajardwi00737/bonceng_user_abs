import 'package:absen_online/bloc/login_cubit/login_cubit.dart';
import 'package:absen_online/constant/assets_constant.dart';
import 'package:absen_online/constant/color_constant.dart';
import 'package:absen_online/main.dart';
import 'package:absen_online/ui/screen/home_navigation.dart';
import 'package:absen_online/ui/support/flushbar/flushbar_notification.dart';
import 'package:absen_online/ui/widget/button/custom_button_primary.dart';
import 'package:absen_online/ui/widget/button/custom_text_form.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _TeUsername = TextEditingController();
  final TextEditingController _TePassword = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isButtonEnable = false,isButtonLoading = false,showPassword  = true;

  void _handleLogin(BuildContext context) async{
    String token_fcm ="";

    /// Get token firebase
    try{
      await firebaseMessaging.getToken().then((String token) {
        token_fcm = token;
      });
    }catch(e){
      token_fcm = "";
    }

    print("fcm token nya => "+token_fcm);
    context.read<LoginCubit>().login(_TeUsername.text, _TePassword.text,token_fcm);
  }

  void validateAndSave() {
    final FormState form = _formKey.currentState;
    if (form.validate()) {
      print('Form is valid');
    } else {
      print('Form is invalid');
    }
    Future.delayed(Duration(seconds: 2),(){
      setState(() {
        isButtonLoading = false;
      });
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeNavigation()));
    });
  }

  void _listenerAuth(BuildContext context, LoginState state) {
    if (state is LoginLoading) {
      print('Login Loading');
    }
    if (state is LoginFailed) {
      print('Login Failed');
      FlushbarNotification.flushbarTop(
          context,
          FlushbarPosition.BOTTOM,
          state.msg,
          Colors.white,
          color_failed,
          Icon(
            Icons.check_circle,
            color: Colors.white,
          ),
          false);
      // FlushbarNotif.failedBottom(context, "Username atau password salah");

    }
    if (state is LoginSucces) {
      // FlushbarNotif.successBottom(context, "Login Berhasil");
      print('Login Succezz');
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeNavigation()));
      // Future.delayed(Duration(seconds: 3), () {
      //   Navigator.pushReplacement(context,
      //       new MaterialPageRoute(builder: (context) => HomeNavigation(0)));
      // });
    }
    if (state is LoginError) {
      print('state error');
      print('state error => '+state.msg);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Text("Login",style: TextStyle(
                  fontFamily: baseUrlFontsPoppinsSemiBold,
                  color: color_black,
                  fontSize: 20
                ),),
              ),
              Container(
                padding: EdgeInsets.all(16),
                child: CustomTextForm(
                  "Username", "Masukkan username",
                  type: 1,
                  textEditingController: _TeUsername,
                  onChanged: (value) {
                    print(value);
                    if(value.isNotEmpty && _TePassword.text.isNotEmpty){
                      setState(() {
                        isButtonEnable = true;
                      });
                    }else {
                      setState(() {
                        isButtonEnable = false;
                      });
                    }
                },),
              ),
              Container(
                padding: EdgeInsets.all(16),
                child: CustomTextForm(
                  "password", "Masukkan password",
                  type: 2,
                  showPassword: showPassword,
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                    child: Icon(showPassword
                        ? Icons.visibility_off
                        : Icons.visibility, size: 16,color: Colors.red,),
                  ),
                  textEditingController: _TePassword,
                  onChanged: (value) {
                    print(value);
                    if(value.isNotEmpty && _TeUsername.text.isNotEmpty){
                      setState(() {
                        isButtonEnable = true;
                      });
                    } else {
                      setState(() {
                        isButtonEnable = false;
                      });
                    }
                  },),
              ),
              BlocConsumer<LoginCubit, LoginState>(
                builder: (context,state){
                  return Container(
                    padding: EdgeInsets.all(16),
                    child: CustomButtonPrimary(
                      color: color_primary,
                      title: "login".toUpperCase(),
                      textColor: Colors.white,
                      isEnable: isButtonEnable,
                      btnLoading: (state is LoginLoading) ? true : false,
                      onTap: (){
                        if(state is !LoginLoading){
                          setState(() {
                            isButtonLoading = true;
                          });
                          // validateAndSave();
                          _handleLogin(context);
                        }
                      },
                      borderRadius: 50,
                    ),
                  );
                },
                listener: _listenerAuth
              ),
            ],
          ),
        ),
      ),
    );
  }
}
