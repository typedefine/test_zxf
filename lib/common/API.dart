import 'NetUtil.dart';

class API {

  static getListData(String id, int limit, int lastItem, int direction){//,
    if(lastItem == 0){
      return NetUtil.getJson("https://3evjrl4n5d.execute-api.us-west-1.amazonaws.com/dev/message",{"id":id, "limit":limit, "direction":direction});
    }
    return NetUtil.getJson("https://3evjrl4n5d.execute-api.us-west-1.amazonaws.com/dev/message",{"id":id, "limit":limit, "lastItem":lastItem, "direction":direction});
  }

  static postData(String id, String content) {//, int type, int state
    return NetUtil.postJson("https://3evjrl4n5d.execute-api.us-west-1.amazonaws.com/dev/message", {"id":id, "content":content});
  }


}