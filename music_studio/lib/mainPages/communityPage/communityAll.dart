import 'package:flutter/material.dart';
import 'package:music_studio/mainPages/homePage/searchMessagePart.dart';

import 'addPostPart.dart';

class communityPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
       
         body: Container(
           decoration: new BoxDecoration(color: Colors.red),
           child: Expanded(child: Text("zheshi shequ ") ,)
          ,
         ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, new MaterialPageRoute(builder: (
              BuildContext context,
            ) {
              return new addPostCard();
            }));
          },
          child: IconButton(
              icon: Icon(Icons.add_circle),
              onPressed: () {
                Navigator.push(context, new MaterialPageRoute(builder: (
                  BuildContext context,
                ) {
                  return new addPostCard();
                }));
              }),
          foregroundColor: Colors.white,
          backgroundColor: Color.fromARGB(255, 180, 210, 250),
        ),
      ),
    );
  }
}
