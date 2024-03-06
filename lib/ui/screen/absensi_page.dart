import 'dart:async';

import 'package:absen_online/bloc/absen_cubit/absen_cubit.dart';
import 'package:absen_online/constant/assets_constant.dart';
import 'package:absen_online/constant/color_constant.dart';
// import 'package:absen_online/ui/support/flushbar/flushbar_notification.dart';
import 'package:absen_online/ui/widget/button/custom_button_confirm.dart';
import 'package:absen_online/utils/general_shared_preferences/general_shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart' as Geo;
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AbsensiPage extends StatefulWidget {
  @override
  _AbsensiPageState createState() => _AbsensiPageState();
}

class _AbsensiPageState extends State<AbsensiPage> {
  Position? _position;
  Future? _mapFuture;
  Completer<GoogleMapController> mapController = Completer();
  Map<MarkerId, Marker> _markersSBM = <MarkerId, Marker>{};
  String? _timeString,_timeStringConfirm,userAddress = "",_dateString,_dateStringConfirm;
  Timer? _timer;
  int absenType = 1;
  TextEditingController notesController = TextEditingController();
  List<DropdownMenuItem<String>> get dropdownItems{
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("Absen Masuk"),value: "Absen Masuk"),
      DropdownMenuItem(child: Text("Absen Pulang"),value: "Absen Pulang"),
    ];
    return menuItems;
  }
  String selectedValue = "Absen Masuk";
  @override
  void initState() {
    fistOpenPage();
    _mapFuture = _getCurrentLocationInit();
    _timeString = _formatTime(DateTime.now());
    _dateString = _formatDate(DateTime.now());
    _timer = Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
    // TODO: implement initState
    super.initState();
  }

  void _getTime() {
    final DateTime now = DateTime.now();
    final String formattedDateTime = _formatTime(now);
    setState(() {
      _timeString = formattedDateTime;
    });
  }

  String _formatTime(DateTime dateTime) {
    return DateFormat('HH:mm:ss').format(dateTime);
  }

  String _formatDate(DateTime dateTime) {
    return DateFormat('dd MMMM yyyy').format(dateTime);
  }

  String _formatDate2(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }

  actionConfirmAttendance(BuildContext context)async{
    _timeStringConfirm = _formatTime(DateTime.now());
    _dateStringConfirm = _formatDate2(DateTime.now());
    print("Lokasi => "+userAddress!);
    print("Time => "+_timeStringConfirm!);
    print("date => "+_dateStringConfirm!);
    print("Type Absen => "+selectedValue);
    print("Type => "+absenType.toString());
    print("Keterangan => "+notesController.text.toString());

    context.read<AbsenCubit>().actionAbsen(GeneralSharedPreferences.readInt("user_id").toString(), _dateStringConfirm!, _timeStringConfirm!, absenType.toString(), userAddress!);
  }

  @override
  void dispose() {
    _timer!.cancel();
    notesController.dispose();
    super.dispose();
  }

  fistOpenPage()async{
    Position res = await Geolocator.getCurrentPosition();

    setState(() {
      _position = res;
    });
  }

  Future _getCurrentLocationInit() async {
    //await _progressDialog.show();

    Position res = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);

    try {
      List<Geo.Placemark> placemark = await Geo.placemarkFromCoordinates(
          res.latitude, res.longitude);
      for (int i = 0; i < placemark.length; i++) {
        print("city $i => " + placemark[i].toString());
      }
      // print('hahahahah == ' + placemark[placemark.length > 1 ? 1 : 0]["Street"]);
      // print('hahahahah == ' + placemark[0]["Street"]);
      setState(() {
        // userAddress = placemark[placemark.length > 1 ? 1 : 0].street;
        userAddress = placemark[0].street!;
      });
    } catch (err) {
      print(err);
    }

    setState(() {
      _position = res;
      print('hahahaha ads== ' + _position!.latitude.toString());
      print('hahahaha asd== ' + _position!.longitude.toString());
      print('hahahaha asd== ' + res.toString());
      print('hahahaha asd== ' + userAddress!);
    });

    MarkerId markerId = MarkerId("1");
    LatLng position = LatLng(_position!.latitude, _position!.longitude);
    Marker marker = Marker(
      markerId: markerId,
      position: position,
      draggable: false,
    );
    setState(() {
      _markersSBM[markerId] = marker;
    });
    //await updateCameraLocation();

    return _position;
  }
  void _onMapCreated(GoogleMapController controller)async {
    await rootBundle
        .loadString('assets/maps/styleMapsAll.json')
        .then((String mapStyle) {
      controller.setMapStyle(mapStyle);
    });
    mapController.complete(controller);

    MarkerId markerId = MarkerId("1");
    LatLng position = LatLng(_position!.latitude, _position!.longitude);
    Marker marker = Marker(
      markerId: markerId,
      position: position,
      draggable: false,
    );
    setState(() {
      _markersSBM[markerId] = marker;
    });
  }

  void _listenerAbsen(BuildContext context, AbsenState state) {
    if (state is AbsenLoading) {
      print('absen Loading');
    }
    if (state is AbsenFailed) {
      print('absen Failed');
      // FlushbarNotification.flushbarTop(
      //     context,
      //     FlushbarPosition.BOTTOM,
      //     state.msg,
      //     Colors.white,
      //     color_failed,
      //     Icon(
      //       Icons.check_circle,
      //       color: Colors.white,
      //     ),
      //     false);
      // FlushbarNotif.failedBottom(context, "Username atau password salah");

    }
    if (state is AbsenSucces) {
      // FlushbarNotif.successBottom(context, "Login Berhasil");
      print('absen Succezz');
      // FlushbarNotification.flushbarTop(
      //     context,
      //     FlushbarPosition.BOTTOM,
      //     state.msg,
      //     Colors.white,
      //     color_success,
      //     Icon(
      //       Icons.check_circle,
      //       color: Colors.white,
      //     ),
      //     false);
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeNavigation()));
      Future.delayed(Duration(seconds: 3), () {
        Navigator.pop(context);
      });
    }
    if (state is AbsenError) {
      print('state error');
      print('state error => '+state.msg!);
      // FlushbarNotification.flushbarTop(
      //     context,
      //     FlushbarPosition.BOTTOM,
      //     "Request gagal! Silakan coba lagi",
      //     Colors.white,
      //     color_failed,
      //     Icon(
      //       Icons.check_circle,
      //       color: Colors.white,
      //     ),
      //     false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:FutureBuilder(
          future: _mapFuture,
          builder:(context, snapshot) {
            if (snapshot.connectionState == ConnectionState.none &&
                snapshot.hasData == null) {
              print('AYAAMMMMMM KAMPUSSSSSSSSSSS');
              //_progressDialog.dismiss();
              // _progressDialog.hide();
              return Container(color: Colors.red);
            } else if (snapshot.connectionState == ConnectionState.done) {
              //_progressDialog.dismiss();
              // _progressDialog.hide();
              print('AYAAMMMMMM GOREEEENGGGGGGGGGGG');
              return buildBody();
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              print('AYAAMMMMMM POOOOOOOOOOOOOOOPPPPPP');
              //_progressDialog.show();
              return Scaffold(
                body: Center(
                  child: Visibility(
                      visible: true,
                      child: Container(
                        height: 50,
                        width: 50,
                        child: CircularProgressIndicator(strokeWidth: 6),
                      )),
                ),
              );
            }
            return buildBody();
          }
      )
    );
  }

  buildBody(){
    return BlocConsumer<AbsenCubit,AbsenState>(
        listener: _listenerAbsen,
    builder: (context, state) {
      return WillPopScope(
        onWillPop: () async {
          if(state is AbsenLoading){
            print("cannot pop");
          } else {
            Navigator.pop(context);
          }
          return false;
        },
        child: Scaffold(
          floatingActionButton: CustomButtonConfirm(
                onTap: () {
                  if (state is! AbsenLoading) {
                    actionConfirmAttendance(context);
                  }
                },
                title: "Absen",
                isEnable: true,
                buttonColor: color_primary,
                textColor: Colors.white,
                isLoading: (state is AbsenLoading) ? true : false,
              ),
          body: SingleChildScrollView(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8,),
                    Container(
                      margin: EdgeInsets.all(16),
                      child: IconButton(icon: Icon(Icons.arrow_back_rounded),
                          onPressed: () {
                            if(state is AbsenLoading){
                              print("cannot pop");
                            } else {
                              Navigator.pop(context);
                            }
                          }),
                    ),
                    Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
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
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("$_timeString", style: TextStyle(fontSize: 24,
                              color: color_secondary,
                              fontFamily: baseUrlFontsPoppinsSemiBold,
                              fontWeight: FontWeight.bold),),
                          Text(_dateString!, style: TextStyle(fontSize: 15,
                              color: color_black,
                              fontFamily: baseUrlFontsPoppinsSemiBold,
                              fontWeight: FontWeight.bold),),
                        ],
                      ),
                    ),
                    Container(margin: EdgeInsets.all(16),
                        child: Text("Lokasi Saat Ini", style: TextStyle(
                            fontSize: 17,
                            color: color_black,
                            fontFamily: baseUrlFontsPoppinsSemiBold,
                            fontWeight: FontWeight.bold),)),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      height: 200,
                      child: GoogleMap(
                        markers: Set<Marker>.of(_markersSBM.values),
                        zoomControlsEnabled: false,
                        onMapCreated: _onMapCreated,
                        initialCameraPosition: CameraPosition(
                          target: LatLng(_position!.latitude,
                              _position!.longitude),
                          zoom: 17.6,
                        ),
                      ),
                    ),
                    SizedBox(height: 16,),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      padding: EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
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
                          Icon(Icons.location_on),
                          SizedBox(width: 10,),
                          Expanded(child: Text(userAddress!, maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 12,
                                color: color_black,
                                fontFamily: baseUrlFontsPoppinsSemiBold,
                                fontWeight: FontWeight.bold),)),
                        ],
                      ),
                    ),
                    Container(
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
                      margin: EdgeInsets.all(16),
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      child: DropdownButtonFormField(
                          icon: Icon(Icons.chevron_right),
                          style: TextStyle(
                              fontFamily: baseUrlFontsPoppinsSemiBold,
                              fontSize: 13,
                              color: color_black),
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.grey.shade300, width: 1),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          dropdownColor: Colors.white,
                          value: selectedValue,
                          onChanged: (newValue) {
                            setState(() {
                              selectedValue = newValue.toString();
                              if (selectedValue == "Absen Masuk") {
                                absenType = 1;
                              } else {
                                absenType = 2;
                              }
                            });
                          },
                          items: dropdownItems),
                    ),
                    // Container(
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(16),
                    //     color: Colors.white,
                    //     boxShadow: [
                    //       BoxShadow(
                    //         color: Colors.grey.withOpacity(0.5),
                    //         spreadRadius: 1,
                    //         blurRadius: 3,
                    //         offset: Offset(0, 0),
                    //       ),
                    //     ],
                    //   ),
                    //   margin: EdgeInsets.only(left: 16, right: 16),
                    //   padding: EdgeInsets.all(16),
                    //   child: TextField(
                    //     controller: notesController,
                    //     style: TextStyle(
                    //         fontFamily: baseUrlFontsPoppinsRegular),
                    //     maxLines: 5,
                    //     maxLength: 150,
                    //     decoration: InputDecoration(
                    //         border: InputBorder.none,
                    //         hintText: "Berikan Keterangan (Opsional)"
                    //     ),
                    //     //onSubmitted: _getNotes(),
                    //   ),
                    // ),
                    SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              )
          ),
        ),
      );
    }
    );
  }
}
