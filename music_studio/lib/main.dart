import 'package:flutter/material.dart';
import 'package:music_studio/bottom.dart';
import 'package:music_studio/loginPage/forget_password.dart';
import 'package:music_studio/loginPage/sign_up.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'loginPage/sign_up.dart';
import 'loginPage/login.dart';
import 'mainPages/communityPage/communityAll.dart';
import 'mainPages/homePage/homeAll.dart';
import 'mainPages/minePage/mineAll.dart';
void main() {
  runApp(Router());
}

class SpUtil {
  static SharedPreferences prefs;
  static Future<bool> getUserName() async {
    prefs = await SharedPreferences.getInstance();
    return true;
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: MyHomePage(),
      routes: {
        // '/': (BuildContext context) => HomePage(),
        // '/image': (context) => ImageSelector(),
      },
    );
  }
}
class Router extends StatelessWidget {
  final routes = {
   '/login': (context) => Login(),
    '/home': (context) => homePage(),
    '/community': (context) => communityPage(),
    '/mine': (context) =>minePage(),
    '/bottom':(context) => Bottom(),
    '/sign_up':(context) => SignUp(),
    '/forget_password':(context) => ForgetPassword(),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/login',
      //routes: routes,
      onGenerateRoute: (RouteSettings settings) {
        //统一处理
        final String name = settings.name;
        final Function pageContentBuilder = this.routes[name];
        if (pageContentBuilder != null) {
          if (settings.arguments != null) {
            final Route route = MaterialPageRoute(
                builder: (context) =>
                    pageContentBuilder(context, arguments: settings.arguments));
            return route;
          } else {
            final Route route = MaterialPageRoute(
                builder: (context) => pageContentBuilder(context));
            return route;
          }
        }
        return null;
      },);
  }
  }

