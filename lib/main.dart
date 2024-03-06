import 'package:absen_online/constant/color_constant.dart';
import 'package:absen_online/ui/screen/splashscreen.dart';
import 'package:absen_online/ui/widget/button/custom_button_confirm.dart';
import 'package:absen_online/utils/bloc_list/bloc_list.dart';
import 'package:absen_online/utils/general_shared_preferences/general_shared_preferences.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
Logger? logger;
// final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await setUpApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This ui.widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: blocList,
      child: MaterialApp(
        title: 'Absen Online',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.red,
        ),
        builder: (context, child) {
          return ScrollConfiguration(
            behavior: RemoveScrollGlowBehavior(),
            child: child!,
          );
        },
        home: Splashscreen(),
      ),
    );
  }
}

Future<void> setUpApp()async{
  await GeneralSharedPreferences.setUp();
  // client = RepositoryApiRetrofit.loginInterceptor();
  // client = RepositoryApiRetrofit.generalInterceptor();
  logger = Logger();
}

class RemoveScrollGlowBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title}) : super(key: key);

  // This ui.widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App ui.widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  bool isChange = false;
  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title!),
      ),
      body: Center(
        // Center is a layout ui.widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout ui.widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each ui.widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            Container(
              height: 70,
              width: 70,
              child: ElevatedButton(
                  onPressed: (){
                setState(() {
                  isChange = !isChange;
                });
              },
                  style: ElevatedButton.styleFrom(
                    elevation: 5,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100))
                  ),
                  child: Text("Change color")),
            )
          ],
        ),
      ),
      floatingActionButton: CustomButtonConfirm(
        onTap: (){
          print("confirm absen");
        },
        title: "Absen",
        isEnable: isChange,
        buttonColor: color_primary,
        textColor: Colors.white,
        isLoading: false,
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
