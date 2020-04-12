import 'package:flutter/material.dart';

abstract class ZXFState<T extends StatefulWidget> extends State<T> with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true;

}