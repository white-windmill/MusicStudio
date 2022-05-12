import 'package:flutter/material.dart';

List listData = [
  {
    "name": '稻香',
    "singer": "周杰伦",
  },
  {
    "name": '稻香',
    "singer": "周杰伦",
  },
  {
    "name": '稻香',
    "singer": "周杰伦",
  },
  {
    "name": '稻香',
    "singer": "周杰伦",
  },
  {
    "name": '稻香',
    "singer": "周杰伦",
  },
  {
    "name": '稻香',
    "singer": "周杰伦",
  },
  {
    "name": '稻香',
    "singer": "周杰伦",
  },
  {
    "name": '稻香',
    "singer": "周杰伦",
  },
  {
    "name": '稻香',
    "singer": "周杰伦",
  },
  {
    "name": '稻香',
    "singer": "周杰伦",
  },
  {
    "name": '稻香',
    "singer": "周杰伦",
  },
  {
    "name": '稻香',
    "singer": "周杰伦",
  },
  {
    "name": '稻香',
    "singer": "周杰伦",
  },
];

class MySong extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
// TODO: implement build
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
          "我的歌曲",
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.black54,
          ),
        ),
      ),
      body: ListView(
        children: listData.map((value) {
          return Card(
            margin: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                InkWell(
                  onTap: () {
                    print("播放音乐");
                  },
                  child: ListTile(
                    title: Text(value["name"]),
                    subtitle:
                        Text(value["singer"], overflow: TextOverflow.ellipsis),
                  ),
                )
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
