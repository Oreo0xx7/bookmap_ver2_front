import 'package:bookmap_ver2/api_key.dart';
import 'package:bookmap_ver2/asset.dart';
import 'package:bookmap_ver2/model/bookDetailModel.dart';
import 'package:bookmap_ver2/view/BookDetailViewTile_tile/BookDetailViewTile_reading.dart';
import 'package:bookmap_ver2/view/BookDetailViewTile_tile/bookDetailViewTile_want.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

import '../controller/bookDetailPopupController.dart';
import '../controller/mainController.dart';
import 'BookDetailViewTile_tile/bookDetailViewTile_read.dart';
import 'mainView.dart';

class BookDetailViewTile extends StatelessWidget {
  final BookDetailModel bookDetailModel;
  BookDetailViewTile(this.bookDetailModel);

  final controller = Get.put(BookDetailPopupController());
  final mainController = Get.put(MainController());

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 1,
        backgroundColor: Colors.white,
        title: Text(
          bookDetailModel.title,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontFamily: 'Pretendard', color: Colors.black, fontSize: 15),
        ),
        centerTitle: true,
        actions: <Widget>[
          SaveBtn(context)
        ],
      ),
      body: NotificationListener(
        onNotification: (OverscrollIndicatorNotification overscroll) {
          overscroll.disallowIndicator();
          return true;
        },
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Padding(padding: EdgeInsets.all(10)),
                    Center(
                      child: Image.network(
                        fit: BoxFit.contain,
                        bookDetailModel.image != "" ? bookDetailModel.image : imgUrl,
                        width: 200,
                        height: 200,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 13),
                      child: Text(
                        bookDetailModel.author,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(padding: EdgeInsets.all(10)),
              // 북맵 정보
              Container(
                //북맵 알려주는 컨테이너
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                  top: 5,
                ),
                height: 30,
                child: Row(
                  children: const [
                    Expanded(
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
                padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                child: Container(
                  color: const Color(0x7FD8D8D8),
                  width: MediaQuery.of(context).size.width,
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
                color: appColor.shade300,
                margin: EdgeInsets.only(top: 10),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.5,
                child: Column(
                  children: [
                    TabBar(
                      tabs: [Tab(text: '책 정보'), Tab(text: '나의 메모')],
                      indicatorColor: appColor.shade800,
                      labelColor: Colors.black,
                      labelStyle: TextStyle(fontFamily:'Pretendard', fontWeight: FontWeight.bold, fontSize: 16),
                      unselectedLabelColor: Colors.black54,
                    ),
                    Expanded(
                      child: TabBarView(
                          children: [
                        Container(
                          padding: EdgeInsets.all(16),
                          alignment: Alignment.topLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('줄거리',
                                  style: TextStyle(
                                    fontFamily: 'Pretendard',
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.bold,
                                  )),
                              Padding(padding: EdgeInsets.all(5)),
                              Text(
                                bookDetailModel.description != "" ? bookDetailModel.description : "제공되는 줄거리 정보가 없습니다.",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 4,
                                style: TextStyle(
                                  fontFamily: 'Pretendard',
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              Padding(padding: EdgeInsets.all(10)),
                              Text('출판사',
                                  style: TextStyle(
                                    fontFamily: 'Pretendard',
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.bold,
                                  )),
                              Padding(padding: EdgeInsets.all(5)),
                              Text(
                                  bookDetailModel.publisher,
                                  style: TextStyle(
                                    fontFamily: 'Pretendard',
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w300,
                                  )
                              ),
                              Padding(padding: EdgeInsets.all(10)),
                              Text('출판일',
                                  style: TextStyle(
                                    fontFamily: 'Pretendard',
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.bold,
                                  )),
                              Padding(padding: EdgeInsets.all(5)),
                              Text(
                                DateFormat('yyyy년 MM월 dd일')
                                    .format(bookDetailModel.publishedDay),
                                style: TextStyle(
                                  fontFamily: 'Pretendard',
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              Padding(padding: EdgeInsets.all(10)),
                              Text('ISBN',
                                  style: TextStyle(
                                    fontFamily: 'Pretendard',
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.bold,
                                  )),
                              Padding(padding: EdgeInsets.all(5)),
                              Text(
                                bookDetailModel.isbn,
                                style: TextStyle(
                                  fontFamily: 'Pretendard',
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ],
                          ),
                        ),
                        //여기까지 책정보 탭
                        //여기서부터 나의메모 탭
                        Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                            '저장된 메모가 없습니다.',
                            style: TextStyle(
                              fontFamily: 'Pretendard',
                              color: Colors.black,
                              fontSize: 16,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                            Text(
                              '도서 저장 후 메모를 추가해주세요.',
                              style: TextStyle(
                                fontFamily: 'Pretendard',
                                color: Colors.black,
                                fontSize: 15,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ]
                        )),
                      ]),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  PopupMenuButton<int> SaveBtn(BuildContext context) {
    return PopupMenuButton(
          icon: Icon(Icons.add_box, color: appColor.shade800),
          itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
            const PopupMenuItem(
              value: 1,
              child: Text('책 저장', style: TextStyle(color: Colors.black, fontFamily: 'Pretendard',
              fontSize: 16, fontWeight: FontWeight.w500),),
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
                                          fontSize: 18,
                                          fontFamily: 'Pretendard',
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        TextButton(
                                          onPressed: () async {
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
                                            // Navigator.pushNamedAndRemoveUntil(
                                            //     context, '/', (_) => false);
                                            // Navigator.push(
                                            //   context,
                                            //   MaterialPageRoute(
                                            //       builder: (context) =>
                                            //           MainView()),
                                            // );
                                            await mainController.fetchData();
                                            Get.offAll(() => MainView()); // GetX의 Get.offAll을 사용하여 화면 이동
                                            // Get.put(mainController); // mainController를 전역으로 공유
                                            // mainController.fetchData();
                                            // Get.off(() => MainView());

                                          },
                                          child: Text(
                                            '저장',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontFamily: 'Pretendard',
                                                fontWeight: FontWeight.bold,
                                                color: appColor.shade900),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Divider(color: Colors.black38),
                            Container(
                                margin: const EdgeInsets.only(left: 10, right: 10),
                                child: Obx(
                                  () => Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
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
                                                        Radius.circular(16)),
                                              ),
                                              backgroundColor:
                                                  controller.tabs[0] == true
                                                      ? appColor.shade900
                                                      : Colors.white,
                                            ),
                                            child: Text(
                                              '읽은 책',
                                              style: TextStyle(
                                                fontFamily: 'Pretendard',
                                                color: controller.tabs[0] == true ? Colors.white : Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(padding: EdgeInsets.all(5)),
                                        Expanded(
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
                                                        Radius.circular(16)),
                                              ),
                                              backgroundColor:
                                                  controller.tabs[1] == true
                                                      ? appColor.shade900
                                                      : Colors.white,
                                            ),
                                            child: Text(
                                              '읽고 있는 책',
                                              style: TextStyle(
                                                fontFamily: 'Pretendard',
                                                color: controller.tabs[1] == true ? Colors.white : Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(padding: EdgeInsets.all(5)),
                                        Expanded(
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
                                                        Radius.circular(16)),
                                              ),
                                              disabledForegroundColor:
                                                  appColor.withOpacity(0.38),
                                              backgroundColor:
                                                  controller.tabs[2] == true
                                                      ? appColor.shade900
                                                      : Colors.white,
                                            ),
                                            child: Text(
                                              '읽고 싶은 책',
                                              style: TextStyle(
                                                fontFamily: 'Pretendard',
                                                color: controller.tabs[2] == true ? Colors.white : Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )),
                            Divider(color: Colors.white),
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
        );
  }
}
