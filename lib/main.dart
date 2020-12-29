import 'package:flutter/material.dart';
import 'package:flutter_app_1/widgets/JobWidget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _selectedIndex = 0;

  var tabs = [
    {
      "iconPath": 'images/ic_main_tab_company_nor.png',
      "label": "职位",
      "activeIconPath": "images/ic_main_tab_company_pre.png"
    },
    {
      "iconPath": 'images/ic_main_tab_contacts_nor.png',
      "label": "联系",
      "activeIconPath": "images/ic_main_tab_contacts_pre.png"
    },
    {
      "iconPath": 'images/ic_main_tab_find_nor.png',
      "label": "发现",
      "activeIconPath": "images/ic_main_tab_find_pre.png"
    },
    {
      "iconPath": 'images/ic_main_tab_my_nor.png',
      "label": "我的",
      "activeIconPath": "images/ic_main_tab_my_pre.png"
    },
  ];

  PageController _pageController;

  @override
  void initState() {
    _pageController =
        PageController(initialPage: 0, keepPage: true, viewportFraction: 2.0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildPageViewLazy(),
      bottomNavigationBar: _buildNavigationBar(),
    );
  }

  PageView _buildPageViewLazy() {
    return PageView.builder(
        controller: _pageController,
        itemCount: tabs.length,
        onPageChanged: (value) => {_selectTabIndex(value)},
        itemBuilder: (context, index) {
          Widget page;
          switch (index) {
            case 0:
              page = JobWidget();
              break;
            default:
              page = index == 3 ? _buildTestCenter1() : _buildTestCenter();
              break;
          }
          return page;
        });
  }

  PageView _buildPageViewJustLoading() {
    return PageView(
      onPageChanged: (value) => {_selectTabIndex(value)},
      children: [
        _buildTestCenter(),
        _buildTestCenter(),
        _buildTestCenter(),
        _buildTestCenter1()
      ],
      controller: _pageController,
    );
  }

  Center _buildTestCenter() {
    print("==>_buildTestCenter");

    return Center(
      child: Image.asset(
        "images/ic_main_tab_company_pre.png",
        width: 200,
        height: 200,
      ),
    );
  }

  Center _buildTestCenter1() {
    print("==>_buildTestCenter1");
    return Center(
      child: Image.asset(
        "images/ic_main_tab_find_pre.png",
        width: 200,
        height: 200,
      ),
    );
  }

  _buildNavigationBar() {
    return BottomNavigationBar(
      items: tabs
          .map((item) => _bottomNavBarItem(
              item["iconPath"], item["label"], item["activeIconPath"]))
          .toList(),
      type: BottomNavigationBarType.shifting,
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.cyan[800],
      onTap: _onItemTapped,
    );
  }

  BottomNavigationBarItem _bottomNavBarItem(
      String iconPath, String label, String activeIconPath) {
    var icon = Image.asset(iconPath, width: 35.0, height: 35.0);
    var activeIcon = Image.asset(activeIconPath, width: 35.0, height: 35.0);
    return BottomNavigationBarItem(
        icon: icon, label: label, activeIcon: activeIcon);
  }

  void _onItemTapped(int index) {
    _selectTabIndex(index);
    // _pageController?.animateToPage(index,duration: Duration(milliseconds: 400),curve: Curves.easeInOut);
    _pageController?.jumpToPage(index);
  }

  void _selectTabIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
