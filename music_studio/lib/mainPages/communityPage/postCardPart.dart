import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:music_studio/assets/myIcons.dart';

class postCardPage extends StatefulWidget {
  postCardPage(
      {Key key,
      this.uid,
      this.pid,
      this.touXiang,
      this.userName,
      this.time,
      this.device,
      this.text,
      this.tag,
      this.imageList,
      this.likes,
      this.comments,
      this.forwards,
      this.likeMode = 0,
      this.followMode = 0})
      : super(key: key);
  int uid;
  int pid;
  String touXiang;
  String userName;
  String time;
  String device;
  String text;
  String tag;
  List<String> imageList;
  int likes;
  int comments;
  int forwards;
  int likeMode;
  int followMode;

  @override
  State<postCardPage> createState() => _postCardPageState();
}

class _postCardPageState extends State<postCardPage> {
  List<Widget> widgetList = [
    Image(
        image: AssetImage("lib/assets/rotationChart/rotation1.jpg"),
        height: 70,
        width: 70),
    Image(
        image: AssetImage("lib/assets/rotationChart/rotation2.jpg"),
        height: 70,
        width: 70),
    Image(
        image: AssetImage("lib/assets/rotationChart/rotation3.jpg"),
        height: 70,
        width: 70),
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Container(
            padding: EdgeInsets.all(15.0),
            alignment: Alignment.center,
            height: 400,
            decoration: new BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(25.0))),
            child: Scaffold(
                backgroundColor: Colors.white,
                appBar: new AppBar(
                    elevation: 6.0,
                    shape: ContinuousRectangleBorder(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0),
                      ),
                    ),
                    backgroundColor: Color.fromARGB(255, 240, 240, 240),
                    leading: InkWell(
                        child: Container(
                            margin: EdgeInsets.only(top: 5, bottom: 5, left: 5),
                            child: CircleAvatar(
                                radius: 30,
                                backgroundImage: AssetImage(
                                    "lib/assets/rotationChart/rotation1.jpg"),
                                child: Container(
                                    padding: EdgeInsets.only(left: 10),
                                    alignment: Alignment.center,
                                    // width: 150,
                                    height: 150))),
                        onTap: () {
                          print("click");
                        }),
                    title: IntrinsicWidth(
                        child: new Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                          Container(
                              alignment: Alignment.topLeft,
                              child: Text("name",
                                  style: TextStyle(
                                      color: Color(0xFF111111),
                                      decorationStyle:
                                          TextDecorationStyle.double,
                                      fontWeight: FontWeight.w700,
                                      fontStyle: FontStyle.normal,
                                      textBaseline: TextBaseline.alphabetic,
                                      fontSize: 13,
                                      letterSpacing: 2,
                                      wordSpacing: 10,
                                      height: 1.5),
                                  textAlign: TextAlign.start)),
                          Text("2022-4-10",
                              style: TextStyle(
                                  color: Colors.grey,
                                  decorationStyle: TextDecorationStyle.double,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FontStyle.normal,
                                  textBaseline: TextBaseline.alphabetic,
                                  fontSize: 11,
                                  letterSpacing: 2,
                                  wordSpacing: 10,
                                  height: 1.5),
                              textAlign: TextAlign.start)
                        ])),
                    actions: <Widget>[
                      // widget.uid == int.parse(UID)
                      //     ? Text("")
                      //     :
                      IconButton(
                          color: widget.followMode == 1
                              ? Colors.red[700]
                              : Colors.black,
                          icon: widget.followMode == 1
                              ? Icon(MyIcons.followFont, size: 28)
                              : Icon(MyIcons.followFont),
                          onPressed: () {
                            showFollowDialog(context);
                            print("click");
                          })
                    ]),
                body: Neumorphic(
                    style: NeumorphicStyle(
                        boxShape: NeumorphicBoxShape.roundRect(
                            BorderRadius.only(bottomLeft: Radius.circular(0))),
                        depth: 20,
                        color: Color.fromARGB(255, 240, 240, 240)),
                    child: Container(
                        padding: EdgeInsets.only(left: 10, top: 20, right: 10),
                        child: new ListView(children: [
                          Container(
                              alignment: Alignment.topLeft,
                              child: Text("  " + "听了周杰伦的歌，又是快乐的一天",
                                  style: TextStyle(
                                      color: Color(0xFF111111),
                                      decorationStyle:
                                          TextDecorationStyle.double,
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FontStyle.normal,
                                      textBaseline: TextBaseline.alphabetic,
                                      fontSize: 13,
                                      letterSpacing: 2,
                                      wordSpacing: 10,
                                      height: 1.2),
                                  softWrap: true,
                                  maxLines: 100,
                                  overflow: TextOverflow.ellipsis)),
                          SizedBox(height: 10),
                          Container(
                              child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 10, top: 15, right: 10),
                                  child: new Wrap(
                                      spacing: 10,
                                      runSpacing: 8,
                                      children: widgetList)))
                        ]))),
                bottomNavigationBar: Neumorphic(
                    style: NeumorphicStyle(
                        boxShape: NeumorphicBoxShape.roundRect(
                            BorderRadius.only(
                                bottomLeft: Radius.circular(12),
                                bottomRight: Radius.circular(12))),
                        depth: -10,
                        color: Color.fromARGB(255, 240, 240, 240)),
                    child: IntrinsicWidth(
                        child: Container(
                            height: 40,
                            child: new Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  new Row(children: <Widget>[
                                    new Row(children: [
                                      IconButton(
                                          color: widget.likeMode == 1
                                              ? Colors.red
                                              : Colors.black,
                                          icon: widget.likeMode == 1
                                              ? Icon(MyIcons.likeFont, size: 28)
                                              : Icon(MyIcons.likeFont),
                                          onPressed: () {
                                            //print(widget.likeMode.toString()+"11111111111");
                                            if (widget.likeMode == 0) {
                                              // updatePostLikeCommShare(
                                              //     widget.pid,
                                              //     widget.likes + 1,
                                              //     widget.comments,
                                              //     widget.forwards);
                                              setState(() {
                                                //widget.likes += 1;
                                                widget.likeMode = 1;
                                              });
                                            } else {
                                              // updatePostLikeCommShare(
                                              //     widget.pid,
                                              //     widget.likes - 1,
                                              //     widget.comments,
                                              //     widget.forwards);
                                              setState(() {
                                                // widget.likes -= 1;
                                                widget.likeMode = 0;
                                              });
                                            }
                                          }),
                                      Text(
                                          // '${widget.likes}',
                                          "3",
                                          style: TextStyle(
                                              color: Color(0xFF111111),
                                              decorationStyle:
                                                  TextDecorationStyle.double,
                                              fontWeight: FontWeight.w500,
                                              fontStyle: FontStyle.normal,
                                              textBaseline:
                                                  TextBaseline.alphabetic,
                                              fontSize: 15,
                                              letterSpacing: 2,
                                              wordSpacing: 10,
                                              height: 1.2))
                                    ]),
                                    SizedBox(width: 40),
                                    new Row(children: [
                                      IconButton(
                                          icon: Icon(Icons.chat),
                                          onPressed: () {}),
                                      Text('5',
                                          style: TextStyle(
                                              color: Color(0xFF111111),
                                              decorationStyle:
                                                  TextDecorationStyle.double,
                                              fontWeight: FontWeight.w500,
                                              fontStyle: FontStyle.normal,
                                              textBaseline:
                                                  TextBaseline.alphabetic,
                                              fontSize: 15,
                                              letterSpacing: 2,
                                              wordSpacing: 10,
                                              height: 1.2))
                                    ]),
                                    SizedBox(width: 40),
                                    new Row(children: [
                                      IconButton(
                                          onPressed: () {},
                                          icon: Icon(Icons.launch)),
                                      Text('6',
                                          style: TextStyle(
                                              color: Color(0xFF111111),
                                              decorationStyle:
                                                  TextDecorationStyle.double,
                                              fontWeight: FontWeight.w500,
                                              fontStyle: FontStyle.normal,
                                              textBaseline:
                                                  TextBaseline.alphabetic,
                                              fontSize: 15,
                                              letterSpacing: 2,
                                              wordSpacing: 10,
                                              height: 1.2))
                                    ])
                                  ])
                                ])))))));
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
        title: Text("关注提示框"),
        content: Text("确定关注吗？"),
        actions: [continueButton, cancelButton]);

    AlertDialog alert2 = AlertDialog(
        title: Text("取消关注提示框"),
        content: Text("确定取消关注吗？"),
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
