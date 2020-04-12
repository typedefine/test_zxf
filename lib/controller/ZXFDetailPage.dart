
import 'package:flutter/material.dart';
import 'package:testzxf/common/ZXFState.dart';
import 'package:testzxf/model/ZXFMessageModel.dart';

class ZXFDetailPage extends StatefulWidget {
  final ZXFItems pageModel;

  ZXFDetailPage(ZXFItems pageModel): this.pageModel = pageModel, assert(pageModel != null);

  @override
  ZXFDetailPageState createState() => new ZXFDetailPageState(pageModel);
}

class ZXFDetailPageState extends ZXFState {

  final ZXFItems pageModel;

  ZXFDetailPageState(this.pageModel);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: new Text('详情'),
      ),
      body: new Center(
        child: new Container(
          width: 300,
          height: 300,
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Text(this.pageModel.id),
              new Text(this.pageModel.content),
              new Text(DateTime.fromMillisecondsSinceEpoch(this.pageModel.creationTime).toString()),
            ],
          ),
        ),
      )
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}