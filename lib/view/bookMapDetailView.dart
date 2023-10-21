import 'dart:convert';
import 'dart:math';

import 'package:bookmap_ver2/controller/bookMapController.dart';
import 'package:bookmap_ver2/controller/loginController.dart';
import 'package:bookmap_ver2/view/BookDetailView.dart';
import 'package:bookmap_ver2/view/bookMapEditView.dart';
import 'package:bookmap_ver2/view/bookMapView.dart';
import 'package:bookmap_ver2/view/mainView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../asset.dart';
import '../controller/bookMapDetailController.dart';
import '../controller/bookMapEditController.dart';
import '../controller/userDetailController.dart';
import 'ProfileDetailView.dart';


class BookMapDetailView extends StatelessWidget {
  BookMapDetailView({Key? key}) : super(key: key);

  // final controller = Get.find<BookMapController>();
  // final controller = Get.put(BookMapDetailController(), tag: Get.parameters['bookMapId']);
  final controller = Get.put(BookMapDetailController());
  final editController = Get.put(BookMapEditController());
  final bookMapController = Get.put(BookMapController());
  final userDetailController = Get.put(UserDetailController());
  final loginController = Get.find<LoginController>();
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
          Obx(() =>
            (controller.bookMap.value.userId == null) ? SizedBox()
                : (controller.bookMap.value.userId == loginController.userId) ? ButtonBar(
                children: [
                  TextButton(
                    child: Text("편집"),
                    onPressed: () {
                      editController.fetchData(bookMapId);
                      editController.refresh();
                      Get.to(() => BookMapEditView(),
                          arguments: bookMapId);
                    },
                  ),
                  TextButton(
                    child: Text("삭제"),
                    onPressed: () {
                      showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (context) => AlertDialog(
                          content: Text(
                              "${controller.bookMap.value.bookMapTitle ?? ""} 북맵을 삭제할까요?"),
                          actions: <Widget>[
                            TextButton(
                              child: Text("취소"),
                              onPressed: () => Navigator.pop(context),
                            ),
                            TextButton(
                              child: Text("삭제"),
                              onPressed: () async {
                                controller.deleteBookMap(bookMapId);
                                await bookMapController.fetchData();
                                bookMapController.refresh();
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ]
            ) : (controller.scrap) ? TextButton(
                child: Text("스크랩 삭제"),
              onPressed: () async {
                  await controller.deleteScrap(bookMapId);
                  await bookMapController.fetchData();
                  bookMapController.refresh();
                  Get.back();
                  Get.snackbar(
                      '스크랩 삭제','\'${controller.bookMap.value.bookMapTitle}\' 북맵을 내 스크랩에서 삭제했습니다.');
                   // Get.offUntil(MaterialPageRoute(builder: (context) => BookMap()), (route) => route.isFirst);
                //Get.off(BookMapDetailView());


              },) : TextButton(
              child: Text("스크랩"),
              onPressed: () async {
                await controller.scrapBookMap(bookMapId);
                await bookMapController.fetchData();
                Get.snackbar(
                    '저장 완료','\'${controller.bookMap.value.bookMapTitle}\' 북맵을 내 북맵에 스크랩했습니다.');
                Get.find<BookMapController>().refresh();
                Get.offUntil(MaterialPageRoute(builder: (context) => MainView()), (route) => route.isFirst);
              },
            )
          )
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
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      bookMapExplain(context, bookMap),
                      if (bookMap.bookMapIndex != null)
                        myIndex(bookMap.bookMapIndex),
                    ],
                  ),
                ),
              );
            }))
          ],
        ),
      ),
    );
  }

  Widget bookMapExplain(BuildContext context, bookMap) {
    return Container(
      width: double.infinity, // 화면 가로를 꽉 차게 설정
      color: appColor.shade500,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (bookMap.nickname != null)
              Padding(
                padding: const EdgeInsets.fromLTRB(6, 5, 5, 2),
                child: TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black87, minimumSize: Size.zero,
                    padding: EdgeInsets.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  onPressed: () {
                    userDetailController.fetchData(controller.bookMap.value.userId);
                    Get.to(() => ProfileDetailView(), arguments: controller.bookMap.value.userId);

                  },
                  child: Text(
                    '${bookMap.nickname} 님의 북맵',
                    style: TextStyle(
                      fontSize: 13,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ),
            if (bookMap.bookMapTitle != null)
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 3, 5, 3),
                child: Text(
                  '${bookMap.bookMapTitle}',
                  style: TextStyle(
                      fontSize: 25,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w700,
                      ),
                ),
              ),
            if (bookMap.hashTag != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
              child: Text(
                makeHash(bookMap.hashTag).join(' '),
                style: TextStyle(fontSize: 14,
                    fontFamily: 'Pretendard',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w300,
                    color: Colors.blue),
              ),
            ),
            if (bookMap.bookMapContent != null)
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                child: Text(
                  '${bookMap.bookMapContent}',
                  style: TextStyle(fontSize: 17,
                    height: 4,
                    color: Colors.black38, fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w500,),
                  textHeightBehavior: const TextHeightBehavior(
                    applyHeightToFirstAscent: false,
                    applyHeightToLastDescent: true,
                  ),
                ),
              ),

          ],
        ),
      ),
    );
  }
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
          padding: const EdgeInsets.all(5.0),
          height: 110,
          width: double.infinity,
          child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: books.length,
              itemBuilder: (context, index) {
                return Container(
                  width: 80,
                  height: 90,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: GestureDetector(
                      child: (books?[index].image != "")
                          ? Image.network(
                        books?[index].image,
                        fit: BoxFit.fitHeight, // 원하는 이미지 채우기 모드로 설정,
                        width: 250,
                        height: 300,)
                          : Image.asset('src/sampleBook.jpg',
                        fit: BoxFit.fitHeight, // 원하는 이미지 채우기 모드로 설정,
                        width: 250,
                        height: 300,),
                      onTap: () {
                        Get.to(
                                () => ChangeNotifierProvider(
                                create: (_) => BookProvider(),
                                child: BookDetailView()),
                            arguments: books[index].isbn);
                      },
                    ),
                  ),
                );
              }),
        ),
      ),

    ],
  );
}

Widget myMemo(String memo) {
  return Container(
    padding: const EdgeInsets.fromLTRB(15, 2, 15, 2),
    child: Text(
      '${memo}',
      style: TextStyle(fontSize: 16,
        fontFamily: 'Pretendard',
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w300,),
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
