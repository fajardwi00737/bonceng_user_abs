import 'package:absen_online/constant/assets_constant.dart';
import 'package:absen_online/ui/screen/absensi_page.dart';
import 'package:absen_online/ui/screen/attendance_recap_page.dart';
import 'package:absen_online/ui/screen/home_page.dart';
import 'package:absen_online/ui/screen/pengajuan_cuti_page.dart';
import 'package:absen_online/ui/screen/profile_page.dart';
import 'package:flutter/material.dart';

class HomeNavigation extends StatefulWidget {
  @override
  _HomeNavigationState createState() => _HomeNavigationState();
}

class _HomeNavigationState extends State<HomeNavigation> {
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[];

  _setChildren() async {
    _widgetOptions.add(HomePage());
    _widgetOptions.add(ProfilePage());
  }

  @override
  void initState() {
    _setChildren();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildMain();
  }

  _buildMain() {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Container(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          showUnselectedLabels: false,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              label: 'Beranda',
              icon: Icon(Icons.home_rounded),
              // title: Text(
              //   'Beranda',
              //   style: TextStyle(fontFamily: baseUrlFontsPoppinsRegular),
              // ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Beranda',
              // title: Text(
              //   'Profile',
              //   style: TextStyle(fontFamily: baseUrlFontsPoppinsRegular),
              // ),
            ),
          ],
          currentIndex: _selectedIndex,
          unselectedItemColor: Color(0xFF919EAB),
          selectedItemColor: Color(0xFFE52920),
          onTap: _onItemTapped,
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
