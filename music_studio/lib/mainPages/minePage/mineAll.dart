import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:music_studio/common/api.dart';
import 'package:music_studio/player_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

String myid;
List listData = [];

class minePage extends StatefulWidget {

  const minePage({Key key,}) : super(key: key);

  _minePageState createState() => _minePageState();
}

class _minePageState extends State<minePage> {
  _minePageState();
  final double _appBarHeight = 120.0;
  final String _userHead =
      'http://img.chinau.com.cn/attachment//stampNew/20190424/2019042417080487564_t4.jpg';
  @override
  void initState() {
    _readShared();
    super.initState();
    getData(myid);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //AppBar下端黑线
        bottom: PreferredSize(
            child: Container(
              color: Colors.black38,
              height: 2.0,
            ),
            preferredSize: Size.fromHeight(4.0)),
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0, //将向导栏的阴影设为0，确保全透明
        backgroundColor: Colors.transparent, //将向导栏设为透明颜色
        title: Text(
          "我的",
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.black54,
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            expandedHeight: _appBarHeight,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              background: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      print("已点击");
                      Navigator.pushNamed(context, '/modify');
                      
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 13,
                            ),
                            child: CircleAvatar(
                              radius: 35.0,
                              backgroundImage: NetworkImage(_userHead),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  bottom: 10.0,
                                ),
                                // child: InkWell(
                                child: Text(
                                "text",
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0),
                                ),
                                //   onTap: () {
                                //     print("已点击");
                                //     Navigator.pushNamed(context, '/infor',
                                //         arguments: {
                                //           'username': arguments['username'],
                                //           'userHead': _userHead
                                //         });
                                //   },
                                // )
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 0,
                                ),
                                child: Text(
                                  '暂无个人简介',
                                  style: TextStyle(
                                      color: Colors.black54, fontSize: 15.0),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20.0, top: 120),
                    child: Divider(
                      color: Colors.black12,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              <Widget>[
                // Container(
                //   color: Colors.white,
                //   child: Padding(
                //     padding: const EdgeInsets.only(
                //       top: 10.0,
                //       bottom: 10.0,
                //     ),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceAround,
                //       children: [
                //         ContactItem(
                //           icon: Icons.favorite,
                //           title: '巴拉巴拉',
                //           onPressed: () {
                //             //路由跳转
                //           print("click");
                //           },
                //         ),
                //         ContactItem(
                //           icon: Icons.grade,
                //           title: '巴拉巴拉',
                //         ),
                //         ContactItem(
                //           icon: Icons.brightness_4,
                //           title: '巴拉巴拉',
                //         ),
                //         ContactItem(
                //           icon: Icons.airplanemode_active,
                //           title: '巴拉巴拉',
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                Container(
                  color: Colors.white,
                  margin: const EdgeInsets.only(top: 10.0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black26,
                            width: 1.0,
                            style: BorderStyle.solid,
                          ),
                        ),
                        child: Column(
                          children: [
                            MenuItem(
                              title: '我的歌曲',
                              onPressed: () {
                                //路由跳转
                                Navigator.pushNamed(context, '/my_song');
                              
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, right: 20.0),
                              child: Divider(
                                color: Colors.black12,
                              ),
                            ),
                            MenuItem(
                              title: '我的歌单',
                              onPressed: () {
                                //路由跳转
                                Navigator.pushNamed(context, '/my_songsheet');
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black26,
                            width: 1.0,
                            style: BorderStyle.solid,
                          ),
                        ),
                        child: Column(
                          children: [
                            MenuItem(
                              title: '音乐足迹',
                              onPressed: () {
                               print("click");
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, right: 20.0),
                              child: Divider(
                                color: Colors.black12,
                              ),
                            ),
                            MenuItem(
                              title: '猜你想听',
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ContactItem extends StatelessWidget {
  ContactItem({Key key, this.icon, this.title, this.onPressed})
      : super(key: key);
  final IconData icon;
  final String title;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              bottom: 4.0,
            ),
            child: Icon(icon),
          ),
          Text(title,
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 14.0,
                  letterSpacing: -1,
                  wordSpacing: -1)),
        ],
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  MenuItem({Key key, this.title, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.only(
                left: 20.0,
                top: 12.0,
                right: 20.0,
                bottom: 10.0,
              ),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 8.0,
                    ),
                  ),
                  Expanded(
                      child: Text(
                    title,
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 16.0,
                        letterSpacing: -1,
                        wordSpacing: -1),
                  )),
                  Icon(
                    Icons.chevron_right,
                    color: Colors.grey,
                  )
                ],
              )),
        ],
      ),
    );
  }
}
Future _readShared() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  myid = preferences.get('id');
  print(myid);
}

getData(String userid) async {
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
