import 'package:flutter/material.dart';
import 'package:music_studio/mainPages/homePage/editorialSelection.dart';
import 'package:music_studio/mainPages/homePage/rotationPart.dart';
import 'package:music_studio/mainPages/homePage/searchMessagePart.dart';

class homePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        title: Text(
          '首页',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: homeAll(),
    );
  }
}

class homeAll extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: new BoxDecoration(color: Colors.white),
        // child: rotationChart(),
        child: CustomScrollView(
          scrollDirection: Axis.vertical,
          slivers: <Widget>[
            SliverList(
              delegate: new SliverChildListDelegate(
                [
                  Container(
                    child: Column(
                      children: <Widget>[
                         SizedBox(
                          height: 20,
                        ),
                        searchMessage(),
                         SizedBox(
                          height:20,
                        ),
                        rotationChart(),
                        
                        SizedBox(
                          height: 20,
                        ),
                        editorialSelection(),
                      ],
                    ),
                    alignment: Alignment.center,
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
