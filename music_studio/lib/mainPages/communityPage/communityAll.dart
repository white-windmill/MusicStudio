import 'package:flutter/material.dart';

class communityPage extends StatelessWidget{
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
      body: communityAll(),
    );
  }
} 

class communityAll extends StatelessWidget {
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