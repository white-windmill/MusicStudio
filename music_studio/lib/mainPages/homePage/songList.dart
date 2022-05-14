import 'package:flutter/material.dart';
import 'package:music_studio/mainPages/homePage/songListPage.dart';


class songList extends StatefulWidget {
  //songList({Key? key}) : super(key: key);

  @override
  State<songList> createState() => _songListState();
}

class _songListState extends State<songList> {
  @override


  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          SizedBox(
            width: 10,
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0.0, 5, 10.0, 0),
            constraints: BoxConstraints(
              maxHeight: 150,
            ),
            child: Image.asset("lib/assets/rotationChart/rotation1.jpg",
                fit: BoxFit.cover),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => songListPage()));
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      child: Row(
                    children: [
                      Text(
                        '   热歌榜',
                        style: TextStyle(
                          fontSize: 24,
                        ),
                      ),
                      Text(
                        '·每周更新',
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  )),
                  Container(
                      //margin: EdgeInsets.fromLTRB(20.0, 0, 0.0, 5.0),
                      child: ListView(
                    shrinkWrap: true,
                    itemExtent: 35,
                    padding: const EdgeInsets.all(10.0),
                    children: <Widget>[
                      const Text('1.孤勇者-陈奕迅'),
                      const Text('2.letting Go-蔡健雅'),
                      const Text('3.哪里都是你-队长'),
                    ],
                  ))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
