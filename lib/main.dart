import 'package:flutter/material.dart';
import 'package:testzxf/common/Config.dart';
import 'package:testzxf/controller/ZXFListPage.dart';

void main() => runApp(ZXFApp());

class ZXFApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: "ZXF APP",
      theme: new ThemeData(
        primaryColor: Config.mainColor
      ),
      home: new ZXFListPage(),
    );
  }

}