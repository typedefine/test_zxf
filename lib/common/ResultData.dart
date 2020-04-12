
class StatusCode {
  //网络错误
  static const NETWORK_ERROR = -1;

  //网络错误
  static const NETWORK_DISCONNECTION = -100;
  static const NETWORK_DISCONNECTION_STRING_VALUE = '-100';
  static const NETWORK_DISCONNECTION_MESSAGE= '网络已断开，请检查网络';

  //网络超时
  static const REQUEST_TIMEOUT = -99;
  static const REQUEST_TIMEOUT_STRING_VALUE = '-99';
  static const REQUEST_TIMEOUT_MESSAGE = '网络已断开，请检查网络';

  //网络返回数据格式化一次
  static const RESPONSE_JSON_EXCEPTION = -3;
  static const RESPONSE_JSON_EXCEPTION_STRING_VALUE = -3;
  static const RESPONSE_JSON_EXCEPTION_MESSAGE = '请求响应异常';

  //请求成功
  static const RESPONSE_SUCCESS_CODE = 200;
  static const RESPONSE_SUCCESS_STRING_VALUE = '200';
}

class ResponseKey {
  static const String CODE_KEY = 'code';
  static const String MESSAGE_KEY = 'respMessage';
//  static const String JOKE_LIST_KEY = 'dyContexts';
}

class ResponseError {

  static const JSON_EXCEPTION = {
    ResponseKey.CODE_KEY:StatusCode.RESPONSE_JSON_EXCEPTION_STRING_VALUE,
      ResponseKey.MESSAGE_KEY:StatusCode.RESPONSE_JSON_EXCEPTION_STRING_VALUE
  };

  static const NETWORK_DISCONNECTED = {
    ResponseKey.CODE_KEY:StatusCode.NETWORK_DISCONNECTION_STRING_VALUE,
    ResponseKey.MESSAGE_KEY:StatusCode.NETWORK_DISCONNECTION_MESSAGE
  };

  static const REQUEST_TIMEOUT = {
    ResponseKey.CODE_KEY:StatusCode.REQUEST_TIMEOUT_STRING_VALUE,
    ResponseKey.MESSAGE_KEY:StatusCode.REQUEST_TIMEOUT_STRING_VALUE
  };

}


class ResultData {

  int code;
  String msg;
  var data;

  ResultData(this.code, this.msg, this.data);
}