
import 'package:flutter/material.dart';

import 'mineAll.dart';


class MyCollect extends StatefulWidget {
  @override
  State<MyCollect> createState() => _MyCollectState();
}

class _MyCollectState extends State<MyCollect> {
    @override
  void initState() {
      super.initState();
      print(collect);
  }
    @override
  void dispose() {
    super.dispose();
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
          "我的收藏歌单",
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.black54,
          ),
        ),
      ),
      body: FutureBuilder(
        future: getData(myid),
        builder: _buildFuture,)
    );
  }
  Widget _buildFuture (BuildContext context, AsyncSnapshot snapshot) {
    switch(snapshot.connectionState) {
      case ConnectionState.none:
      print("没有开始请求");
      return Text("尚未请求");
      case ConnectionState.active:
      return Text("ConnectionState.active");
      case ConnectionState.waiting:
      return Center(
        child: CircularProgressIndicator(),
      );
      case ConnectionState.done:
      print("done");
      return _createListView(context, snapshot);
      default:
      return null;
    }

  }
  Widget _createListView(BuildContext context, AsyncSnapshot snapshot){
    return
    ListView(   
        children: collect.map((value) {
          return Container(
            height: 150,
            child: Card(
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
                      ],
                    ),
                  )
                ],
              ),
            )),
          );
        }).toList(),
      );
    
  }
}


