import 'package:bookmap_ver2/model/bookDetailGetModel.dart';
import 'package:flutter/material.dart';

import 'package:bookmap_ver2/asset.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

import '../controller/bookDetailPopupController.dart';
import '../controller/mainController.dart';
import 'BookDetailGetMemoView_tile.dart';
import 'BookDetailView.dart';
import 'BookDetailViewTile_tile/BookDetailViewTile_reading.dart';
import 'BookDetailViewTile_tile/bookDetailViewTile_read.dart';
import 'BookDetailViewTile_tile/bookDetailViewTile_want.dart';
import 'mainView.dart';

class BookDetailGetViewTile extends StatelessWidget {
  final BookDetailGetModel bookDetailGetModel;



  BookDetailGetViewTile(this.bookDetailGetModel);

  final controller = Get.put(BookDetailPopupController());
  final mainController = Get.put(MainController());

  dynamic memoContent;
  dynamic memoTitle;
  dynamic memoPage;

  @override
  Widget build(BuildContext context) {


    /*
    final status = bookDetailGetModel.bookState;
    var statusIndex;

    if(status == '읽은'){
      statusIndex = 0;
    }else if(status == '읽는중인'){
      statusIndex = 1;
    }else{
      statusIndex = 2;
    }
     */

    //controller.tabs[statusIndex]=true;




    print(controller.status);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        title: Text(
          bookDetailGetModel.bookResponseDto.title,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontFamily: 'Pretendard', color: Colors.black, fontSize: 15),
        ),
        centerTitle: true,
        actions: <Widget>[
          PopupMenuButton(
            icon: Icon(Icons.add_box, color: appColor.shade800),
            itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
              PopupMenuItem(
                value: 1,
                child: Text('수정', style: TextStyle(fontFamily: 'Pretendard', color: Colors.black, fontSize: 15),),
              ),
              PopupMenuDivider(),
              PopupMenuItem(value: 2, child: Text('삭제', style: TextStyle(fontFamily: 'Pretendard', color: Colors.black, fontSize: 15),)),
              PopupMenuDivider(),
              PopupMenuItem(value: 3, child: Text('메모 추가', style: TextStyle(fontFamily: 'Pretendard', color: Colors.black, fontSize: 15),)),
            ],
            onSelected: (value) {
              if(value == 1 ){
                controller.initializeState(bookDetailGetModel.bookResponseDto.isbn);
                //수정
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
                                      child: const Text(
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
                                        mainAxisAlignment:
                                        MainAxisAlignment.end,
                                        children: [
                                          TextButton(
                                            onPressed: () {
                                              print(controller.tabs);
                                              print(controller.readBook.value?.bookState);
                                              print(bookDetailGetModel.bookResponseDto.isbn);
                                              controller.tabs[0] == true ? controller.fetchChangedData(controller.readBook, bookDetailGetModel.bookResponseDto.isbn) :
                                              controller.tabs[1] == true ? controller.fetchChangedData(controller.readingBook, bookDetailGetModel.bookResponseDto.isbn) :
                                              controller.fetchChangedData(null, bookDetailGetModel.bookResponseDto.isbn);
                                              // Navigator.pushNamedAndRemoveUntil(
                                              //     context, '/', (_) => false);
                                              // Navigator.push(
                                              //   context,
                                              //   MaterialPageRoute(
                                              //       builder: (context) =>
                                              //           MainView()),
                                              // );
                                              Get.to(() => MainView());

                                              mainController.fetchData();
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
                              Container(
                                  margin: const EdgeInsets.only(left: 10, right: 10),
                                  child: Obx(
                                        () => Padding(
                                          padding: const EdgeInsets.only(bottom: 10),
                                          child: Row(
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
              }else if (value == 2){
                deleteBook(context, bookDetailGetModel.bookResponseDto.isbn);
              }else{
                addMemo(context);
              }
            },
          ),

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
                        bookDetailGetModel.bookResponseDto.image??'src/sampleBook.jpg',
                        errorBuilder: (context, error, stackTrace) {
                          return Center(
                              child: Image.asset('src/sampleBook.jpg'));
                        },
                        fit: BoxFit.contain,
                        width: 200,
                        height: 200,

                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 13),
                      child: Text(
                        bookDetailGetModel.bookResponseDto.author,
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
              _buildBookWidgets(),
              // Container(
              //   //북맵 알려주는 컨테이너
              //   margin: EdgeInsets.only(
              //     left: 10,
              //     right: 10,
              //     top: 10,
              //   ),
              //   height: 30,
              //   child: Row(
              //     children: [
              //       const Expanded(
              //           flex: 10,
              //           child: Text(
              //             '이 책은 "여행가고 싶은 곳들"에 담긴 책이에요.',
              //             style: TextStyle(
              //                 fontSize: 14,
              //                 fontWeight: FontWeight.bold,
              //                 color: Colors.black),
              //           )),
              //       Text('더보기',
              //           style: TextStyle(
              //               fontSize: 14,
              //               color: Colors.black38,
              //               decoration: TextDecoration.underline)),
              //     ],
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.only(top: 8.0, bottom: 8),
              //   child: Container(
              //     color: const Color(0x7FD8D8D8),
              //     width: MediaQuery.of(context).size.width,
              //     child: SingleChildScrollView(
              //       scrollDirection: Axis.horizontal,
              //       child: Row(
              //         children: [
              //           Container(
              //             margin: EdgeInsets.only(left: 10, right: 10),
              //             child: Image.network(
              //                 'https://shopping-phinf.pstatic.net/main_3839015/38390159619.20230502161943.jpg?type=w300',
              //                 width: 90,
              //                 height: 120,
              //                 fit: BoxFit.fill),
              //           ),
              //           Container(
              //             margin: EdgeInsets.only(left: 10, right: 10),
              //             child: Image.network(
              //                 'https://shopping-phinf.pstatic.net/main_3249189/32491898723.20221019101316.jpg?type=w300',
              //                 width: 90,
              //                 height: 120,
              //                 fit: BoxFit.fill),
              //           ),
              //           Container(
              //             margin: EdgeInsets.only(left: 10, right: 10),
              //             child: Image.network(
              //                 'https://shopping-phinf.pstatic.net/main_3246667/32466672176.20221229074149.jpg?type=w300',
              //                 width: 90,
              //                 height: 120,
              //                 fit: BoxFit.fill),
              //           ),
              //           Container(
              //             margin: EdgeInsets.only(left: 10, right: 10),
              //             child: Image.network(
              //                 'https://shopping-phinf.pstatic.net/main_3818761/38187614626.20230404162233.jpg?type=w300',
              //                 width: 90,
              //                 height: 120,
              //                 fit: BoxFit.fill),
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
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
                          child: SingleChildScrollView(
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
                                      bookDetailGetModel
                                          .bookResponseDto.description != '' ? bookDetailGetModel.bookResponseDto.description: "제공되는 줄거리 정보가 없습니다.",
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
                                          bookDetailGetModel
                                              .bookResponseDto.publisher,
                                 style: TextStyle(
                                   fontFamily: 'Pretendard',
                                   color: Colors.black,
                                   fontSize: 15,
                                   fontStyle: FontStyle.normal,
                                   fontWeight: FontWeight.w300,
                                 ),
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
                                          DateFormat('yyyy년 MM월 dd일').format(
                                              bookDetailGetModel
                                                  .bookResponseDto.publishedDay),
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
                                          bookDetailGetModel.bookResponseDto.isbn,
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
                        ),
                        //여기까지 책정보 탭
                        //여기서부터 나의메모 탭
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount:
                              bookDetailGetModel.bookMemoResponseDtos.length,
                              // physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return BookDetailGetMemoViewTile(
                                    bookDetailGetModel.bookMemoResponseDtos[index]);
                              },
                            ),
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
  Widget _buildBookWidgets(){
    if(bookDetailGetModel.bookState == '읽는중인'){
      DateTime? startDate =
          bookDetailGetModel
              .startDate;
      DateTime currentDate = DateTime.now();
      Duration difference = currentDate.difference(startDate!);
      return Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                margin: const EdgeInsets.only(left: 10, right: 5),
                decoration: BoxDecoration(color: appColor.shade900,
                    borderRadius: const BorderRadius.all(Radius.circular(12))),
                child: Text('${bookDetailGetModel.bookState} 책',
                    style: const TextStyle(
                      fontFamily: 'Pretendard',
                      color: Colors.white,
                      fontSize: 15,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              const Expanded(
                child: Text('으로 저장된 도서입니다.', style: TextStyle(
                  fontFamily: 'Pretendard',
                  color: Colors.black,
                  fontSize: 15,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.bold,
                )),
              ),
              TextButton(
                style: ButtonStyle(overlayColor: MaterialStateProperty.all(appColor)),
                onPressed: (){}, child: const Text('수정', style: TextStyle(
                fontFamily: 'Pretendard',
                color: Colors.black,
                fontSize: 15,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w500,
              )),
              )
            ],),
          Padding(
            padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 12.0),
            child: Row(
                children: [
                  Text(
                      '${bookDetailGetModel.startDate?.year}-${bookDetailGetModel.startDate?.month}-${bookDetailGetModel.startDate?.day}로부터 ',
                      style: TextStyle(
                        fontFamily: 'Pretendard',
                        color: Colors.black,
                        fontSize: 15,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w500,
                      )
                    ),
                  Text(
                      '${difference.inDays}일',
                      style: TextStyle(
                        fontFamily: 'Pretendard',
                        color: Colors.black,
                        fontSize: 15,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.bold,
                      )
                  ),
                  Text(
                      '째 읽고 있어요!',
                      style: TextStyle(
                        fontFamily: 'Pretendard',
                        color: Colors.black,
                        fontSize: 15,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w500,
                      )
                  )

                ],
              ),
          ),
          Padding(
            padding: EdgeInsets.zero,
            child: LinearPercentIndicator(
              animation: false,
              lineHeight: 20.0,
              animationDuration: 2000,
              percent: double.parse('0.${bookDetailGetModel.readingPercentage}'),
              center: Text("${bookDetailGetModel.readingPercentage}%",
              style: TextStyle(
                fontFamily: 'Pretendard',
                color: Colors.black,
                fontSize: 15,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w500,
              )),
              barRadius: const Radius.circular(14),
              progressColor: appColor.shade700,
              backgroundColor: appColor.shade300,
            ),
          ),

        ],
      );
    }
      else if(bookDetailGetModel.bookState == '읽은'){
      return Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                margin: const EdgeInsets.only(left: 10, right: 5),
                decoration: BoxDecoration(color: appColor.shade900,
                    borderRadius: const BorderRadius.all(Radius.circular(12))),
                child: Text('${bookDetailGetModel.bookState} 책',
                    style: const TextStyle(
                      fontFamily: 'Pretendard',
                      color: Colors.white,
                      fontSize: 15,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
                    )),
              ),
               Expanded(
                 child: Text('으로 저장된 도서입니다.', style: TextStyle(
                  fontFamily: 'Pretendard',
                  color: Colors.black,
                  fontSize: 15,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.bold,
              )),
               ),
              TextButton(
                style: ButtonStyle(overlayColor: MaterialStateProperty.all(appColor)),
                onPressed: (){}, child: const Text('수정', style: TextStyle(
                fontFamily: 'Pretendard',
                color: Colors.black,
                fontSize: 15,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w500,
              )),
              )
            ],),
          Container(
              padding: const EdgeInsets.all(5),
              margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
              decoration: BoxDecoration(color: appColor.shade300,
                  border: Border.all(width: 0.2, color: Colors.black54),
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('독서 시작일',
                      style: TextStyle(
                        fontFamily: 'Pretendard',
                        color: Colors.black,
                        fontSize: 15,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.bold,
                      )),
                  Text('${bookDetailGetModel.startDate!.year}-${bookDetailGetModel.startDate!.month}-${bookDetailGetModel.startDate!.day}',
                    style: const TextStyle(
                      fontFamily: 'Pretendard',
                      color: Colors.black,
                      fontSize: 15,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],)
          ),
          Container(
              padding: const EdgeInsets.all(5),
              margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
              decoration: BoxDecoration(color: appColor.shade300,
                  border: Border.all(width: 0.2, color: Colors.black54),
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('독서 완료일',
                      style: TextStyle(
                        fontFamily: 'Pretendard',
                        color: Colors.black,
                        fontSize: 15,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.bold,
                      )),
                  Text('${bookDetailGetModel.endDate!.year}-${bookDetailGetModel.endDate!.month}-${bookDetailGetModel.endDate!.day}',
                    style: const TextStyle(
                      fontFamily: 'Pretendard',
                      color: Colors.black,
                      fontSize: 15,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],)
          ),
        ],
      );
    }
      else{
      return Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                margin: const EdgeInsets.only(left: 10, right: 5),
                decoration: BoxDecoration(color: appColor.shade900,
                    borderRadius: const BorderRadius.all(Radius.circular(12))),
                child: Text('${bookDetailGetModel.bookState} 책',
                    style: const TextStyle(
                      fontFamily: 'Pretendard',
                      color: Colors.white,
                      fontSize: 15,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              const Text('으로 저장된 도서입니다.', style: TextStyle(
                fontFamily: 'Pretendard',
                color: Colors.black,
                fontSize: 15,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.bold,
              ))
            ],),
        ],
      );
    }
  }

  deleteBook(BuildContext context, homeIsbn){
    // 특정 작업 수행
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('삭제'),
          content: const Text('삭제되었습니다.'),
          actions: [
            TextButton(
              onPressed: () {
                controller.deleteBook(homeIsbn);
                Get.to(() => MainView());

                mainController.fetchData();
              },
              child: Text('확인', style: TextStyle(color: appColor.shade700)),
            ),
          ],
        );
      },
    );
  }

  addMemo(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => Padding(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20, right: 150), // 여백 설정
                    child: Text(
                      '메모 추가하기',
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        print("메모 : ${controller.addMemo.value?.title}");
                        controller.fetchMemoData(
                            memoTitle ?? '',
                            memoContent ?? '',
                            memoPage ?? 0,
                            bookDetailGetModel.bookResponseDto.isbn);

                        Navigator.of(context).pop();
                        // Provider.of<BookProvider>(context, listen: false)
                        //     .fetchBook(); // BookProvider를 통해 상태 업데이트

                        // Get.off(
                        //         () => ChangeNotifierProvider(
                        //         create: (_) => BookProvider(),
                        //         child: BookDetailView()),
                        //     arguments: bookDetailGetModel.bookResponseDto.isbn);

                        Navigator.pushNamedAndRemoveUntil(
                            context, '/', (_) => false);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  MainView()),
                        );
                      },
                      child: Text("저장"))
                ],
              ),
              SizedBox(
                height: 8.0,
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 5, left: 5),
                      child: TextField(
                        maxLines: null, // 여러 줄 입력을 가능하게 합니다.
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(hintText: '메모 제목',
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.green,
                              width: 1.0,
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          memoTitle = value;
                          print("memo title is ${memoTitle}");
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 10),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 5, left: 5),
                      child: TextField(
                        maxLines: null, // 여러 줄 입력을 가능하게 합니다.
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(hintText: '메모',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(vertical: 40, horizontal: 15),
                        ),
                        onChanged: (value) {
                          memoContent = value;
                        },
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.only(left: 50, right: 50),
                            child: TextField(
                              keyboardType: TextInputType.number,
                              decoration:
                              InputDecoration(hintText: '쪽수 입력'),
                              onChanged: (value) {
                                memoPage = int.parse(value);
                              },
                            ),
                          ),
                        ),
                        Container(
                          child: Text('쪽'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
  // Widget _buildMemoListView() {
    // return Expanded(
    //   child: ListView.builder(
    //     shrinkWrap: true,
    //     itemCount: bookDetailGetModel.bookMemoResponseDtos.length,
    //     itemBuilder: (BuildContext context, index) {
    //       String dateTimeString = bookDetailGetModel.bookMemoResponseDtos[index]['saved'];
    //       DateTime dateTime = DateTime.parse(dateTimeString);
    //
    //       String memoId = bookDetailGetModel.bookMemoResponseDtos[index]['id'].toString();
    //       print("메모 아이디: $memoId");
    //
    //       int year = dateTime.year;
    //       int month = dateTime.month;
    //       int day = dateTime.day;
    //       int hour = dateTime.hour;
    //       int minute = dateTime.minute;
    //
    //       return Expanded(
    //         child: Container(
    //           margin: EdgeInsets.only(left: 10, right: 10, bottom: 5),
    //           width: MediaQuery.of(context).size.width,
    //           height: MediaQuery.of(context).size.width * 0.25,
    //           decoration: BoxDecoration(
    //             color: appColor.shade50,
    //             borderRadius: BorderRadius.all(Radius.circular(16)),
    //           ),
    //           child: Column(
    //             children: [
    //               Container(
    //                 margin: EdgeInsets.only(right: 10),
    //                 child: Row(
    //                   mainAxisAlignment: MainAxisAlignment.end,
    //                   children: [
    //                     TextButton(
    //                         onPressed: (){
    //                           // memoUpdate(context, homeData['bookMemoResponseDtos'][index]['content'],
    //                           //     homeData['bookMemoResponseDtos'][index]['page'], memoId);
    //                         },
    //                         child: Text(
    //                           '수정',
    //                           style: TextStyle(color: appColor.shade700),
    //                         )
    //                     ),
    //                     TextButton(
    //                         onPressed: (){
    //                           // deleteMemo(context, memoId, homeIsbn);
    //                         },
    //                         child: Text(
    //                           '삭제',
    //                           style: TextStyle(color: appColor.shade700),
    //                         )
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //               Container(
    //                 margin: EdgeInsets.only(bottom: 10),
    //                 child: Text(
    //                   '${bookDetailGetModel.bookMemoResponseDtos[index].}',
    //                   style: TextStyle(fontSize: 15),
    //                 ),
    //               ),
    //               Container(
    //                 margin: EdgeInsets.only(left: 10, right: 10),
    //                 child: Row(
    //                   mainAxisAlignment: MainAxisAlignment.end,
    //                   children: [
    //                     Expanded(
    //                       child: Text(
    //                         '${homeData['bookMemoResponseDtos'][index]['page']} 페이지',
    //                         style: TextStyle(
    //                             color: appcolor.shade800, fontSize: 12),
    //                       ),
    //                     ),
    //                     Text(
    //                       '저장일: $year-$month-$day, $hour:$minute',
    //                       style: TextStyle(color: appcolor.shade800, fontSize: 12),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //       );
    //     },
    //   ),
    // );
  // }

}


