// import 'package:flutter/material.dart';

// class searchResultPage extends StatefulWidget {
//   final String searchWord;
//   searchResultPage({Key key,this.searchWord}) : super(key: key);

//   @override
//   State<searchResultPage> createState() => _searchResultPageState();
// }

// class _searchResultPageState extends State<searchResultPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Text(widget.searchWord),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:music_studio/GetMusic.dart';
import 'package:music_studio/widgets/song_item_tile.dart';

class SearchResultPage extends StatefulWidget {

  final String keyword;
SearchResultPage(this.keyword, {Key key}) : super(key: key);
  @override
  _SearchResultPageState createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  List _songs = List();

  _getSongs() async {
    await GetMusic.search(widget.keyword).then((result) {
      // 界面未加载，返回。
      if (!mounted) return;

      setState(() {
        _songs = result;
        print(_songs);
        print("asdasdsa!!!!!!");
      });
    }).catchError((e) {
      print('Failed: ${e.toString()}');
    });
  }

  @override
  void initState() {
    super.initState();
    _getSongs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        title: Text(widget.keyword, style: TextStyle(fontSize: 16.0)),
      ),
      body: _songs.length == 0
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _songs.length,
              itemExtent: 70.0, // 设定item的高度，这样可以减少高度计算。
              itemBuilder: (context, index) => SongItemTile(_songs, index),
            ),
    );
  }
}