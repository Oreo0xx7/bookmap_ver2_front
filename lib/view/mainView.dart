// Home + Search + bottom navigation bar

import 'package:bookmap_ver2/controller/mainController.dart';
import 'package:bookmap_ver2/view/mainSearchView.dart';
import 'package:bookmap_ver2/controller/loginController.dart';
import 'package:bookmap_ver2/view/startView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';
import '../asset.dart';
import '../controller/bookController.dart';
import '../controller/bookMapController.dart';
import '../controller/memoController.dart';
import 'BookDetailView.dart';
import 'bookMapView.dart';
import 'libraryView.dart';
import 'makeBookMapView.dart';
import 'myView.dart';

class MainView extends StatefulWidget {
  final LoginController loginController = Get.find();

  @override
  State<StatefulWidget> createState() => _MainView();
}

class _MainView extends State<MainView> {
  int _selectedIndex = 0;

  List<Widget> areaOptions = <Widget>[Home(), Library(), BookMap(), My()];

  void _onTabChange(int index) {
    setState(() {
      _selectedIndex = index; // 0, 1, 2, 3
    });
  }

  @override
  Widget build(BuildContext context) {
    //final sessionProvider = Provider.of<SessionProvider>(context);
    //String? sessionId = sessionProvider.sessionId;

    return Scaffold(
      backgroundColor: CupertinoColors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.0,
        // 그림자 없애기
        backgroundColor: CupertinoColors.white,
        title: Text(["홈", "서재", "북맵", "My"].elementAt(_selectedIndex),
            style: TextStyle(
                color: appColor.shade800,
                fontSize: 22,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
              onPressed: () {
                loginController.logout();
              },
              icon: Icon(
                Icons.output_sharp,
                color: appColor.shade800,
              ))
        ],
      ),
      body: SafeArea(child: areaOptions.elementAt(_selectedIndex)),
      floatingActionButton: FloatingActionButton(
        backgroundColor: appColor.shade200,
        child: Icon(CupertinoIcons.bookmark),
        splashColor: appColor,
        shape: CircleBorder(),
        // 어떤 모양할 지 고민해보기
        onPressed: () {
          Get.to(MakeBookMapView());
        },
      ),
      bottomNavigationBar: BottomNavi(),
    );
  }

  // 하단 네비게이션바
  Container BottomNavi() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.black12))),
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
              text: '홈',
              textStyle: TextStyle(fontSize: 16, fontFamily: 'Pretendard')),
          GButton(
              icon: CupertinoIcons.book,
              text: '서재',
              textStyle: TextStyle(fontSize: 16, fontFamily: 'Pretendard')),
          GButton(
              icon: CupertinoIcons.bookmark,
              text: '북맵',
              textStyle: TextStyle(fontSize: 16, fontFamily: 'Pretendard')),
          GButton(
              icon: CupertinoIcons.person,
              text: 'My',
              textStyle: TextStyle(fontSize: 16, fontFamily: 'Pretendard'))
        ],
        onTabChange: _onTabChange,
      ),
    );
  }
}

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeStateful();
}

class HomeStateful extends State<Home> with SingleTickerProviderStateMixin {
  final BookController bookController = Get.put(BookController());
  final BookMapController bookMapController = Get.put(BookMapController());
  final MemoController memoController = Get.put(MemoController());
  final mainController = Get.put(MainController());



  @override
  Widget build(BuildContext context) {
    mainController.fetchData();
    //Get.put(HomeController());

    print("mainView's seesion id : ${loginController.sessionId}");
    return NotificationListener(
      onNotification: (OverscrollIndicatorNotification overscroll) {
        overscroll.disallowIndicator();
        return true;
      },
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // a. 검색바 -> 클릭시 작동 OR 검색 페이지 이동
            Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.all(Radius.circular(16))),
                  child: GestureDetector(
                    onTap: () {
                      Get.to(() => MainSearchView());
                    },
                    child: TextField(
                      enabled: false,

                      //focusNode: _focusNode,
                      cursorColor: appColor.shade800,
                      keyboardType: TextInputType.text,
                      // onChanged: (text) {
                      //   setState(() {
                      //     searchQuery = text;
                      //   });
                      // },
                      onTap: () {},
                      decoration: InputDecoration(
                        disabledBorder: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(16)),
                          borderSide:
                              BorderSide(color: appColor.shade700, width: 1.2),
                        ),
                        contentPadding:
                            const EdgeInsets.only(left: 15, top: 16),
                        hintText: '책이름/저자/ISBN',
                        hintStyle: TextStyle(color: appColor.shade800),
                        // 검색 아이콘
                        suffixIcon:
                            Icon(Icons.search, color: appColor.shade900),
                      ),
                      textInputAction: TextInputAction.search,
                      onEditingComplete: () async {
                        FocusScope.of(context).unfocus();
                        // setState(() {
                        //   _isLoading = true;
                        // });
                        // page = 1;
                        // data!.clear();
                        // await getBookJSON();
                        // setState(() {
                        //   _isLoading = false;
                        // });
                      },
                    ),
                  ),
                )),
            const Padding(padding: EdgeInsets.all(10)),

            //b. 저장된 책
            Padding(
              padding: const EdgeInsets.only(left: 12.0, bottom: 15),
              child: Text(
                '저장된 도서',
                style: TextStyle(
                    fontFamily: 'Pretendard',
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: appColor.shade900),
              ),
            ),
            NotificationListener(
              onNotification: (OverscrollIndicatorNotification overscroll) {
                overscroll.disallowIndicator();
                return true;
              },
              child: Obx(() {
                //mainController.fetchData();
                print("메인데이터 : ${mainController.mainData}");
                if (mainController.mainData.value != null) {
                  return Container(
                    //color: appColor.shade300,
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount:
                          mainController.mainData.value?.bookImageDto.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: (){
                            Get.to(
                                    () => ChangeNotifierProvider(
                                    create: (_) => BookProvider(),
                                    child: BookDetailView()),
                                arguments: mainController.mainData.value?.bookImageDto[index].isbn);
                          },
                          child: Container(
                            padding: EdgeInsets.only(top: 12, bottom: 12),
                            //decoration: BoxDecoration(color: appColor.shade500, border: Border.all(), borderRadius: BorderRadius.all(Radius.circular(16))),
                            width: 150,
                            height: 150,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.network(
                                    mainController.mainData.value
                                            ?.bookImageDto[index].image ??
                                        '',
                                    fit: BoxFit.fitHeight,
                                    height: 120),
                                const Padding(
                                    padding: EdgeInsets.only(bottom: 10)),
                                Text(
                                  mainController.mainData.value
                                          ?.bookImageDto[index].title ??
                                      '',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Pretendard'),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  mainController.mainData.value
                                          ?.bookImageDto[index].author ??
                                      '',
                                  style: TextStyle(
                                      fontSize: 13, fontFamily: 'Pretendard'),
                                  overflow: TextOverflow.ellipsis,
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return CircularProgressIndicator(); // 로딩 상태 표시 위젯
                }
              }
                  //print(mainController.mainData.value?.bookImageDto[0].image);

                  ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 10),
              child: Divider(
                color: Colors.black38,
                thickness: 1,
              ),
            ),
            //c. 팔로우 중인 사용자의 북맵
            Padding(
              padding: const EdgeInsets.only(left: 12.0, bottom: 15),
              child: Text(
                '북맵',
                style: TextStyle(
                    fontFamily: 'Pretendard',
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: appColor.shade900),
              ),
            ),
            NotificationListener(
              onNotification: (OverscrollIndicatorNotification overscroll) {
                overscroll.disallowIndicator();
                return true;
              },
              child: Obx(() {
                return Container(
                  padding: EdgeInsets.only(bottom: 8),
                  //color: appColor.shade300,
                  //height: 360,
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: mainController.mainData.value.bookMapResponseDtos.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: (){
                          
                        },
                        child: Container(
                          padding: EdgeInsets.only(top: 10, left: 15),
                          width: double.maxFinite,
                          height: 115,
                          child: Row(
                            children: [
                              Image.network(mainController.mainData.value.bookMapResponseDtos[index].bookMapImage ?? "",
                                  fit: BoxFit.fitHeight, height: 115,
                                errorBuilder: (context, error, stackTrace) {
                                  return Center(
                                      child: Image.asset('src/sampleBook.jpg'));
                                },),
                              Padding(padding: EdgeInsets.only(left: 15)),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    mainController.mainData.value.bookMapResponseDtos[index].bookMapTitle,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Pretendard'),
                                  ),
                                  Text(
                                    mainController.mainData.value.bookMapResponseDtos[index].bookMapContent,
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Pretendard'),
                                  ),
                                  /*
                                  Text(
                                    mainController.mainData.value.bookMapResponseDtos[index].,
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Pretendard'),
                                  )

                                   */
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              }),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 10),
              child: Divider(
                color: Colors.black38,
                thickness: 1,
              ),
            ),
            //d. 인기책 - 아직 dart에서 임의로 저장된 도서가 나오도록 해놓은 상태입니다.
            Padding(
              padding: const EdgeInsets.only(left: 12.0, bottom: 15),
              child: Text(
                '인기 도서',
                style: TextStyle(
                    fontFamily: 'Pretendard',
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: appColor.shade900),
              ),
            ),
            NotificationListener(
              onNotification: (OverscrollIndicatorNotification overscroll) {
                overscroll.disallowIndicator();
                return true;
              },
              child: Obx(() {
                return Container(
                  //color: appColor.shade300,
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: mainController.mainData.value?.bookTopResponseDtos.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: (){
                          Get.to(
                                  () => ChangeNotifierProvider(
                                  create: (_) => BookProvider(),
                                  child: BookDetailView()),
                              arguments: mainController.mainData.value?.bookTopResponseDtos[index].isbn);
                        },
                        child: Container(
                          padding: EdgeInsets.only(top: 12, bottom: 12),
                          //decoration: BoxDecoration(color: appColor.shade500, border: Border.all(), borderRadius: BorderRadius.all(Radius.circular(16))),
                          width: 150,
                          height: 150,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.network(mainController.mainData.value?.bookTopResponseDtos[index].image??'',
                                  fit: BoxFit.fitHeight, height: 120),
                              const Padding(padding: EdgeInsets.only(bottom: 10)),
                              Text(mainController.mainData.value?.bookTopResponseDtos[index].title??''
                                  ,overflow: TextOverflow.ellipsis
                                ,style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Pretendard'),
                              ),
                              Text(
                                mainController.mainData.value?.bookTopResponseDtos[index].author??'',
                                  overflow: TextOverflow.ellipsis
                                ,style: TextStyle(
                                    fontSize: 13, fontFamily: 'Pretendard'),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
