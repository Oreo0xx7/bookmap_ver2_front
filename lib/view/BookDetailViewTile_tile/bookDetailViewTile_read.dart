import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';

import '../../asset.dart';
import '../../controller/bookDetailPopupController.dart';

class BookDetailViewTileRead extends StatelessWidget {
  // late final id;
  // late final bookState;
  // late final startDate;
  // late final endDate;
  // late final totalPage;

  final controller = Get.put(BookDetailPopupController());

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 10, bottom: 5),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '독서 기간',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
            height: 35,
            decoration: BoxDecoration(
              border: Border.all(
                width: 1.0,
                color: appColor.shade900,
              ),
            ),
            child: GestureDetector(
              onTap: () {
                openModalBottomSheet(1);
              },
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Text(
                        '시작일',
                        style: TextStyle(
                          fontFamily: 'Pretendard',
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  // ElevatedButton(
                  //   onPressed: () {
                  //     openModalBottomSheet(); // 모달 창 열기
                  //   },
                  //   child: Text('선택'), // 버튼 텍스트는 원하는 대로 수정 가능
                  // ),
                  Center(
                    child: Obx(() {
                      final startDate = controller.readBook.value?.startDate;
                      final formattedDate = startDate != null
                          ? '${startDate.year}-${startDate.month}-${startDate.day}'
                          : '';

                      return Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: Text(
                          formattedDate,
                          style: TextStyle(
                            fontFamily: 'Pretendard',
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
            height: 35,
            decoration: BoxDecoration(
              border: Border.all(
                width: 1.0,
                color: appColor.shade900,
              ),
            ),
            child: GestureDetector(
              onTap: () {
                openModalBottomSheet(2);
              },
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Text(
                        '종료일',
                        style: TextStyle(
                          fontFamily: 'Pretendard',
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  // ElevatedButton(
                  //   onPressed: () {
                  //     openModalBottomSheet(); // 모달 창 열기
                  //   },
                  //   child: Text('선택'), // 버튼 텍스트는 원하는 대로 수정 가능
                  // ),
                  Center(
                    child: Obx(
                      () => Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: Text(
                            style: TextStyle(
                              fontFamily: 'Pretendard',
                              color: Colors.black,
                              fontSize: 16,
                            ),
                            '${controller.readBook.value?.endDate.year}-${controller.readBook.value?.endDate.month}-${controller.readBook.value?.endDate.day}'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10, bottom: 5),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '총 페이지 수',
                style: TextStyle(
                    fontFamily: 'Pretendard',
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
            height: 35,
            decoration: BoxDecoration(
                border: Border.all(
              width: 1.0,
              color: appColor.shade900,
            )),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: Text(
                      '페이지 수',
                      style: TextStyle(
                        fontFamily: 'Pretendard',
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 16.3),
                        width: 150,
                        child: TextFormField(
                          textAlignVertical: TextAlignVertical.center,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: '${controller.readBook.value?.totalPage}',
                            border: InputBorder.none,
                          ),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                          onChanged: (value) {
                            try {
                              controller.readBook.value?.totalPage =
                                  int.parse(value);
                              print(controller.tabs);
                            } catch (e) {
                              // 예외 처리: 부적절한 입력이 들어온 경우
                              print("부적절한 입력입니다: $value");
                            }
                          },
                          textAlign: TextAlign.right,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 5),
                        child: Text(
                          ' 쪽',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            //평점 컨테이너
            margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    //텍스트 컨테이너
                    child: Text(
                      '평점',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ), //평점 텍스트 끝
                RatingBar.builder(
                  initialRating: controller.readBook.value!.grade,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  // 반 별점을 지원
                  itemCount: 5,
                  itemSize: 50,
                  onRatingUpdate: (rating) {
                    // 별점이 업데이트될 때 호출되는 함수
                    controller.readBook.value!.grade = rating;
                  },
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                ),
                // RatingStars(
                //   value: controller.book.value!.grade,
                //   onValueChanged: (v){
                //   },
                //   // starBuilder: (index, color) => Icon(
                //   //   Icons.star,
                //   //   color: color,
                //   //   size: 35,
                //   // ),
                //   starCount: 5,
                //   starSize: 50, //별 사이 간격
                //   valueLabelColor: const Color(0xff9b9b9b),
                //   valueLabelTextStyle: const TextStyle(
                //     color: Colors.white,
                //     fontWeight: FontWeight.w400,
                //     fontStyle: FontStyle.normal,
                //     fontSize: 12.0,),
                //   valueLabelRadius: 10,
                //   maxValue: 5,
                //   starSpacing: 1,
                //   maxValueVisibility: true,
                //   valueLabelVisibility: true,
                //   animationDuration: Duration(milliseconds: 1000),
                //   valueLabelPadding:
                //   const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
                //   valueLabelMargin: const EdgeInsets.only(right: 8),
                //   starOffColor: const Color(0xffe7e8ea),
                //   starColor: Colors.yellow,
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void openModalBottomSheet(index) {
    Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
          color: Colors.white, // 모달 창 배경색 변경
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        height: 300,
        child: Column(
          children: [
            SizedBox(
              height: 250,
              child: index == 1
                  ? ScrollDatePicker(
                      selectedDate: controller.readBook.value?.startDate ??
                          DateTime.now(),
                      locale: Locale('ko'),
                      scrollViewOptions: DatePickerScrollViewOptions(
                        year: ScrollViewDetailOptions(
                          label: '년',
                          margin: const EdgeInsets.only(right: 16),
                        ),
                        month: ScrollViewDetailOptions(
                          label: '월',
                          margin: const EdgeInsets.only(right: 16),
                        ),
                        day: ScrollViewDetailOptions(
                          label: '일',
                          margin: const EdgeInsets.only(right: 16),
                        ),
                      ),
                      onDateTimeChanged: (DateTime value) {
                        if (index == 1) {
                          final lastDayOfMonth =
                              DateTime(value.year, value.month + 1, 0).day;
                          controller.readBook.value?.startDate =
                              value.day <= lastDayOfMonth
                                  ? value
                                  : DateTime(
                                      value.year, value.month, lastDayOfMonth);
                        }
                      },
                    )
                  : ScrollDatePicker(
                      selectedDate:
                          controller.readBook.value?.endDate ?? DateTime.now(),
                      locale: Locale('ko'),
                      scrollViewOptions: DatePickerScrollViewOptions(
                        year: ScrollViewDetailOptions(
                          label: '년',
                          margin: const EdgeInsets.only(right: 16),
                        ),
                        month: ScrollViewDetailOptions(
                          label: '월',
                          margin: const EdgeInsets.only(right: 16),
                        ),
                        day: ScrollViewDetailOptions(
                          label: '일',
                          margin: const EdgeInsets.only(right: 16),
                        ),
                      ),
                      onDateTimeChanged: (DateTime value) {
                        if (index == 2) {
                          final lastDayOfMonth =
                              DateTime(value.year, value.month + 1, 0).day;
                          controller.readBook.value?.endDate =
                              value.day <= lastDayOfMonth
                                  ? value
                                  : DateTime(
                                      value.year, value.month, lastDayOfMonth);
                        }
                      }),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(left: 10),
                    child: TextButton(
                      onPressed: () {
                        Get.back(); // 모달 창 닫기
                      },
                      child: Text(
                        "취소",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(right: 10),
                    child: TextButton(
                      onPressed: () {
                        Get.back(result: true); // 모달 창 닫고 결과 반환
                      },
                      child: Text(
                        "저장",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ).then((result) {
      if (result != null && result == true) {
        controller.readBook.refresh(); // Rx 변수 강제 업데이트
        // 모달 창에서 "저장" 버튼을 누르면 상태 업데이트
        // 이 부분에서 필요한 상태 업데이트를 수행합니다.
        print("Start Date: ${controller.readBook.value?.startDate}");
        print("End Date: ${controller.readBook.value?.endDate}");
      }
    });
  }
}
