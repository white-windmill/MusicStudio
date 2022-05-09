import 'package:flutter/material.dart';
import 'package:music_studio/assets/myIcons.dart';

class songListDetail extends StatefulWidget {
  songListDetail({
    Key key,
  }) : super(key: key);
  int songListLikeMode=0;
  @override
  State<songListDetail> createState() => _songListDetailState();
}

class _songListDetailState extends State<songListDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: new Icon(Icons.chevron_left, color: Colors.black, size: 30),
            onPressed: () {
              Navigator.of(context)..pop();
            },
          ),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          title: Text(
            '歌单详情',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: new SingleChildScrollView(
            child: Container(
          color: Color(0xFFf4f4f4),
          child: Column(
            children: <Widget>[
              Container(
                  decoration: new BoxDecoration(
                    color: Colors.grey,
                  ),
                  height: 200,
                  width: double.infinity,
                  child: Image.asset(
                    "lib/assets/rotationChart/rotation1.jpg",
                    fit: BoxFit.cover,
                  )),
              Container(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: Color(0xFFF4EFEF),
                        ),
                        child: Row(children: [
                          Expanded(
                              child: Text(
                            '  编辑精选歌单，为你挑选',
                            style: TextStyle(fontSize: 15, color: Colors.grey),
                          )),
                          IconButton(
                              color: widget.songListLikeMode == 1
                                  ? Colors.red[700]
                                  : Colors.black,
                              icon: widget.songListLikeMode == 1
                                  ? Icon(MyIcons.followFont, size: 28)
                                  : Icon(MyIcons.followFont),
                              onPressed: () {
                                showListLikeDialog(context);
                                print("click");
                              })
                        ])),
                    SizedBox(
                      height: 5,
                    ),
                    // buildGrid(context)
                    songListItem(
                      title: "晴天",
                      source: "叶惠美",
                      serial: 111,
                      singer: "周杰伦",
                    ),
                    songListItem(
                      title: "以父之名",
                      source: "叶惠美",
                      serial: 111,
                      singer: "周杰伦",
                    ),
                    songListItem(
                      title: "你听得到",
                      source: "叶惠美",
                      serial: 111,
                      singer: "周杰伦",
                    ),
                    songListItem(
                      title: "东风破",
                      source: "叶惠美",
                      serial: 111,
                      singer: "周杰伦",
                    ),
                  ]))
            ],
          ),
        )));
  }

  showListLikeDialog(BuildContext context) {
    //设置按钮
    Widget cancelButton = FlatButton(
      child: Text("取消"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = FlatButton(
      child: Text("确定"),
      onPressed: () {
        if (widget.songListLikeMode == 0)
          //insertFollow(widget.uid, int.parse(UID))
          print("insert");
        else
          // deleteFollow(widget.uid, int.parse(UID));
          print('delect');
        setState(() {
          widget.songListLikeMode = 1 - widget.songListLikeMode;
        });
        Navigator.of(context).pop();
      },
    );

    //设置对话框
    AlertDialog alert = AlertDialog(
        title: Text("添加歌单提示框"),
        content: Text("确定添加到我的歌单吗？"),
        actions: [continueButton, cancelButton]);

    AlertDialog alert2 = AlertDialog(
        title: Text("移除歌单提示框"),
        content: Text("确定移除歌单吗？"),
        actions: [continueButton, cancelButton]);

    //显示对话框
    showDialog(
      context: context,
      builder: (BuildContext context) {
        if (widget.songListLikeMode == 0)
          return alert;
        else
          return alert2;
      },
    );
  }
}

class songListItem extends StatefulWidget {
  songListItem({
    Key key,
    this.title,
    this.source,
    this.serial,
    this.singer,
    this.followMode = 0,
  }) : super(key: key);
  final String title;
  final String source;
  final int serial;
  final String singer;
  int followMode;
  @override
  State<songListItem> createState() => _songListItemState();
}

class _songListItemState extends State<songListItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(color: Colors.white),
      height: 60,
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 10,
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(7, 7, 0, 0),
                child: Text(
                  widget.title + "",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(5, 2, 0, 2),
                child: Text(
                  widget.singer + "·" + widget.source + "",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          )),
          IconButton(
              color: widget.followMode == 1 ? Colors.red[700] : Colors.black,
              icon: widget.followMode == 1
                  ? Icon(MyIcons.followFont, size: 28)
                  : Icon(MyIcons.followFont),
              onPressed: () {
                showFollowDialog(context);
                print("click");
              })
        ],
      ),
    );
  }

  showFollowDialog(BuildContext context) {
    //设置按钮
    Widget cancelButton = FlatButton(
      child: Text("取消"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = FlatButton(
      child: Text("确定"),
      onPressed: () {
        if (widget.followMode == 0)
          //insertFollow(widget.uid, int.parse(UID))
          print("insert");
        else
          // deleteFollow(widget.uid, int.parse(UID));
          print('delect');
        setState(() {
          widget.followMode = 1 - widget.followMode;
        });
        Navigator.of(context).pop();
      },
    );

    //设置对话框
    AlertDialog alert = AlertDialog(
        title: Text("添加喜欢提示框"),
        content: Text("确定添加到歌单吗？"),
        actions: [continueButton, cancelButton]);

    AlertDialog alert2 = AlertDialog(
        title: Text("移除喜欢提示框"),
        content: Text("确定移除喜欢吗？"),
        actions: [continueButton, cancelButton]);

    //显示对话框
    showDialog(
      context: context,
      builder: (BuildContext context) {
        if (widget.followMode == 0)
          return alert;
        else
          return alert2;
      },
    );
  }
}
