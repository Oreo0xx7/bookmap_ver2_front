import 'package:bookmap_ver2/controller/mainsearchController.dart';
import 'package:bookmap_ver2/view/BookDetailView.dart';
import 'package:bookmap_ver2/view/mainSearchBookMapView_tile.dart';
import 'package:bookmap_ver2/view/mainSearchBookView_tile.dart';
import 'package:bookmap_ver2/view/mainSearchUser_tile.dart';
import 'package:bookmap_ver2/view/startView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';

import '../asset.dart';

class MainSearchView extends StatelessWidget {
  MainSearchView({Key? key}) : super(key: key);

  final controller = Get.put(MainSearchController());
  PageController _pageController = PageController();

  Widget _searchTab() {
    return Center(
      child: Container(
        width: 320,
        height: 40,
        margin: EdgeInsets.only(bottom: 0),
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: appColor,
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              child: Container(
                width: 100,
                height: 40,
                margin: EdgeInsets.only(bottom: 0),
                padding: EdgeInsets.all(0),
                decoration: controller.tabs[0] == true
                    ? BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                        boxShadow: [
                          BoxShadow(
                              color: appColor,
                              spreadRadius: 2,
                              blurRadius: 3,
                              offset: Offset(0, 2)),
                        ],
                      )
                    : BoxDecoration(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: Text(
                        "도서",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: appColor.shade800,
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              onTap: () {
                controller.toggleTabs(0);
              },
            ),
            GestureDetector(
              child: Container(
                width: 100,
                height: 40,
                margin: EdgeInsets.only(bottom: 0),
                padding: EdgeInsets.all(0),
                decoration: controller.tabs[1] == true
                    ? BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                        boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 2,
                                blurRadius: 3,
                                offset: Offset(0, 2))
                          ])
                    : BoxDecoration(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: Text(
                        "북맵",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: appColor.shade800,
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              onTap: () {
                controller.toggleTabs(1);
              },
            ),
            GestureDetector(
              child: Container(
                width: 100,
                height: 40,
                margin: EdgeInsets.only(bottom: 0),
                padding: EdgeInsets.all(0),
                decoration: controller.tabs[2] == true
                    ? BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                  const BorderRadius.all(Radius.circular(5)),
                  boxShadow: [
                    BoxShadow(
                        color: appColor,
                        spreadRadius: 2,
                        blurRadius: 3,
                        offset: Offset(0, 2)),
                  ],
                )
                    : BoxDecoration(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: Text(
                        "사용자",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: appColor.shade800,
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              onTap: () {
                controller.toggleTabs(2);
              },
            ),
          ],
        ),
      ),
    );
  }

  Container BottomNavi() {
    return Container(
      decoration:
          BoxDecoration(border: Border(top: BorderSide(color: Colors.black12))),
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
          ),
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.white,
      appBar: AppBar(
        centerTitle: false,
        leadingWidth: 0,
        elevation: 0.0,
        // 그림자 없애기
        backgroundColor: CupertinoColors.white,
        title: Text("검색",
            //textAlign: TextAlign.left,
            style: TextStyle(
                color: appColor.shade800,
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
      //bottomNavigationBar: BottomNavi(),

      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.all(Radius.circular(16))),
                child: TextField(
                  autofocus: true,
                  onChanged: (text) {
                    controller.onSearchTextChanged(
                        text); // 검색어 변경 콜백, 'text'가 입력한 텍스트입니다.
                  },
                  onEditingComplete: () {
                    controller.fetchData();
                    FocusScope.of(context).unfocus();
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(left: 15, top: 16),
                    hintText: '책이름/저자/ISBN',
                    hintStyle: TextStyle(color: appColor.shade800),
                    // homeContent 화면으로의 back을 위한 아이콘
                    prefixIcon: Icon(
                      CupertinoIcons.home,
                      color: appColor.shade900,
                    ),
                    // 검색 아이콘
                    suffixIcon: Icon(Icons.search, color: appColor.shade900),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                      borderSide:
                          BorderSide(color: appColor.shade700, width: 1.2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                      borderSide:
                      BorderSide(color: appColor.shade700, width: 1.2),
                    ),
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.all(5)),
              Center(
                child: Obx(
                  () => Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _searchTab(),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Obx(() => controller.tabs[0] == true
                    ? ListView.builder(
                        itemCount: controller.bookList.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            child:
                                MainSearchViewTile(controller.bookList[index]),
                            onTap: () {
                              Get.to(
                                  () => ChangeNotifierProvider(
                                      create: (_) => BookProvider(),
                                      child: BookDetailView()),
                                  arguments: controller.bookList[index].isbn
                                      );
                            },
                          );
                        },
                      )
                    : controller.tabs[1] == true
                        ? ListView.builder(
                            itemCount: controller.bookMapList.length,
                            itemBuilder: (context, index) {
                              return MainSearchBookMapViewTile(
                                  controller.bookMapList[index]);
                            },
                          )
                        : ListView.builder(
                  itemCount: 8,
                  itemBuilder: (context, index) {
                    return MainSearchUserTile();
                  },
                )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
