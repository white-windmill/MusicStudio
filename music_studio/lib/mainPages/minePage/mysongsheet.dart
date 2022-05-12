import 'package:flutter/material.dart';

List listData = [
  {
    "name": '稻香',
    "singer": "周杰伦",
    "imageurl": "https://picsum.photos/250?image=9",
  },
  {
    "name": '稻香',
    "singer": "周杰伦",
    "imageurl": "https://picsum.photos/250?image=9",
  },
  {
    "name": '稻香',
    "singer": "周杰伦",
    "imageurl": "https://picsum.photos/250?image=9",
  },
  {
    "name": '稻香',
    "singer": "周杰伦",
    "imageurl": "https://picsum.photos/250?image=9",
  },
  {
    "name": '稻香',
    "singer": "周杰伦",
    "imageurl": "https://picsum.photos/250?image=9",
  },
  {
    "name": '稻香',
    "singer": "周杰伦",
    "imageurl": "https://picsum.photos/250?image=9",
  },
  {
    "name": '稻香',
    "singer": "周杰伦",
    "imageurl": "https://picsum.photos/250?image=9",
  },
  {
    "name": '稻香',
    "singer": "周杰伦",
    "imageurl": "https://picsum.photos/250?image=9",
  },
  {
    "name": '稻香',
    "singer": "周杰伦",
    "imageurl": "https://picsum.photos/250?image=9",
  },
  {
    "name": '稻香',
    "singer": "周杰伦",
    "imageurl": "https://picsum.photos/250?image=9",
  },
  {
    "name": '稻香',
    "singer": "周杰伦",
    "imageurl": "https://picsum.photos/250?image=9",
  },
  {
    "name": '稻香',
    "singer": "周杰伦",
    "imageurl": "https://picsum.photos/250?image=9",
  },
];

class MySongSheet extends StatelessWidget {
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
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          )),
                        ),
                        Expanded(
                            flex: 25,
                            child: Text(value['singer'],
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w300))),
                      ],
                    ),
                  )
                ],
              ),
            )),
          );
        }).toList(),
      ),
      // body: GestureDetector(
      //       child: Card(
      //         elevation: 3,
      //         // color: Colors.black38,
      //         child: Row(
      //           children: [
      //             SizedBox(
      //               width: MediaQuery.of(context).size.width * 0.33,
      //               child: Image.network(
      //               'https://picsum.photos/250?image=9',

      //                 fit: BoxFit.fill,
      //               ),
      //             ),
      //             Flexible(
      //               child: Column(
      //                 crossAxisAlignment: CrossAxisAlignment.start,
      //                 // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                 children: [
      //                   Text(
      //                     "歌单名",
      //                     style: new TextStyle(
      //                         fontSize: 15.0, fontWeight: FontWeight.bold),
      //                   ),
      //                   Text(
      //                     "location",
      //                     style: new TextStyle(
      //                       fontSize: 14.0,
      //                       fontWeight: FontWeight.normal,
      //                     ),
      //                   ),
      //                   // Row(
      //                   //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                   //   children: [
      //                   //     Text(
      //                   //       'AA',
      //                   //       style: TextStyle(
      //                   //         fontSize: 12.0,
      //                   //         fontWeight: FontWeight.normal,
      //                   //       ),
      //                   //     ),
      //                   //   ],
      //                   // ),
      //                 ],
      //               ),
      //             ),
      //           ],
      //         ),
      //       ),
      //       onTap: () {
      //         print("访问一个歌单");
      //       }
      // )
    );

    //   body: ListView(
    //     children: listData.map((value) {
    //       return Card(
    //         margin: EdgeInsets.all(10),
    //         child: Column(
    //           children: <Widget>[
    //             InkWell(
    //               onTap: () {
    //                 print("播放音乐");
    //               },
    //               child:

    //               ListTile(
    //                 title: Text(value["name"]),
    //                 subtitle:
    //                     Text(value["singer"], overflow: TextOverflow.ellipsis),
    //               ),
    //             )
    //           ],
    //         ),
    //       );
    //     }).toList(),
    //   ),
    // );
  }
}
