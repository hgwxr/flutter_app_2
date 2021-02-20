import 'package:flutter/material.dart';
import 'package:flutter_app_1/models/Job.dart';

class JobWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return JobWidgetState();
  }
}

class JobWidgetState extends State<JobWidget>
    with AutomaticKeepAliveClientMixin {

  Future _future;

  @override
  void initState() {
    super.initState();
    _future = _fetchJobList(); //创建这个实例
  }

  Future<List<dynamic>> _fetchJobList() async {
    return Future.delayed(Duration(seconds: 2), () {
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
        title: Text(
          "职位",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        backgroundColor: Colors.cyan[800],
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: _future,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              // 请求失败，显示错误
              return buildRequestError(snapshot);
            } else {
              // 请求成功，显示数据
              return buildRequestOk(snapshot);
            }
          } else {
            // 请求未结束，显示loading
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }

  Widget buildRequestError(AsyncSnapshot snapshot) {
    return Center(child: Text("Error: ${snapshot.error}"));
  }

  @override
  bool get wantKeepAlive => true;

  Widget buildRequestOk(AsyncSnapshot<dynamic> snapshot) {
    // return Center(child: Text("Contents: ${snapshot.data}"));
    // return Row(children: [
    //  Expanded(child: Text("contens:  =====${snapshot.data}"),flex: 1,)
    // ]);

    // return Container(color: Colors.red);
    List<dynamic> items=snapshot.data;
    return Center(
      child:ListView.builder(
        // Add a key to the ListView. This makes it possible to
        // find the list and scroll through it in the tests.
        key: Key('long_list'),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Center(child: Text(
              '${items[index]['title']}',
              // Add a key to the Text widget for each item. This makes
              // it possible to look for a particular item in the list
              // and verify that the text is correct
              key: Key('item_${index}_text'),
            ),),
          );
        },
      )
    );
  }

  Widget buildJobListItem() {
    return Padding(
      padding: EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text("job title"),
          Text("job title"),
        ],
      ),
    );
  }
}
