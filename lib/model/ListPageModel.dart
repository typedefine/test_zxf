import 'package:testzxf/model/ZXFMessageModel.dart';


class ListPageModel {

  String uId = "1";
  bool isloadMore = false;
  bool isLoading = false;
  int pageSize = 8;

  List<ZXFItems> messgeList;

//  ZXFData model;

  bool get isEmpty => cellCount == 0;
  int get cellCount => messgeList == null ? 0 : messgeList.length;
////  List<ZXFItems> get messgeList => model == null ? null : model.items;
//  set messgeList(List<ZXFItems> ml){
//    _messgeList = ml;
////    model.count = ml.length;
//  }

}


