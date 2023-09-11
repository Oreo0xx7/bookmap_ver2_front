import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'login_controller.dart';
import 'dart:convert';
import 'package:http/io_client.dart';
import 'asset.dart';
import 'package:http/http.dart' as http;

final String server = 'http://10.0.2.2:8080/';
final controller = Get.put(LoginController());
//Get.put: Controller의 instance를 외부에서 사용될 수 있도록 메모리에 저장하는 것

//Login token 전달
Future<String> postIdToken(String idToken) async{
  final httpClient = IOClient();
  final response = await httpClient.post(
    Uri.parse('$server'),
    headers: <String, String>{
      'idToken': idToken,
    },
    body: jsonEncode(<String, String>{
      'idToken': idToken,
    }),
  );
  print("check!!");
  httpClient.close();
  return response.body;
}

// 로그인 및 메인 화면
void main() => runApp(MyApp());
final GoogleSignIn googleSignIn = GoogleSignIn();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login',
      home: Login(),
    );
  }
}

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx((){
        if(controller.googleAccount.value == null) {
          // 로그아웃 상태
          return buildLoginButton();
        } else{
          // 로그인 상태
          return buildFutureBuilder();
        }
      })
    );
  }

  // 1. 메인 화면 (로그인 상태)
  FutureBuilder<String> buildFutureBuilder() {
    return FutureBuilder(
      future: postIdToken(controller.googleAuthentication.value?.accessToken.toString() ?? ''),
      builder: (BuildContext context, AsyncSnapshot snapshot){
      if (snapshot.hasData == false){
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Center(child: CircularProgressIndicator(color: Colors.green,)),
          ],
        );
      }
      else if (snapshot.hasError){
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Text("로그인이 비정상적으로 작동하였습니다.")
          ],
        );
      }
      else{
        return buildMainView();
      }
      },
    );
  }
}

// 2. 로그인 화면 (로그아웃 상태)
Column buildLoginButton() {
  return Column(
    children: [
      const Padding(padding: EdgeInsets.only(top: 150)),
      const Center(
          child: Image(image: AssetImage('src/logo.png'), width: 280)),
      const Padding(padding: EdgeInsets.all(80)),
      ElevatedButton(
        onPressed: () {
          controller.login();
        },
        style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsets>(
                const EdgeInsets.all(0)),
            backgroundColor:
            MaterialStateProperty.all<Color>(Colors.white)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Padding(padding: EdgeInsets.all(8)),
            Image.asset(
              'src/btn_google_light.png',

              height: 18,
              width: 18,
              fit: BoxFit.none, //로고 주변 그림자를 없애기 위함
            ),
            const Padding(padding: EdgeInsets.all(24)),
            const Text('Google 계정으로 로그인',
                style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 14,
                    color: Colors.black54)),
            const Padding(padding: EdgeInsets.all(8)),
          ],
        ),
      ),
    ],
  );
}

MainView buildMainView() {
  if(controller.googleFormerUser.value == true){
    print("기존 회원");
  }
  else{
    print("새로운 회원");
  }
  return MainView();
}

// bottom navigation bar
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
      _selectedIndex = index;
      // print(_selectedIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: areaOptions.elementAt(_selectedIndex)
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
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
                  contentPadding: const EdgeInsets.only(left: 15, top: 10),
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
          TextButton(
              onPressed: () {
                controller.logout();
              },
              child: Text("로그아웃")),
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

  SingleChildScrollView HomeContent() {
    return SingleChildScrollView(
      child: Column(
        children: [
          TextButton(
              onPressed: () {
                controller.logout();
              },
              child: Text("로그아웃")),
          TextButton(
              onPressed: () async {
                getBookJSON();
                // var url = Uri.parse('http://www.google.com');
                // var response = await http.get(url);
                // setState(() {
                //   result = response.body;
                // });
              },
              child: Text("Test")),
        ],
      ),
    );

  }
}

class Library extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column();
  }
}

class BookMap extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Column();
  }
}

class My extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Column();
  }

}