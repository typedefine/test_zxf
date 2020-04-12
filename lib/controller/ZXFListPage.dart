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
    _viewModel.curPage = Config.FIRSTPAGE_INDEX;
    _viewModel.nextPage = Config.FIRSTPAGE_INDEX + 1;
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
      body: _viewModel.isEmpty
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

    if(_viewModel.isLoading || _viewModel.nextPage <= _viewModel.curPage || _viewModel.noMoreData) return;
    debugPrint("page ${_viewModel.curPage}");
    _viewModel.isLoading = true;

    API.getListData("1" , _viewModel.pageSize, lastItemCreateTime, direction).then((data) {
      ZXFMessageModel model = new ZXFMessageModel.fromJson(data);
      _viewModel.model = model.data;
      print('data***********************>>:$data');
      List objectList = model.data.items;
      debugPrint('------------------${objectList.length}---');
      if(model.data.count < _viewModel.pageSize) {
        _viewModel.noMoreData = true;
      }
      _viewModel.pageSize = objectList.length;
      if(objectList.length > 0) {
        var dataList = new List<ZXFItems>();
        if(_viewModel.curPage != Config.FIRSTPAGE_INDEX) {
          dataList.addAll(_viewModel.messgeList);
        }
        _viewModel.curPage = _viewModel.nextPage;

        setState(() {
          _viewModel.isLoading = false;
          _viewModel.messgeList = dataList;
          print('刷新UI显示');
        });
      }else{
        _viewModel.nextPage = _viewModel.curPage;
      }
    }).catchError((e){
      print('list page Error:--->$e');
      _viewModel.isLoading = false;
      _viewModel.nextPage = _viewModel.curPage;
    });

  }


  void _createData(){
    String tmp =  Random().nextInt(100).toString();
    debugPrint("Random $tmp");
    API.postData(tmp, "第$tmp条信息").then((data){
      debugPrint("create api $data");
    });
  }

  Future<void> _refreshData() async {
    debugPrint("------》》》》》》》头刷新");
    _viewModel.noMoreData = false;
    _viewModel.isLoading = false;
    _viewModel.curPage = Config.FIRSTPAGE_INDEX;
    _viewModel.nextPage = Config.FIRSTPAGE_INDEX + 1;
    _getData(_viewModel.messgeList.last.creationTime, 1);
  }

  Future<void> _loadMoreData() async {
    debugPrint("加载更多");
    _viewModel.nextPage++;
    _getData(_viewModel.messgeList.last.creationTime,0);
  }


  Future<void> _onDetailPage(ZXFItems item) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => ZXFDetailPage(item))).then((val){

    });
    return null;
  }

}