import 'dart:convert';

import 'package:bookmap_ver2/controller/bookMapController.dart';
import 'package:bookmap_ver2/view/bookMapEditView.dart';
import 'package:bookmap_ver2/view/bookMapView.dart';
import 'package:bookmap_ver2/view/mainView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../asset.dart';
import '../controller/bookMapDetailController.dart';


class BookMapDetailInSearchView extends StatelessWidget {
  BookMapDetailInSearchView({Key? key}) : super(key: key);
  final controller = Get.put(BookMapDetailController());
  var bookMapId = Get.arguments;

  @override
  Widget build(BuildContext context) {
    controller.fetchData(bookMapId);
    return Scaffold(
      appBar: AppBar(
      automaticallyImplyLeading: false,
      elevation: 0.0, // 그림자 없애기
      backgroundColor: CupertinoColors.white,
      title: Text("북맵",
          style: TextStyle(
              color: appColor.shade800,
              fontSize: 22,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.bold)),
        actions: [
          TextButton(
            child: Text("스크랩"),
            onPressed: () {
              controller.scrapBookMap(bookMapId);
              Get.snackbar(
                  '저장 완료','\'${controller.bookMap.value.bookMapTitle}\' 북맵을 내 북맵에 스크랩했습니다.'
              );
              Get.offUntil(MaterialPageRoute(builder: (context) => MainView()), (route) => route.isFirst);
              },
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Column(
          children: [
            Expanded(child: Obx(() {
              final bookMap = controller.bookMap.value;
              return Container(
                margin: EdgeInsets.all(1),
                child: Padding(
                  padding: EdgeInsets.all(6),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if(bookMap.bookMapTitle != null)
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(
                              '${bookMap.bookMapTitle}',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        if(bookMap.bookMapContent != null)
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(
                              '${bookMap.bookMapContent}',
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            '${makeHash(bookMap.hashTag).join(' ')}',
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        if(bookMap.bookMapIndex != null)
                          myIndex(bookMap.bookMapIndex),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                        )
                      ],
                    ),
                  ),
                ),
              );
            }))
          ],
        ),
      ),
    );
  }
}

List<String> makeHash(List<String>? tags) {
  List<String> newHash = [];
  tags?.forEach((tag) {
    if (tag.trim().isNotEmpty){
      newHash.add("#" + tag);
    }
  });
  return newHash;
}

InputDecoration myDecoration(String label) {
  return InputDecoration(
    border: OutlineInputBorder(),
    contentPadding: EdgeInsets.all(8.0),
    labelText: label,
    // suffixIcon: GestureDetector(
    //     child: const Icon(
    //       Icons.cancel,
    //       color: Colors.black38,
    //       size: 20,
    //     ),
    //     onTap: () => TextEditingController().clear()
    // )
  );
}

Widget myBook(List<dynamic> books) {
  return Row(
    children: [
      Expanded(
        child: Container(
          // padding: const EdgeInsets.all(2.0),
          height: 100,
          width: double.infinity,
          child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: books.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.network(
                      books[index].image,
                      // height: 130,
                  ),
                );
              }),
        ),
      )
    ],
  );
}

Widget myMemo(String memo) {
  return Container(
    padding: const EdgeInsets.all(2.0),
    child: Text(
      '${memo}',
      style: TextStyle(fontSize: 14),
    ),
  );
}

Widget myIndex(List<dynamic>? bookMapIndex) {
  return Container(
    padding: const EdgeInsets.all(2.0),
    margin: const EdgeInsets.all(2.0),
    child: Column(
      children: [
        Container(
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: bookMapIndex?.length,
              itemBuilder: (context, index) {
                if ("Book".compareTo(bookMapIndex?[index].type) == 0) {
                  if (bookMapIndex?[index].map != null) {
                    return myBook(bookMapIndex?[index].map);
                  }
                } else if ("Memo".compareTo(bookMapIndex?[index].type) == 0) {
                  if (bookMapIndex?[index].memo != null) {
                    return myMemo(bookMapIndex?[index].memo);
                  }
                } else {
                  return Container();
                }
              }),
        ),
      ],
    ),
  );
}