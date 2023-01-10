
import 'package:absen_online/bloc/cuti_cubit/cuti_cubit.dart';
import 'package:absen_online/constant/assets_constant.dart';
import 'package:absen_online/constant/color_constant.dart';
import 'package:absen_online/ui/support/flushbar/flushbar_notification.dart';
import 'package:absen_online/ui/widget/button/custom_button_confirm.dart';
import 'package:absen_online/ui/widget/button/custom_date_picker_form.dart';
import 'package:absen_online/utils/general_shared_preferences/general_shared_preferences.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class PengajuanCutiPage extends StatefulWidget {
  @override
  _PengajuanCutiPageState createState() => _PengajuanCutiPageState();
}

class _PengajuanCutiPageState extends State<PengajuanCutiPage> {
  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();
  TextEditingController tf_price_food = TextEditingController();

  DateTime _dateTime;
  bool checkboxSakit = false;
  bool checkboxCutiTahunan = false;
  bool checkboxKeperluanKeluarga = false;
  bool checkboxSeminar = false;
  bool checkboxLainnya= false;
  String confirmSelectedFromDate ="",confirmSelectedToDate = "", confirmReason = "";
  int initYears,initMonth,initDay,selectedFromYears,selectedFromMonth,selectedFromdDay,selectedToYears,selectedToMonth,selectedToDay;

  String _formatDate(DateTime dateTime) {
    return DateFormat('dd-MM-yyyy').format(dateTime);
  }

  String _formatDate2(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }

  @override
  void initState() {
    // TODO: implement initState
    initYears = DateTime.now().year;
    initMonth = DateTime.now().month;
    initDay = DateTime.now().day;
    super.initState();
  }

  void listenerCuti(BuildContext context, CutiState state) {
    if (state is CutiLoading) {
      print('absen Loading');
    }
    if (state is CutiFailed) {
      print('absen Failed');
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
    if (state is CutiSucces) {
      // FlushbarNotif.successBottom(context, "Login Berhasil");
      print('absen Succezz');
      FlushbarNotification.flushbarTop(
          context,
          FlushbarPosition.BOTTOM,
          state.msg,
          Colors.white,
          color_success,
          Icon(
            Icons.check_circle,
            color: Colors.white,
          ),
          false);
      Future.delayed(Duration(seconds: 3), () {
        Navigator.pop(context);
      });
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeNavigation()));
      // Future.delayed(Duration(seconds: 3), () {
      //   Navigator.pushReplacement(context,
      //       new MaterialPageRoute(builder: (context) => HomeNavigation(0)));
      // });
    }
    if (state is CutiError) {
      print('state error');
      print('state error => '+state.msg);
      FlushbarNotification.flushbarTop(
          context,
          FlushbarPosition.BOTTOM,
          "Request gagal! Silakan coba lagi",
          Colors.white,
          color_failed,
          Icon(
            Icons.check_circle,
            color: Colors.white,
          ),
          false);
    }
  }

  actionConfirmCuti(BuildContext context)async{
    print("from date => "+confirmSelectedFromDate);
    print("to Date => "+confirmSelectedToDate);
    if(checkboxSakit){
      confirmReason = "Sakit";
    } else if(checkboxCutiTahunan) {
      confirmReason = "Cuti Tahunan";
    } else if(checkboxKeperluanKeluarga) {
      confirmReason = "Keperluan Keluarga";
    } else if(checkboxSeminar) {
      confirmReason = "Seminar/Pelatihan";
    } else if(checkboxLainnya) {
      confirmReason = tf_price_food.text;
    } else {
      confirmReason = "";
    }
    print("reason => "+confirmReason);

    context.read<CutiCubit>().actionCuti(confirmSelectedFromDate, confirmSelectedToDate, confirmReason);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Form Pengajuan Cuti/Izin",style: TextStyle(fontFamily: baseUrlFontsPoppinsSemiBold,color: color_black),),
        leading: IconButton(icon: Icon(Icons.arrow_back_rounded,color: Colors.black,), onPressed: (){
          Navigator.pop(context);
        }),
        centerTitle: true,
      ),
      floatingActionButton: BlocConsumer<CutiCubit,CutiState>(
      builder: (context, state){
       return CustomButtonConfirm(
           onTap: (){
             if(state is !CutiLoading){
               actionConfirmCuti(context);
             }
           },
           title: "Ajukan",
           isEnable: true,
           buttonColor: color_primary,
           textColor: Colors.white,
           isLoading: (state is CutiLoading) ?true:false,
         );
        },
        listener: listenerCuti,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16,),
              Container(
                height: 50,
                margin: EdgeInsets.symmetric(horizontal: 16),
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 16,vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
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
                child: Row(
                  children: [
                    Icon(Icons.mail_outline_rounded),
                    SizedBox(width: 10,),
                    Expanded(child: Text(GeneralSharedPreferences.readString("user_mail"),maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 15,color: color_black,fontFamily: baseUrlFontsPoppinsSemiBold,fontWeight: FontWeight.bold),)),
                  ],
                ),
              ),
              Container(margin: EdgeInsets.all(16),child: Text("Cuti dari tanggal",style: TextStyle(fontSize: 15,color: color_black,fontFamily: baseUrlFontsPoppinsSemiBold,fontWeight: FontWeight.bold),)),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                child: CustomDatePickerForm(
                  controller: fromDateController,
                  onTap: (){
                    showDatePicker(
                      context: context,
                      initialDate: selectedFromYears == null ? DateTime.now():DateTime(selectedFromYears,selectedFromMonth,selectedFromdDay),
                      firstDate: DateTime(initYears,initMonth,initDay),
                      lastDate: selectedToYears == null ? DateTime(2099):DateTime(selectedToYears == null ? initYears:selectedToYears,selectedToMonth == null ?initMonth:selectedToMonth,selectedToDay == null ? initDay:selectedToDay),

                    ).then((date) {  //tambahkan setState dan panggil variabel _dateTime.
                      setState(() {
                        if(date == null){
                          print("date null");
                        } else {
                          print("date not null");
                          _dateTime = date;
                          fromDateController.text = _formatDate(date);
                          confirmSelectedFromDate = _formatDate2(date);
                          selectedFromYears = _dateTime.year;
                          selectedFromMonth = _dateTime.month;
                          selectedFromdDay = _dateTime.day;
                        }
                      });
                    });
                  },
                )
              ),
              Container(margin: EdgeInsets.all(16),child: Text("Cuti sampai tanggal",style: TextStyle(fontSize: 15,color: color_black,fontFamily: baseUrlFontsPoppinsSemiBold,fontWeight: FontWeight.bold),)),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                child: CustomDatePickerForm(
                  controller: toDateController,
                  onTap: (){
                    showDatePicker(
                      context: context,
                      initialDate: selectedToYears == null ? selectedFromYears == null ?DateTime.now():DateTime(selectedFromYears == null ? initYears:selectedFromYears,selectedFromMonth == null ?initMonth:selectedFromMonth,selectedFromdDay == null ? initDay:selectedFromdDay): DateTime(selectedToYears == null ? initYears:selectedToYears,selectedToMonth == null ?initMonth:selectedToMonth,selectedToDay == null ? initDay:selectedToDay),
                      firstDate: DateTime(selectedFromYears == null ? initYears:selectedFromYears,selectedFromMonth == null ?initMonth:selectedFromMonth,selectedFromdDay == null ? initDay:selectedFromdDay),
                      lastDate: DateTime(2099),

                    ).then((date) {  //tambahkan setState dan panggil variabel _dateTime.
                      setState(() {
                        if(date == null){
                          print("date null");
                        } else {
                          print("date not null");
                          _dateTime = date;
                          toDateController.text = _formatDate(date);
                          confirmSelectedToDate = _formatDate2(date);
                          selectedToYears = _dateTime.year;
                          selectedToMonth = _dateTime.month;
                          selectedToDay = _dateTime.day;
                        }
                      });
                    });
                  },
                )
              ),
              Container(margin: EdgeInsets.all(16),child: Text("Alasan Cuti",style: TextStyle(fontSize: 15,color: color_black,fontFamily: baseUrlFontsPoppinsSemiBold,fontWeight: FontWeight.bold),)),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
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
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Row(
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              FocusScope.of(context).unfocus();
                              setState(() {
                                checkboxSakit = true;
                                checkboxCutiTahunan = false;
                                checkboxKeperluanKeluarga = false;
                                checkboxSeminar = false;
                                checkboxLainnya = false;
                                // konfirmasi_harga = "1";
                                // btn_enable = true;
                                // harga_pesanan = "0";
                              });
                            },
                            child: Container(
                              height: 16,
                              width: 16,
                              margin: EdgeInsets.only(right: 8),
                              child: Stack(
                                children: <Widget>[
                                  Container(
                                    height: 16,
                                    width: 16,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(30),
                                        color: Colors.white,
                                        border: Border.all(
                                            color: checkboxSakit
                                                ? color_primary
                                                : Color(0xFFC4CDD5))),
                                  ),
                                  checkboxSakit
                                      ? Center(
                                    child: Container(
                                      height: 10,
                                      width: 10,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(30),
                                        color: color_primary,
                                      ),
                                    ),
                                  )
                                      : Container()
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              FocusScope.of(context).unfocus();
                              setState(() {
                                checkboxSakit = true;
                                checkboxCutiTahunan = false;
                                checkboxKeperluanKeluarga = false;
                                checkboxSeminar = false;
                                checkboxLainnya = false;
                                // konfirmasi_harga = "1";
                                // btn_enable = true;
                                // harga_pesanan = "0";
                              });
                            },
                            child: Text(
                              "Sakit",
                              style: TextStyle(
                                fontFamily: baseUrlFontsPoppinsSemiBold,
                                fontSize: 17,
                                color: checkboxSakit
                                    ? Color(0xFF212B36)
                                    : Color(0xFF637381),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Row(
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              FocusScope.of(context).unfocus();
                              setState(() {
                                checkboxSakit = false;
                                checkboxCutiTahunan = true;
                                checkboxKeperluanKeluarga = false;
                                checkboxSeminar = false;
                                checkboxLainnya = false;
                                // konfirmasi_harga = "1";
                                // btn_enable = true;
                                // harga_pesanan = "0";
                              });
                            },
                            child: Container(
                              height: 16,
                              width: 16,
                              margin: EdgeInsets.only(right: 8),
                              child: Stack(
                                children: <Widget>[
                                  Container(
                                    height: 16,
                                    width: 16,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(30),
                                        color: Colors.white,
                                        border: Border.all(
                                            color: checkboxCutiTahunan
                                                ? color_primary
                                                : Color(0xFFC4CDD5))),
                                  ),
                                  checkboxCutiTahunan
                                      ? Center(
                                    child: Container(
                                      height: 10,
                                      width: 10,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(30),
                                        color: color_primary,
                                      ),
                                    ),
                                  )
                                      : Container()
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              FocusScope.of(context).unfocus();
                              setState(() {
                                checkboxSakit = false;
                                checkboxCutiTahunan = true;
                                checkboxKeperluanKeluarga = false;
                                checkboxSeminar = false;
                                checkboxLainnya = false;
                                // konfirmasi_harga = "1";
                                // btn_enable = true;
                                // harga_pesanan = "0";
                              });
                            },
                            child: Text(
                              "Cuti Tahunan",
                              style: TextStyle(
                                fontFamily: baseUrlFontsPoppinsSemiBold,
                                fontSize: 17,
                                color: checkboxCutiTahunan
                                    ? Color(0xFF212B36)
                                    : Color(0xFF637381),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Row(
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              FocusScope.of(context).unfocus();
                              setState(() {
                                checkboxSakit = false;
                                checkboxCutiTahunan = false;
                                checkboxKeperluanKeluarga = true;
                                checkboxSeminar = false;
                                checkboxLainnya = false;
                                // konfirmasi_harga = "1";
                                // btn_enable = true;
                                // harga_pesanan = "0";
                              });
                            },
                            child: Container(
                              height: 16,
                              width: 16,
                              margin: EdgeInsets.only(right: 8),
                              child: Stack(
                                children: <Widget>[
                                  Container(
                                    height: 16,
                                    width: 16,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(30),
                                        color: Colors.white,
                                        border: Border.all(
                                            color: checkboxKeperluanKeluarga
                                                ? color_primary
                                                : Color(0xFFC4CDD5))),
                                  ),
                                  checkboxKeperluanKeluarga
                                      ? Center(
                                    child: Container(
                                      height: 10,
                                      width: 10,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(30),
                                        color: color_primary,
                                      ),
                                    ),
                                  )
                                      : Container()
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              FocusScope.of(context).unfocus();
                              setState(() {
                                checkboxSakit = false;
                                checkboxCutiTahunan = false;
                                checkboxKeperluanKeluarga = true;
                                checkboxSeminar = false;
                                checkboxLainnya = false;
                                // konfirmasi_harga = "1";
                                // btn_enable = true;
                                // harga_pesanan = "0";
                              });
                            },
                            child: Text(
                              "Keperluan Keluarga",
                              style: TextStyle(
                                fontFamily: baseUrlFontsPoppinsSemiBold,
                                fontSize: 17,
                                color: checkboxKeperluanKeluarga
                                    ? Color(0xFF212B36)
                                    : Color(0xFF637381),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Row(
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              FocusScope.of(context).unfocus();
                              setState(() {
                                checkboxSakit = false;
                                checkboxCutiTahunan = false;
                                checkboxKeperluanKeluarga = false;
                                checkboxSeminar = true;
                                checkboxLainnya = false;
                                // konfirmasi_harga = "1";
                                // btn_enable = true;
                                // harga_pesanan = "0";
                              });
                            },
                            child: Container(
                              height: 16,
                              width: 16,
                              margin: EdgeInsets.only(right: 8),
                              child: Stack(
                                children: <Widget>[
                                  Container(
                                    height: 16,
                                    width: 16,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(30),
                                        color: Colors.white,
                                        border: Border.all(
                                            color: checkboxSeminar
                                                ? color_primary
                                                : Color(0xFFC4CDD5))),
                                  ),
                                  checkboxSeminar
                                      ? Center(
                                    child: Container(
                                      height: 10,
                                      width: 10,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(30),
                                        color: color_primary,
                                      ),
                                    ),
                                  )
                                      : Container()
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              FocusScope.of(context).unfocus();
                              setState(() {
                                checkboxSakit = false;
                                checkboxCutiTahunan = false;
                                checkboxKeperluanKeluarga = false;
                                checkboxSeminar = true;
                                checkboxLainnya = false;
                                // konfirmasi_harga = "1";
                                // btn_enable = true;
                                // harga_pesanan = "0";
                              });
                            },
                            child: Text(
                              "Seminar/Pelatihan",
                              style: TextStyle(
                                fontFamily: baseUrlFontsPoppinsSemiBold,
                                fontSize: 17,
                                color: checkboxSeminar
                                    ? Color(0xFF212B36)
                                    : Color(0xFF637381),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    // Container(
                    //   margin: EdgeInsets.only(top: 16),
                    //   height: 1,
                    //   width: MediaQuery.of(context).size.width,
                    //   color: Colors.grey[300],
                    // ),
                    Container(
                      // color: Colors.yellow,
                      margin: EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        children: <Widget>[
                          Flexible(
                            flex: 0,
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  checkboxSakit = false;
                                  checkboxCutiTahunan = false;
                                  checkboxKeperluanKeluarga = false;
                                  checkboxSeminar = false;
                                  checkboxLainnya = true;
                                  // konfirmasi_harga = "2";
                                  // if(tf_price_food.text.toString().isEmpty || tf_price_food.text.toString() == "0"){
                                  //   btn_enable = false;
                                  // }else if(int.parse(tf_price_food.text.replaceAll(".", "")) <= widget.price_food){
                                  //   btn_enable = false;
                                  // }else{
                                  //   btn_enable = true;
                                  // }
                                  // harga_pesanan = tf_price_food.text.toString();
                                });
                              },
                              child: Container(
                                height: 16,
                                width: 16,
                                margin: EdgeInsets.only(right: 8),
                                child: Stack(
                                  children: <Widget>[
                                    Container(
                                      height: 16,
                                      width: 16,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(30),
                                          color: Colors.white,
                                          border: Border.all(
                                              color: checkboxLainnya
                                                  ? color_primary
                                                  : Color(0xFFC4CDD5))),
                                    ),
                                    checkboxLainnya
                                        ? Center(
                                      child: Container(
                                        height: 10,
                                        width: 10,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(30),
                                          color: color_primary,
                                        ),
                                      ),
                                    )
                                        : Container()
                                  ],
                                ),
                              ),
                            ),
                          ),
                          // InkWell(
                          //   onTap: () {
                          //     setState(() {
                          //       checkbox_wanita = true;
                          //       checkbox_pria = false;
                          //     });
                          //   },
                          //   child: Text(
                          //     "40.000",
                          //     style: TextStyle(
                          //       fontFamily: "PoppinsSemiBold",
                          //       fontSize: 17,
                          //       color: checkbox_wanita
                          //           ? Color(0xFF212B36)
                          //           : Color(0xFF637381),
                          //     ),
                          //   ),
                          // )
                          Flexible(
                              flex: 1,
                              child: Container(
                                // height: 25,
                                // color: Colors.green,
                                child: TextFormField(
                                  controller: tf_price_food,
                                  enableInteractiveSelection: false,
                                  // inputFormatters: [
                                  //   WhitelistingTextInputFormatter.digitsOnly,
                                  //   // new NumericTextFormatter(),
                                  //   new LengthLimitingTextInputFormatter(11),
                                  // ],
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Alasan Lain",
                                  ),
                                  cursorColor: color_primary,
                                  style: TextStyle(
                                    fontFamily: "PoppinsSemiBold",
                                    fontSize: 17,
                                    color: checkboxLainnya
                                        ? Color(0xFF212B36)
                                        : Color(0xFF637381),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      checkboxSakit = false;
                                      checkboxCutiTahunan = false;
                                      checkboxKeperluanKeluarga = false;
                                      checkboxSeminar = false;
                                      checkboxLainnya = true;
                                      // konfirmasi_harga = "2";
                                      // if(tf_price_food.text.toString().isEmpty || tf_price_food.text.toString() == "0"){
                                      //   btn_enable = false;
                                      // }else if(int.parse(tf_price_food.text.replaceAll(".", "")) <= widget.price_food){
                                      //   btn_enable = false;
                                      // }else{
                                      //   btn_enable = true;
                                      // }
                                      // harga_pesanan = tf_price_food.text.toString();
                                    });
                                  },
                                  onChanged: (text){
                                    setState(() {
                                      print(text);
                                      // if(text.length == 0 || text.toString() == "0"){
                                      //   btn_enable = false;
                                      // }else if(int.parse(text.replaceAll(".", "")) <= widget.price_food){
                                      //   btn_enable = false;
                                      // }else{
                                      //   btn_enable = true;
                                      //   harga_pesanan = text.toString();
                                      // }
                                    });
                                  },
                                ),
                              )
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
