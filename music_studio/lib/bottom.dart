import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'mainPages/minePage/mineAll.dart';
import 'mainPages/communityPage/communityAll.dart';
import 'mainPages/homePage/homeAll.dart';

  class Bottom extends StatefulWidget {
   _BottomState createState() => _BottomState();
}

class _BottomState extends State<Bottom> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> _bottomNavPages = []; // 底部导航栏各个可切换页面组

  void initState() {
    super.initState();
    _bottomNavPages..add(homePage())..add(communityPage())..add(minePage());
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: _bottomNavPages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "首页"),
          
          BottomNavigationBarItem(icon: Icon(Icons.camera), label: "社区"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "我的")
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xFFAAD2AA),
        unselectedItemColor: Color(0xFFF4EFEF),
        onTap: _onItemTapped,
      ),
    );
  }
}