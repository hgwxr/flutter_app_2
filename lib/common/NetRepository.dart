import 'dart:io';

import 'package:dio/dio.dart';

class NetRepository {
  var _url = "";
  Dio _dio;

  Dio get dio => _dio;

  static NetRepository _instance;

  factory NetRepository.getInstance() => _getInstance();

  static _getInstance() {
    if (_instance == null) {
      _instance = NetRepository._internal();
    }
    return _instance;
  }

  NetRepository._internal() {
    BaseOptions baseOptions = BaseOptions();
    baseOptions.baseUrl = _url;
    baseOptions.connectTimeout = 5000;
    baseOptions.receiveTimeout = 10 * 1000;
    _dio = Dio(baseOptions);
    var log = LogInterceptor(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: true);
    _dio.interceptors.add(log);
  }

  Future<Map<String, dynamic>> get(String path,
      [Map<String, dynamic> params]) async {
    try {
      print("==== start  request>");
      Response response = await _dio.get(path, queryParameters: params);
      print("====response body==" + response.data.toString());
      if (response.statusCode == HttpStatus.ok) {
        return response.data;
      } else {
        var result = Map<String, dynamic>();
        result["code"] = response.statusCode;
        result["message"] =
            response.statusMessage + "  " + response.data.toString();
        return result;
      }
    } catch (e) {
      var result = Map<String, dynamic>();
      result["code"] = -1;
      result["message"] = e.toString();
      throw Exception(result);
    }
  }

  // ignore: missing_return
  Future<Map<String, dynamic>> post(String path,
      [Map<String, dynamic> params]) async {
    try {
      Response<dynamic> response = await _dio.post(path, data: params);
      return _dealResponse(response);
    } catch (e) {
      _dealNetError(e);
    }
  }

  _dealNetError(e) {
    print(e);
    var result = Map<String, dynamic>();
    result["code"] = -1;
    result["message"] = e.toString();
    throw Exception(result);
  }

  Map<String, dynamic> _dealResponse(Response response) {
    if (response.statusCode == HttpStatus.ok) {
      return response.data;
    } else {
      var result = Map<String, dynamic>();
      result["code"] = response.statusCode;
      result["message"] =
          response.statusMessage + "  " + response.data.toString();
      return result;
    }
  }
}
