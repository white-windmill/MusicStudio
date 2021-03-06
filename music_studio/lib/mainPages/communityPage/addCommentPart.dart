import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:music_studio/common/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

String text;
String UID;
final TextEditingController _userEtController = new TextEditingController();
getUID() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  UID = prefs.getString("id");
}

class addCommentpart extends StatefulWidget {
  addCommentpart({Key key, this.articleid}) : super(key: key);
  String articleid;
  String text;
  @override
  _addCommentpartState createState() => _addCommentpartState();
}

class _addCommentpartState extends State<addCommentpart> {
  insertComment(
      String articleid, String uid, String text, String commenttime) async {
        print('articleid'+articleid);
      print(uid);
    var url = Uri.parse(Api.url + '/api/comment/');
    var response = await http.post(url,
        headers: {"content-type": "application/json"},
        body:
            '{"articleid": "${articleid}", "userid": "${uid}","commentcontent": "${text}",' +
                '"commenttime": "${commenttime}"}');
  }

  @override
  Widget build(BuildContext context) {
    getUID();
    return SizedBox(
        width: 450,
        height: 600,
        child: Container(
            width: 400,
            height: 500,
            decoration: new BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(25.0))),
            child: SizedBox(
                width: 400,
                height: 300,
                child: Scaffold(
                    appBar: new AppBar(
                      backgroundColor: Color.fromARGB(255, 176, 210, 176),
                      leading: IconButton(
                          icon: Icon(Icons.arrow_back),
                          onPressed: () {
                            Navigator.pop(context);
                          }),
                      title: Text('??????',
                          style: TextStyle(
                              fontSize: 28.0, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center),
                      actions: [
                        TextButton(
                            child: Text("??????",
                                style: TextStyle(color: Colors.black)),
                            onPressed: () {
                              DateTime now = new DateTime.now();
                              String time=now.toString().substring(0,19);
                              // print(_userEtController.text);
                              insertComment(widget.articleid, UID, _userEtController.text, time);
                              // print(now.toString().substring(0,19));
                              Fluttertoast.showToast(msg: '????????????');
                              Navigator.of(context).pop();
                            })
                      ],
                    ),
                    body: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 20),
                        child: SizedBox(
                            child: TextField(
                          controller: _userEtController,
                          cursorColor: Colors.blue,
                          cursorWidth: 5,
                          maxLines: 8,
                          decoration: InputDecoration(
                              hintText: '??????????????????????????????',
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)))),
                        )))))));
  }
}
