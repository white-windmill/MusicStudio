import 'dart:convert';
import 'dart:ui';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

String imagepicList;
dynamic test;
DateTime time;
List aList;
List<Widget> tiles;
String UID;

class addPostCard extends StatefulWidget {
  //addPostCard({Key? key}) : super(key: key);

  @override
  State<addPostCard> createState() => _addPostCardState();
}

class _addPostCardState extends State<addPostCard> {
  @override
  Widget build(BuildContext context) {
    // getUID();
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
                      backgroundColor: Color.fromARGB(255, 255, 255, 255),
                      leading: IconButton(
                        icon: new Icon(Icons.chevron_left,
                            color: Colors.black, size: 30),
                        onPressed: () {
                          Navigator.of(context)..pop();
                        },
                      ),
                      centerTitle: true,
                      title: Text(
                        '发布动态',
                        style: TextStyle(color: Colors.black),
                      ),
                      actions: [
                        TextButton(
                          child:
                              Text("发布", style: TextStyle(color: Colors.black)),
                          onPressed: () {
                            // getTAG();
                            // print(TAG);
                            DateTime now = new DateTime.now();
                            // IMGS.clear();
                            // for (int i = 0; i < imageUrl.length; ++i)
                            //   IMGS.add(imageUrl[i].toString());
                            // insertPost(int.parse(UID), TAG.toString(), TEXT,
                            //     now.toString(), IMGS);
                            // setTag("");
                            // for (var i in imageUrl) {
                            //   print(i + "  im imageUrl");
                            // }
                            Navigator.pop(context);
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              // return indexPage(now: 3);
                            }));
                            ;
                          },
                        )
                      ],
                    ),
                    resizeToAvoidBottomInset: false,
                    body: new Column(children: [
                     
                      SizedBox(height: 5),
                      Center(
                          child: SizedBox(
                              width: 330,
                              height: 120,
                              )),
                      SizedBox(height: 5),
                      SizedBox(
                          width: 330,
                          height: 200,
                          child: TextField(
                              keyboardType: TextInputType.text,
                              cursorColor: Colors.blue,
                              cursorWidth: 5,
                              maxLines: 8,
                              decoration: InputDecoration(
                                  hintText: '请输入你想发布的内容...',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15)))),
                              onChanged: (a) {
                                // TEXT = a;
                              })),
                      IconButton(
                          icon: Icon(Icons.photo),
                          iconSize: 80,
                          onPressed: () {
                            // choosePic(ImageSource.gallery);
                          }),
                      Wrap(
                          spacing: 20, //主轴上子控件的间距
                          runSpacing: 5, //交叉轴上子控件之间的间距
                          // children: imageList
                          )
                    ])))));
  }
}
