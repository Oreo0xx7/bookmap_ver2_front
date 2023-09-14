// Home + Search + bottom navigation bar

import 'package:bookmap_ver2/view/startView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:http/http.dart' as http;
import '../asset.dart';

import 'bookMapView.dart';
import 'libraryView.dart';
import 'myView.dart';

class MainView extends StatefulWidget{
  const MainView({super.key});

  @override
  State<StatefulWidget> createState() => _MainView();
}

class _MainView extends State<MainView>{
  int _selectedIndex = 0;

  List<Widget> areaOptions = <Widget>[
    Home(), Library(), BookMap(), My()
  ];

  void _onTabChange(int index) {
    setState(() {
      _selectedIndex = index; // 0, 1, 2, 3
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.white,
      appBar: AppBar(
        elevation: 0.0, // 그림자 없애기
        backgroundColor: CupertinoColors.white,
        title: Text(["홈", "서재", "북맵", "My"].elementAt(_selectedIndex),
          style: TextStyle(
              color: appColor.shade800,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.bold)),
        actions: [IconButton(
            onPressed: (){loginController.logout();},
            icon: Icon(Icons.output_sharp, color: appColor.shade800,))],
      ),
      body: SafeArea(
          child: areaOptions.elementAt(_selectedIndex)
      ),
      bottomNavigationBar: BottomNavi(),
    );
  }
  // 하단 네비게이션바
  Container BottomNavi() {
    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.black12))
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      child: GNav(
        gap: 8,
        backgroundColor: Colors.white,
        tabBackgroundColor: appColor,
        color: Colors.black54,
        activeColor: appColor.shade900,
        padding: const EdgeInsets.all(16),
        tabs: const [
          GButton(
            icon: CupertinoIcons.home,
            text: '홈',),
          GButton(
            icon: CupertinoIcons.book,
            text: '서재',
          ),
          GButton(
            icon: CupertinoIcons.bookmark,
            text: '북맵',
          ),
          GButton(
            icon: CupertinoIcons.person,
            text: 'My',
          )
        ],
        onTabChange: _onTabChange,
      ),
    );
  }
}

class Home extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => HomeStateful();
}

class HomeStateful extends State<Home> with SingleTickerProviderStateMixin{
  final FocusNode _focusNode = FocusNode();
  int homeStatus = 0;

  // 검색을 위한 컨트롤러
  late TabController _tabController;
  late TextEditingController? _editingController;
  ScrollController? _scrollController;
  static List? data;
  int page = 1;
  String? searchQuery;

  @override
  void initState() {
    // _tabController = TabController(
    //   length: 2,
    //   vsync: this,  //vsync에 this 형태로 전달해야 애니메이션이 정상 처리됨
    // );
    super.initState();

    if (data == null) {
      data = new List.empty(growable: true);
    }
    //print(reData); //아직 아무것도 찍히지않음
    _editingController = new TextEditingController();
    _scrollController = new ScrollController();
    _scrollController!.addListener(() {
      if (_scrollController!.offset >=
          _scrollController!.position.maxScrollExtent &&
          !_scrollController!.position.outOfRange) {
        page++;
        getBookJSON();
      }
    }
    );
  }

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    //Get.put(HomeController());
    return SingleChildScrollView(
      child: Column(
        children: [
          // a. 검색바 -> 클릭시 작동 OR 검색 페이지 이동
          Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.all(Radius.circular(16))
                ),
                child: TextField(

                  focusNode: _focusNode,
                  cursorColor: appColor.shade800,
                  keyboardType: TextInputType.text,
                  onChanged: (text) {
                    setState(() {
                      searchQuery = text;
                    });
                  },
                  onTap: (){
                  },
                  decoration: InputDecoration(
                    //검색바 클릭 전 border
                    enabledBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                      borderSide: BorderSide(
                          color: appColor.shade700,
                          width: 1.2
                      ),
                    ),

                    //검색바 클릭시 아래 border 출력
                    focusedBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                      borderSide: BorderSide(
                          color: appColor.shade700,
                          width: 1.2
                      ),
                    ),
                    contentPadding: const EdgeInsets.only(left: 15, top: 16),
                    hintText: '책이름/저자/ISBN',
                    hintStyle: TextStyle(color: appColor.shade800),
                    // homeContent 화면으로의 back을 위한 아이콘
                    prefixIcon: Icon(CupertinoIcons.home, color: appColor.shade900,),
                    // 검색 아이콘
                    suffixIcon: Icon(Icons.search, color: appColor.shade900),
                  ),
                  textInputAction: TextInputAction.search,
                  onEditingComplete: () async {
                    FocusScope.of(context).unfocus();
                    setState(() {
                      _isLoading = true;
                    });
                    page = 1;
                    data!.clear();
                    await getBookJSON();
                    setState(() {
                      _isLoading = false;
                    });
                  },
                ),
              )

          ),
          const Padding(padding: EdgeInsets.all(10)),
        ],

      ),
    );
  }
  //카카오 API
  Future<String> getBookJSON() async {
    var url = Uri.parse('https://dapi.kakao.com/v3/search/book?target=title&query=doit');
    var response = await http.get(url, headers: {"Authorization": "KakaoAK {kakao_rest_api_key}"});
    return response.body;
  }

  SingleChildScrollView SearchResult() {
    return SingleChildScrollView(
      child: Column(
        children: [
        ],
      ),
    );
  }

  SingleChildScrollView HomeContent(){
    return SingleChildScrollView(
      child: Column(
        children: [
          TextButton(
              onPressed: () async {
                getBookJSON();
                // var url = Uri.parse('http://www.google.com');
                // var response = await http.get(url);
                // setState(() {
                //   result = response.body;
                // });
              },
              child: Text("Test", style: TextStyle(color: Colors.black12),)),
        ],
      ),
    );

  }
}