import 'package:flutter/material.dart';

class searchResultPage extends StatefulWidget {
  final String searchWord;
  searchResultPage({Key key,this.searchWord}) : super(key: key);

  @override
  State<searchResultPage> createState() => _searchResultPageState();
}

class _searchResultPageState extends State<searchResultPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(widget.searchWord),
    );
  }
}