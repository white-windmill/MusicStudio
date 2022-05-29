import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:music_studio/mainPages/minePage/mineAll.dart';

class Footstep extends StatefulWidget {
  const Footstep({Key key,}) : super(key: key);

  _FootstepState createState() => _FootstepState();
  
}
class _FootstepState extends State<Footstep> {

    @override
  void initState() {
    super.initState();

  }

  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false, //隐藏返回按钮
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        elevation: 0, //将向导栏的阴影设为0，确保全透明
        backgroundColor: Colors.transparent, //将向导栏设为透明颜色
        title: Text(
          "音乐足迹",
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.black54,
          ),
        ),
      ),
    body: ListView(
      children: history.map((value){
        return Container(
          height: 100,
          child: GestureDetector(
            onDoubleTap:() => showSnackBar(value['perception']),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(value['listentime']),
                Text(value['musicid']),
              ],
            ),
          ),

        );

      }).toList(),
    ),
    );
  }
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  void showSnackBar(String message) {
    var snackBar = SnackBar(
        content: Text(message),
        backgroundColor: Colors.lightGreen,
        duration: Duration(milliseconds: 1000));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }
}



