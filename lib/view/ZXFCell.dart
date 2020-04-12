import 'package:flutter/material.dart';
import 'package:testzxf/model/ZXFMessageModel.dart';

class ZXFCell extends StatelessWidget {
  final ZXFItems cellModel;

  const ZXFCell(ZXFItems cellModel):this.cellModel = cellModel, assert(cellModel!=null);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      margin: const EdgeInsets.fromLTRB(10, 15, 10, 15),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          new Text(cellModel.id),
          new Text(cellModel.content),
          new Text(DateTime.fromMillisecondsSinceEpoch(cellModel.creationTime).toString())
        ],
      ),
    );
  }
}