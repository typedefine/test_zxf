import 'package:testzxf/model/ZXFMessageModel.dart';


class ListPageModel {

  bool noMoreData = false;
  bool isLoading = false;
  int pageSize = 10;
  int curPage = 0;
  int nextPage = 0;
  List<ZXFItems> _messgeList;

  ZXFData model;

  bool get isEmpty => cellCount == 0;
  int get cellCount => model == null ? 0 : model.count;
  List<ZXFItems> get messgeList => model == null ? 0 : model.items;
  set messgeList(List<ZXFItems> ml) => _messgeList = ml;

}


