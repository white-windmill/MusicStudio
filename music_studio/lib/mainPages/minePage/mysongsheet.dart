import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:music_studio/common/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'mineAll.dart';

// List listData = [
//   {
//     "name": '稻香',
//     "imageurl": "https://picsum.photos/250?image=9",
//   },
// ];

String myid;

class MySongSheet extends StatefulWidget {
  @override
  State<MySongSheet> createState() => _MySongSheetState();
}

class _MySongSheetState extends State<MySongSheet> {
  void initState() {
    // _readShared();
    
      super.initState();
      print(listData);

    // getData(myid, context);
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          "我的歌单",
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.black54,
          ),
        ),
      ),
      body: ListView(
        
        children: listData.map((value) {
          
          return Container(
            height: 150,
            child: Card(
                // color: Colors.orange,
                child: GestureDetector(
              onTap: () {
                print("访问这个歌单");
              },
              child: Row(
                children: [
                  Expanded(
                    flex: 33,
                    child: Image.network(
                      value['imageurl'],
                      // "https://picsum.photos/250?image=9"
                    ),
                  ),
                  Expanded(
                    flex: 66,
                    child: Column(
                      children: [
                        Expanded(
                          flex: 50,
                          child: Center(
                              child: Text(
                            value['name'],
                            // "周杰伦",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          )),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )),
          );
        }).toList(),
      ),
    );
  }
}

Future _readShared() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  myid = preferences.get('id');
  print(myid);
}

getData(String userid, BuildContext context) async {
  var url = Api.url + '/api/user/';
  var urlImage = Api.url + '/media';
  try {
    Map<String, dynamic> map = Map();
    map['userid'] = userid;
    var dio = Dio();
    var response =
        await dio.get(url, queryParameters: map);
    print('Response: $response');
    Map<String, dynamic> data = response.data;
    print(data['data']);
    print(data['data'][0]['usercreatedata']);
    print(data['data'][0]['usercreatedata'].length);
    if (data['ret'] == 0) {
      for (int i = 0; i < data['data'][0]['usercreatedata'].length; i++) {
        listData[i] = {
          'name': data['data'][0]['usercreatedata'][i]['playlistname'],
          'imageurl':
              urlImage + data['data'][0]['usercreatedata'][i]['playlistimage'],
        };
      }
      print("listdata:$listData");

      Fluttertoast.showToast(msg: '登录成功!');
    } else {
      Fluttertoast.showToast(msg: '用户名或密码错误!');
    }
  } catch (e) {
    print(e);
    return null;
  }
}
