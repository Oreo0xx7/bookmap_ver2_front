import 'package:bookmap_ver2/controller/mainsearchController.dart';
import 'package:bookmap_ver2/view/mainSearchBookView_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bookmap_ver2/model/bookMapEditModel.dart';

import '../asset.dart';

class BookMapEditSearchView extends StatelessWidget {
  BookMapEditSearchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainSearchTabState();
  }
}

class MainSearchTabState extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MainSearchTabView();
}

class MainSearchTabView extends State<MainSearchTabState>
    with SingleTickerProviderStateMixin {
  final controller = Get.put(MainSearchController());

  @override
  void initState() {
    super.initState();

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
                // loginController.logout();
              },
              icon: Icon(
                Icons.output_sharp,
                color: appColor.shade800,
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            MainSearchField(context),
            Padding(padding: EdgeInsets.all(5)),

            Expanded(child: GetX<MainSearchController>(builder: (controller) {
              return SizedBox(
                width: double.maxFinite,
                height: (MediaQuery.of(context).size.height * 0.6),
                child: NotificationListener(
                  onNotification: (OverscrollIndicatorNotification overscroll) {
                    overscroll.disallowIndicator();
                    return true;
                  },
                  child: ListView.builder(
                    itemCount: controller.bookList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        child: MainSearchViewTile(controller.bookList[index]),
                        onTap: () {
                          Get.back(
                            result: MapElement(
                                isbn: controller.bookList[index].isbn,
                                image: controller.bookList[index].thumbnail),);
                        },
                      );
                    },
                  ),
                ),
              );
            }))
          ],
        ),
      ),
    );
  }

  Container MainSearchField(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.all(Radius.circular(16))),
      child: TextField(
        autofocus: true,
        onChanged: (text) {
          controller
              .onSearchTextChanged(text); // 검색어 변경 콜백, 'text'가 입력한 텍스트입니다.
        },
        onEditingComplete: () {
          controller.fetchAllData();
          FocusScope.of(context).unfocus();
        },
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 15, top: 16),
          hintText: '책이름/저자/ISBN',
          hintStyle: TextStyle(color: appColor.shade800),
          // 검색 아이콘
          suffixIcon: Icon(Icons.search, color: appColor.shade900),
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide(color: appColor.shade700, width: 1.2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide(color: appColor.shade700, width: 1.2),
          ),
        ),
      ),
    );
  }
}
