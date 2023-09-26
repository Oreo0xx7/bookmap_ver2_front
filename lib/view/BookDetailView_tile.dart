import 'package:bookmap_ver2/asset.dart';
import 'package:bookmap_ver2/model/bookDetailModel.dart';
import 'package:bookmap_ver2/view/BookDetailViewTile_tile/BookDetailViewTile_reading.dart';
import 'package:bookmap_ver2/view/BookDetailViewTile_tile/bookDetailViewTile_want.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

import '../controller/bookDetailPopupController.dart';
import 'BookDetailViewTile_tile/bookDetailViewTile_read.dart';
import 'mainView.dart';

class BookDetailViewTile extends StatelessWidget {
  final BookDetailModel bookDetailModel;

  BookDetailViewTile(this.bookDetailModel);

  final controller = Get.put(BookDetailPopupController());

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          bookDetailModel.title,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: Colors.black, fontSize: 15),
        ),
        centerTitle: true,
        actions: <Widget>[
          PopupMenuButton(
            icon: Icon(Icons.add_box, color: appColor.shade600),
            itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
              PopupMenuItem(
                value: 1,
                child: Text('책 저장'),
              ),
            ],
            onSelected: (value) {
              if (value == 1) {
                showModalBottomSheet<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return FractionallySizedBox(
                        widthFactor: 1.0,
                        heightFactor: 0.9,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(top: 10),
                                      child: Text(
                                        '어떤 책인가요?',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          TextButton(
                                            onPressed: () {
                                              print(controller.tabs);
                                              controller.tabs[0] == true
                                                  ? controller.fetchData(
                                                      controller.readBook,
                                                      bookDetailModel.isbn)
                                                  : controller.tabs[1] == true
                                                      ? controller.fetchData(
                                                          controller
                                                              .readingBook,
                                                          bookDetailModel.isbn)
                                                      : controller
                                                          .fetchWantData(
                                                              bookDetailModel
                                                                  .isbn);
                                              Navigator.pushNamedAndRemoveUntil(
                                                  context, '/', (_) => false);
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        MainView()),
                                              );

                                            },
                                            child: Text(
                                              '저장',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: appColor.shade700),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                  margin: EdgeInsets.only(
                                      top: 5, left: 5, right: 5),
                                  child: Obx(
                                    () => Row(
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Container(
                                            margin: EdgeInsets.only(right: 5),
                                            width: 80,
                                            height: 100,
                                            child: TextButton(
                                              onPressed: () {
                                                controller.toggleTabs(0);
                                                print(controller.tabs);
                                              },
                                              style: TextButton.styleFrom(
                                                shape:
                                                    const RoundedRectangleBorder(
                                                  side: BorderSide(
                                                      color: Colors.black26),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10)),
                                                ),
                                                backgroundColor:
                                                    controller.tabs[0] == true
                                                        ? appColor
                                                        : Colors.white,
                                              ),
                                              child: Container(
                                                child: Text(
                                                  '읽은 책',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Container(
                                            margin: EdgeInsets.only(right: 5),
                                            width: 80,
                                            height: 100,
                                            child: TextButton(
                                              onPressed: () {
                                                controller.toggleTabs(1);
                                                print(controller.tabs);
                                              },
                                              style: TextButton.styleFrom(
                                                shape:
                                                    const RoundedRectangleBorder(
                                                  side: BorderSide(
                                                      color: Colors.black26),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10)),
                                                ),
                                                backgroundColor:
                                                    controller.tabs[1] == true
                                                        ? appColor
                                                        : Colors.white,
                                              ),
                                              child: Container(
                                                child: Text(
                                                  '읽고 있는 책',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Container(
                                            margin: EdgeInsets.only(right: 5),
                                            width: 80,
                                            height: 100,
                                            child: TextButton(
                                              onPressed: () {
                                                controller.toggleTabs(2);
                                                print(controller.tabs);
                                              },
                                              style: TextButton.styleFrom(
                                                shape:
                                                    const RoundedRectangleBorder(
                                                  side: BorderSide(
                                                      color: Colors.black26),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10)),
                                                ),
                                                disabledForegroundColor:
                                                    appColor.withOpacity(0.38),
                                                backgroundColor:
                                                    controller.tabs[2] == true
                                                        ? appColor
                                                        : Colors.white,
                                              ),
                                              child: Container(
                                                child: Text(
                                                  '읽고 싶은 책',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )),
                              Obx(() => controller.tabs[0] == true
                                  ? Container(child: BookDetailViewTileRead())
                                  : controller.tabs[1] == true
                                      ? Container(
                                          child: BookDetailViewTileReading(),
                                        )
                                      : controller.tabs[2] == true
                                          ? Container(
                                              child: BookDetailViewTileWant(),
                                            )
                                          : Container(
                                              margin: EdgeInsets.only(top: 70),
                                              child: Text(
                                                '도서 상태를 눌러주세요.',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            )),
                            ],
                          ),
                        ),
                      );
                    });
              }
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              color: const Color(0x7FD8D8D8),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 1 / 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Image.network(
                      bookDetailModel.image,
                      fit: BoxFit.contain,
                      width: 200,
                      height: 200,
                      // loadingBuilder: (BuildContext context, Widget child,
                      //     ImageChunkEvent? loadingProgress) {
                      //   if (loadingProgress == null) {
                      //     return child;
                      //   }
                      //   return Center(
                      //     child: CircularProgressIndicator(
                      //       value: loadingProgress.expectedTotalBytes != null
                      //           ? loadingProgress.cumulativeBytesLoaded /
                      //           loadingProgress.expectedTotalBytes!
                      //           : null,
                      //     ),
                      //   );
                      // },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 13),
                    child: Text(
                      bookDetailModel.author,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              //북맵 알려주는 컨테이너
              padding: EdgeInsets.only(
                left: 10,
                right: 10,
                top: 5,
              ),
              height: 30,
              child: Row(
                children: [
                  const Expanded(
                      flex: 10,
                      child: Text(
                        '이 책은 "여행가고 싶은 곳들"에 담긴 책이에요.',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      )),
                  Text('더보기',
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.black38,
                          decoration: TextDecoration.underline)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Container(
                color: const Color(0x7FD8D8D8),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.2,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 10, right: 10),
                        child: Image.network(
                            'https://shopping-phinf.pstatic.net/main_3839015/38390159619.20230502161943.jpg?type=w300',
                            width: 90,
                            height: 120,
                            fit: BoxFit.fill),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10, right: 10),
                        child: Image.network(
                            'https://shopping-phinf.pstatic.net/main_3249189/32491898723.20221019101316.jpg?type=w300',
                            width: 90,
                            height: 120,
                            fit: BoxFit.fill),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10, right: 10),
                        child: Image.network(
                            'https://shopping-phinf.pstatic.net/main_3246667/32466672176.20221229074149.jpg?type=w300',
                            width: 90,
                            height: 120,
                            fit: BoxFit.fill),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10, right: 10),
                        child: Image.network(
                            'https://shopping-phinf.pstatic.net/main_3818761/38187614626.20230404162233.jpg?type=w300',
                            width: 90,
                            height: 120,
                            fit: BoxFit.fill),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.5,
              //color: Colors.orange,
              decoration: BoxDecoration(
                  border: Border(
                top: BorderSide(
                  color: appColor.shade700, //외곽선,
                  width: 1.0,
                ),
              )),
              child: Column(
                children: [
                  TabBar(
                    tabs: [Tab(text: '책 정보'), Tab(text: '나의 메모')],
                    indicator: BoxDecoration(
                      color: appColor,
                    ),
                    unselectedLabelColor: Colors.black,
                  ),
                  Expanded(
                    child: TabBarView(children: [
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Column(
                          children: [
                            Container(
                                margin: EdgeInsets.only(left: 10, bottom: 5),
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text('줄거리',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.bold,
                                        )))),
                            Container(
                              margin: EdgeInsets.only(
                                  left: 10, right: 10, bottom: 10),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  bookDetailModel.description,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 4,
                                ),
                              ),
                            ),
                            Container(
                                margin: EdgeInsets.only(left: 10, bottom: 5),
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text('출판사',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.bold,
                                        )))),
                            Container(
                                margin: EdgeInsets.only(left: 10, bottom: 10),
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      bookDetailModel.publisher,
                                    ))),
                            Container(
                                margin: EdgeInsets.only(left: 10, bottom: 5),
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text('출판일',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.bold,
                                        )))),
                            Container(
                                margin: EdgeInsets.only(left: 10, bottom: 10),
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      DateFormat('yyyy년 MM월 dd일')
                                          .format(bookDetailModel.publishedDay),
                                    ))),
                            Container(
                                margin: EdgeInsets.only(left: 10, bottom: 5),
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text('ISBN',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.bold,
                                        )))),
                            Container(
                                margin: EdgeInsets.only(left: 10, bottom: 10),
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      bookDetailModel.isbn,
                                    ))),
                          ],
                        ),
                      ),
                      //여기까지 책정보 탭
                      //여기서부터 나의메모 탭
                      Container(
                          child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          '도서 저장 후 메모를 추가해주세요.',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      )),
                    ]),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
