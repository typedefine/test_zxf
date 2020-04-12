//import 'package:flutter/material.dart';
//import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:testzxf/common//LocalStorage.dart';
import 'package:testzxf/common//Config.dart';
import 'dart:io';
import 'dart:convert' show json;

//import 'package:connectivity/connectivity.dart';
//import 'package:uuid/uuid.dart';
import 'ResultData.dart';

class NetUtil {


  static final host = 'https://3evjrl4n5d.execute-api.us-west-1.amazonaws.com/dev/message';
//  static final baseUrl = 'http://' + host + "/";

  ///  基础信息配置
  static final Dio _dio = new Dio(new Options(
      method: "get",
      baseUrl: host,
      connectTimeout: 8000,
      receiveTimeout: 8000,
      followRedirects: true));

  static String token;

  static Future<Map<String, dynamic>> getJson<T>(
      String uri, Map<String, dynamic> paras) =>
      _httpJson("get", uri, data: paras).then(logicalErrorTransform);


  /// requestBody (json格式参数) 方式的 post
  static Future<Map<String, dynamic>> postJson(
      String uri, Map<String, dynamic> body) =>
      _httpJson("post", uri, data: body).then(logicalErrorTransform);



  static Future<Response> _httpJson(//Map<String, dynamic><T>
      String method, String uri,
      {Map<String, dynamic> data, bool dataIsJson = true}) {


//    //没有网络
//    if(await (new Connectivity().checkConnectivity()) == ConnectivityResult.none){
//      return new ResultData(NetStatusCode.NETWORK_DISCONNECTED, NetStatusCode.NETWORK_DISCONNECTED_TITLE, null);
//    }

    var enToken = token == null ? "" : Uri.encodeFull(token);

    /// 如果为 get方法，则进行参数拼接
    if (method == "get") {
      dataIsJson = false;
      if (data == null) {
        data = new Map<String, dynamic>();
      }
//      data["token"] = enToken;
    }

    if (Config.DEBUG) {
      print('<net url>------$uri');
      print('<net params>------$data');
    }

    /// 根据当前 请求的类型来设置 如果是请求体形式则使用json格式
    /// 否则则是表单形式的（拼接在url上）
    Options op;
    if (dataIsJson) {
      op = new Options(contentType: ContentType.parse("application/json"));
    } else {
      op = new Options(
          contentType: ContentType.parse("application/x-www-form-urlencoded"));
    }

    op.method = method;

//    int timeInterval = new DateTime.now().millisecondsSinceEpoch;
//
//    var headers = {
//    };
//
//    op.headers = headers;

    /// 统一带上token
    return _dio.request(
        method == "get" ? uri : "$uri?token=$enToken",
        data: data,
        options: op);//<Map<String, dynamic>>

  }

  /// 对请求返回的数据进行统一的处理
  /// 如果成功则将我们需要的数据返回出去，否则进异常处理方法，返回异常信息
//  static Future<T> logicalErrorTransform<T>(Response resp) {//<Map<String, dynamic>>
  static Future<Map<String, dynamic>> logicalErrorTransform<T>(Response resp) {
    //<T>
    if (resp.data != null) {
      Map<String, dynamic> result;
      print("---resp----1");
      if (resp.data is String) {
        print("---String Value ----");
        result = json.decode(resp.data);
      } else {
        result = resp.data;
      }

      print("---resp---- : $result");
      debugPrint("Http code：${resp.statusCode}");

      if (resp.statusCode == StatusCode.RESPONSE_SUCCESS_CODE) {
        T realData = resp.data;
        return Future.value(result);
      } else {
        print("---resp----2");
        return Future.error(resp);
      }
    } else {
      print("---resp----3");
      return Future.error(ResponseError.JSON_EXCEPTION);
    }
  }

//    ///获取授权token
//    static getToken() async {
//      String token = await LocalStorage.get(Config.TOKEN_KEY);
//      return token;
//    }

}



