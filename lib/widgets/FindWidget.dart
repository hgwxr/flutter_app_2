import 'package:flutter/material.dart';
import 'package:flutter_app_1/models/Job.dart';

class FindWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FindWidgetState();
  }
}

class FindWidgetState extends State<FindWidget>
{
  List<Job> jobList = List<Job>();

  Future _future;

  @override
  void initState() {
    super.initState();
    _future = _mockNetworkData(); //创建这个实例
  }

  Future<List<dynamic>> _fetchJobList() async {

    return  Future.delayed(Duration(seconds: 2), () {
      print("-====>hello net");
      return [
        {"title": 'name===1'},
        {"title": 'name===2'},
        {"title": 'name===3'},
        {"title": 'name===4'},
        {"title": "name===5"},
      ];
    });
  }

  Future<String> _mockNetworkData() async {
    print("-====>hello net");
    return Future.delayed(Duration(seconds: 2), () {
      print("-====>hello net  over");
      return "我是从互联网上获取的数据";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("职位"),
          backgroundColor: Colors.cyan[800],
        ),
        body: Center(
          child: FutureBuilder(
            future: _future,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  // 请求失败，显示错误
                  return Text("Error: ${snapshot.error}");
                } else {
                  // 请求成功，显示数据
                  return Text("Contents: ${snapshot.data}");
                }
              } else {
                // 请求未结束，显示loading
                return CircularProgressIndicator();
              }
            },
          ),
        ));
  }

  @override
  bool get wantKeepAlive => true;
}
