import 'package:bookmap_ver2/model/bookDetailGetModel.dart';
import 'package:flutter/material.dart';

import 'package:bookmap_ver2/asset.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../controller/bookDetailPopupController.dart';
import 'BookDetailViewTile_tile/BookDetailViewTile_reading.dart';
import 'BookDetailViewTile_tile/bookDetailViewTile_read.dart';
import 'BookDetailViewTile_tile/bookDetailViewTile_want.dart';
import 'mainView.dart';

class BookDetailGetViewTile extends StatelessWidget {
  final BookDetailGetModel bookDetailGetModel;

  BookDetailGetViewTile(this.bookDetailGetModel);

  final controller = Get.put(BookDetailPopupController());






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
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          bookDetailGetModel.bookResponseDto.title,
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
                child: Text('수정'),
              ),
              PopupMenuDivider(),
              PopupMenuItem(value: 2, child: Text('삭제')),
              PopupMenuDivider(),
              PopupMenuItem(value: 3, child: Text('메모 추가')),
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
                                              print(controller.readBook.value?.bookState);
                                              print(bookDetailGetModel.bookResponseDto.isbn);
                                              controller.tabs[0] == true ? controller.fetchChangedData(controller.readBook, bookDetailGetModel.bookResponseDto.isbn) :
                                              controller.tabs[1] == true ? controller.fetchChangedData(controller.readingBook, bookDetailGetModel.bookResponseDto.isbn) :
                                              controller.fetchChangedData(null, bookDetailGetModel.bookResponseDto.isbn);
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
                                                    ?  appColor
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
                                                    ?  appColor
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
                                                ), disabledForegroundColor: appColor.withOpacity(0.38),
                                                backgroundColor: controller.tabs[2] == true
                                                    ?  appColor
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
              }else if (value == 2){
                deleteBook(context, bookDetailGetModel.bookResponseDto.isbn);
              }else{
                addMemo(context);
              }
            },
          ),

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
                      bookDetailGetModel.bookResponseDto.image,
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
                      bookDetailGetModel.bookResponseDto.author,
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
            _buildBookWidgets(),
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
                                  bookDetailGetModel
                                      .bookResponseDto.description,
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
                                      bookDetailGetModel
                                          .bookResponseDto.publisher,
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
                                      DateFormat('yyyy년 MM월 dd일').format(
                                          bookDetailGetModel
                                              .bookResponseDto.publishedDay),
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
                                      bookDetailGetModel.bookResponseDto.isbn,
                                    ))),
                            Container(
                                margin: EdgeInsets.only(left: 10, bottom: 5),
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(bookDetailGetModel.bookState,
                                        // bookStateValues.enumToString(bookDetailGetModel.bookState),
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.bold,
                                        )))),
                          ],
                        ),
                      ),
                      //여기까지 책정보 탭
                      //여기서부터 나의메모 탭
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Column(
                          children: [
                            // _buildMemoListView(homeData),
                          ],
                        ),
                      ),
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
  Widget _buildBookWidgets(){
    if(bookDetailGetModel.bookState == '읽는중인'){
      DateTime? startDate =
          bookDetailGetModel
              .startDate;
      DateTime currentDate = DateTime.now();
      Duration difference = currentDate.difference(startDate!);
      return Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 10, right: 10, top: 5),
            height: 30,
            child: Row(
              children: [
                Expanded(
                  flex: 10,
                  child: Text(
                    '시작일: ${bookDetailGetModel.startDate?.year}-${bookDetailGetModel.startDate?.month}-${bookDetailGetModel.startDate?.day}로부터 ${difference.inDays}일째 읽고 있어요!',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                Text(
                  '수정',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black38,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10, top: 10, right: 10),
            child: LinearPercentIndicator(
              animation: false,
              lineHeight: 20.0,
              animationDuration: 2000,
              percent: double.parse('0.${bookDetailGetModel.readingPercentage}'),
              center: Text("${bookDetailGetModel.readingPercentage}%"),
              barRadius: const Radius.circular(16),
              progressColor: appColor,
              backgroundColor: Color(0x7FD8D8D8),
            ),
          ),

        ],
      );
    }
      else if(bookDetailGetModel.bookState == '읽은'){
      return Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 10, right: 10, top: 5),
            height: 30,
            child: Row(
              children: [
                Expanded(
                  flex: 10,
                  child: Text(
                    '시작일: ${bookDetailGetModel.startDate?.year}-${bookDetailGetModel.startDate?.month}-${bookDetailGetModel.startDate?.day}부터 ${bookDetailGetModel.endDate?.year}-${bookDetailGetModel.endDate?.month}-${bookDetailGetModel.endDate?.day}까지 읽었어요!',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                Text(
                  '수정',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black38,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
          ),

        ],
      );
    }
      else{
      return Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 10, right: 10, top: 5),
            height: 30,
            child: Row(
              children: [
                Expanded(
                  flex: 10,
                  child: Text(
                    '읽고싶은 책으로 저장했어요!',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                Text(
                  '수정',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black38,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
          ),

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
          title: Text('삭제'),
          content: Text('삭제되었습니다.'),
          actions: [
            TextButton(
              onPressed: () {
                controller.deleteBook(homeIsbn);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => MainView(),
                  ),
                );
              },
              child: Text('확인', style: TextStyle(color: appColor.shade700)),
            ),
          ],
        );
      },
    );
  }

  addMemo(BuildContext context){
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Text('메모 추가하기',
                  style: TextStyle(
                    fontSize: 25
                  ),
                    ),
              ),
              SizedBox(
                height: 8.0,
              ),
        SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                maxLines: null, // 여러 줄 입력을 가능하게 합니다.
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(hintText: '메모'),
                onChanged: (value) {

                },
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: 50, right: 50),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(hintText: '쪽수 입력'),
                        onChanged: (value) {

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


