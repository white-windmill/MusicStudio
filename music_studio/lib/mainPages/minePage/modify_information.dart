import 'dart:io';

import 'package:flutter/material.dart';




class ModifyInformation extends StatelessWidget{
  File image = "" as File;
  String imageUrl = "";

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        automaticallyImplyLeading: false, //隐藏返回按钮
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text("修改个人信息"),
        centerTitle: true,
        elevation: 0, //将向导栏的阴影设为0，确保全透明
        backgroundColor: Colors.transparent, //将向导栏设为透明颜色
      ),
      // body: imagePicker(imageFile: image,imageUrl: imageUrl),
    );
  }
  
}

