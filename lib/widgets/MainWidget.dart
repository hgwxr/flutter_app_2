import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_1/common/NetRepository.dart';
import 'package:flutter_app_1/common/SPRepository.dart';
import 'package:flutter_app_1/common/ToastCompat.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MainWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MainWidgetState();
  }
}

class MainWidgetState extends State<MainWidget> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: MainSkeleton(),
      ),
    );
  }
}

class MainSkeleton extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MainSkeletonState();
  }
}

class MainSkeletonState extends State<MainSkeleton> {
  var _ipAddress = "UnKnow";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("current ip is $_ipAddress"),
            new RaisedButton(
              onPressed: _getIPAddress,
              child: new Text('Get IP address'),
            ),
            new RaisedButton(
              onPressed: _getIPAddressDio,
              child: new Text('Get IP address  dio'),
            ),
            new RaisedButton(
              onPressed: _getIPAddressDioUtil,
              child: new Text('Get IP address  dio Utils'),
            ),
            new RaisedButton(
              onPressed: _postIPAddressDioUtil,
              child: new Text('post IP address  dio Utils'),
            )
          ],
        ),
      ),
    );
  }

  void getHttp() async {
    try {
      Response response = await Dio().get("http://www.google.com");
      print(response);
    } catch (e) {
      print(e);
    }
  }

  _getIPAddressDioUtil() async {
    var url = 'https://httpbin.org/ip';
    String result = "";
    try {
      var r=await NetRepository.getInstance().get(url);
      print("===over=="+r.toString());
      result=r['origin'];
    } catch (e) {
      print(e);
    }
    if (!mounted) return;
    setState(() {
      _ipAddress = result;
    });
  }
  _postIPAddressDioUtil() async {
    var url = 'https://httpbin.org/ip';
    String result = "";
    try {
      var params=Map<String,dynamic>();
      params["parasm"]="sdssdd";
      var r=await NetRepository.getInstance().post(url,params);
      ToastCompat.showToast(r.toString(),ToastGravity.BOTTOM);
      print("===over=="+r.toString());
      result=r['origin'];
    } catch (e) {
      ToastCompat.showToast(e.toString(),ToastGravity.BOTTOM);
      print(e);
    }
    if (!mounted) return;
    setState(() {
      _ipAddress = result;
    });
  }
  _getIPAddressDio() async {
    var url = 'https://httpbin.org/ip';
    String result = "";
    try {
      Response response = await Dio().getUri(Uri.parse(url));
      if (response.statusCode == HttpStatus.ok) {
        var json = response.data;
        result = json['origin'];
      } else {
        result =
            'Error getting IP address:\nHttp status ${response.statusCode}';
      }
    } catch (e) {
      print(e);
    }
    if (!mounted) return;
    setState(() {
      _ipAddress = result;
    });
  }

  _getIPAddress() async {
    var url = 'https://httpbin.org/ip';
    var httpClient = new HttpClient();

    String result;
    try {
      var request = await httpClient.getUrl(Uri.parse(url));
      var response = await request.close();
      print("=======>" + response.toString());
      if (response.statusCode == HttpStatus.ok) {
        var json = await response.transform(utf8.decoder).join();
        var data = jsonDecode(json);
        result = data['origin'];
      } else {
        result =
            'Error getting IP address:\nHttp status ${response.statusCode}';
      }
    } catch (exception) {
      result = 'Failed getting IP address';
    }
    if (!mounted) return;
    setState(() {
      _ipAddress = result;
    });
  }
}
