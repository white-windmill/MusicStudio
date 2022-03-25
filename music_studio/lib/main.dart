import 'package:flutter/material.dart';
import 'package:music_studio/bottom.dart';

import 'loginPage/login.dart';
import 'mainPages/communityPage/communityAll.dart';
import 'mainPages/homePage/homeAll.dart';
import 'mainPages/minePage/mineAll.dart';
void main() {
  runApp(Router());
}

class Router extends StatelessWidget {
  final routes = {
   '/login': (context) => Login(),
    '/home': (context) => homePage(),
    '/community': (context) => communityPage(),
    '/mine': (context) =>minePage(),
    '/bottom':(context) => Bottom(),
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
      },
    );
  }}