import 'package:flutter/material.dart';
import 'package:testzxf/common/ZXFState.dart';
import 'package:testzxf/common/Config.dart';
import 'package:testzxf/common/API.dart';
import 'package:testzxf/model/ListPageModel.dart';
import 'package:testzxf/model/ZXFMessageModel.dart';
import 'package:testzxf/controller/ZXFDetailPage.dart';
import 'dart:math';
import 'package:testzxf/view/ZXFCell.dart';


class ZXFListPage extends StatefulWidget {

  @override
  ZXFListPageState createState() => new ZXFListPageState();
}

class ZXFListPageState extends ZXFState<ZXFListPage> with WidgetsBindingObserver {//AutomaticKeepAliveClientMixin

  ListPageModel _viewModel = new ListPageModel();
  ScrollController scrollController = ScrollController();

//  @override
//  bool get wantKeepAlive => true;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    scrollController.addListener((){
      if(scrollController.position.pixels == scrollController.position.maxScrollExtent){
        print('滑动到了最底部${scrollController.position.pixels}');
        _loadMoreData();
      }
    });

//    _refreshData();
    _getData(0, 1);
  }

  @override
  // TODO: implement context


  Widget build(BuildContext context) {
    // TODO: implement build

    super.build(context);

    return Scaffold(
      appBar: AppBar(
        title: new Text("ZXF APP"),
        backgroundColor: Config.mainColor,
        actions: <Widget>[
          new IconButton(
              icon: new Icon(Icons.add, color: Colors.white),
              onPressed: (){
                _createData();
              })
        ],
      ),
      body: _viewModel.isLoading
        ?
    new Center(
      child: new CircularProgressIndicator(
//              strokeWidth: 3,
        backgroundColor: Config.mainColor_a100,
        valueColor: AlwaysStoppedAnimation(Config.mainColor),
      ),
    )
        :
    new RefreshIndicator(
        color: Config.mainColor,
        onRefresh: _refreshData,
        child: new ListView.separated(
            controller: scrollController,
            ///保持ListView任何情况都能滚动，解决在RefreshIndicator的兼容问题。
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.only(top: 2,bottom: 2),
            itemBuilder: (context, index){
              if(index >= _viewModel.messgeList.length) return null;
              ZXFItems obj = _viewModel.messgeList[index];
              return new GestureDetector(
                onTap: (){
                  _onDetailPage(obj);
                },
                child: new ZXFCell(obj),

              );

            },
            separatorBuilder: (BuildContext context, int index){
              return new Container(
                color: Color.fromARGB(255, 244, 242, 242),
                height: 10,
              );
            },
            itemCount: _viewModel.cellCount
        )
    )
    );
  }


  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
//    print('deactivate');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    scrollController.dispose();
    WidgetsBinding.instance.addObserver(this);
    print('dispose');
  }




  void _getData(int lastItemCreateTime, int direction) {

    if(_viewModel.isLoading) return;//|| _viewModel.noMoreData
    _viewModel.isLoading = true;

    API.getListData(_viewModel.uId , _viewModel.pageSize, lastItemCreateTime, direction).then((data) {
      ZXFMessageModel model = new ZXFMessageModel.fromJson(data);
//      _viewModel.model = model.data;
      print('data*******************>>:$data');
      List<ZXFItems> objectList = model.data.items;
      debugPrint('------------------${objectList.length}---');
//      if(model.data.count < _viewModel.pageSize) {
//        _viewModel.noMoreData = true;
//      }
      if(objectList.length > 0) {
        if(!_viewModel.isloadMore){
          _viewModel.messgeList = [];
        }
        var dataList = new List<ZXFItems>();
        if(_viewModel.cellCount > 0){
          dataList.addAll(_viewModel.messgeList);
        }
        dataList.addAll(objectList);
//        _viewModel.model = model.data;
        debugPrint("原共有${_viewModel.cellCount}， 新数据有${objectList.length}");
        setState(() {
          _viewModel.isLoading = false;
          _viewModel.messgeList = dataList;
//          debugPrint("1共有${_viewModel.messgeList.length}");
          print('刷新UI显示0');
        });
      }else{
//        setState(() {
          _viewModel.isLoading = false;
//          print('刷新UI显示1');
//        });
      }
    }).catchError((e){
      print('list page Error:--->$e');
      _viewModel.isLoading = false;
    });

  }


  void _createData(){
    String tmp =  Random().nextInt(100).toString();
    debugPrint("Random $tmp");
    API.postData(_viewModel.uId, "第$tmp条信息").then((data){
      debugPrint("create api $data");
//      _refreshData();
    });
  }

  Future<void> _refreshData() async {
    debugPrint("------》》》》》》》头刷新");
    _viewModel.isloadMore = false;
    _viewModel.isLoading = false;
    _getData(_viewModel.messgeList.first.creationTime, 1);
  }

  Future<void> _loadMoreData() async {
    debugPrint("加载更多");
    _viewModel.isloadMore = true;
    _getData(_viewModel.messgeList.last.creationTime,0);
  }


  Future<void> _onDetailPage(ZXFItems item) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => ZXFDetailPage(item))).then((val){

    });
    return null;
  }

}