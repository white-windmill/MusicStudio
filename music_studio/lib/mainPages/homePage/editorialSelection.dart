import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class editorialSelection extends StatefulWidget {
  // editorialSelection({Key? key}) : super(key: key);

  @override
  _editorialSelectionState createState() => _editorialSelectionState();
}

class _editorialSelectionState extends State<editorialSelection> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Row(children: [
              Expanded(
                  child: Text(
                '   下一秒，与你的宝藏相遇',
                style: TextStyle(
                  fontSize: 20,
                ),
              )),
            ])),
         Container(
           width: 500,
           height: 400,
           child: ListView(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            padding: const EdgeInsets.all(10.0),
            children: <Widget>[
             recommendItem(title: "学习歌单",picRoute: "lib/assets/rotationChart/rotation1.jpg",),
             recommendItem(title: "学习歌单",picRoute: "lib/assets/rotationChart/rotation1.jpg",),
             recommendItem(title: "学习歌单",picRoute: "lib/assets/rotationChart/rotation1.jpg",),
             recommendItem(title: "学习歌单",picRoute: "lib/assets/rotationChart/rotation1.jpg",),
             recommendItem(title: "学习歌单",picRoute: "lib/assets/rotationChart/rotation1.jpg",),
            ],
          ),
          
        ),
      ],
    ));
  }
}

class recommendItem extends StatelessWidget {
  const recommendItem({Key key, this.songListId, this.title, this.picRoute})
      : super(key: key);
  final String title;
  final String songListId;
  final String picRoute;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(0.0, 5, 10.0, 0),
          constraints: BoxConstraints(maxHeight: 150, maxWidth: 150),
          child: Image.asset(picRoute, fit: BoxFit.cover),
        ),
        SizedBox(
          width: 10,
          height: 10,
        ),
        Text(title)
      ]),
    );
  }
}
