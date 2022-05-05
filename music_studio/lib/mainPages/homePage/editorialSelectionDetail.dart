import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class songListDetail extends StatefulWidget {
  //songListDetail({Key? key}) : super(key: key);

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
                    ),songListItem(
                      title: "你听得到",
                      source: "叶惠美",
                      serial: 111,
                      singer: "周杰伦",
                    ),songListItem(
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
}

class songListItem extends StatelessWidget {
  const songListItem(
      {Key key, this.title, this.source, this.serial, this.singer})
      : super(key: key);
  final String title;
  final String source;
  final int serial;
  final String singer;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(color: Colors.white),
      height: 60,
      child: Row(
        children: [
          SizedBox(
            width: 10,
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(7, 7, 0, 0),
                child: Text(
                  title + "",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(5, 2, 0, 2),
                child: Text(
                  singer + "·" + source + "",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          )),
          Icon(Icons.more_vert),
        ],
      ),
    );
  }
}


