import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';

import '../../asset.dart';
import '../../controller/bookDetailPopupController.dart';

class BookDetailViewTileReading extends StatelessWidget {
  final controller = Get.put(BookDetailPopupController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          //총페이지 수 입력 컨테이너
          margin: EdgeInsets.only(left: 10, bottom: 5),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '총 페이지 수',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Container(
          // 페이지 수 컨테이너
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
                      child: TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: controller.readingBook.value?.totalPage.toString(),
                          border: InputBorder.none,
                        ),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                        onChanged: (value) {
                          controller.readingBook.value?.totalPage =
                              int.parse(value);
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
          margin: EdgeInsets.only(left: 10, bottom: 5),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '독서량',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Container(
          //독서량 컨테이너
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
                    '읽은 페이지',
                    style: TextStyle(
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
                      child: TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: '${controller.readingBook.value?.readingPage}',
                          border: InputBorder.none,
                        ),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                        onChanged: (value) {
                          controller.readingBook.value?.readingPage =
                              int.parse(value);
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
          margin: EdgeInsets.only(left: 10, bottom: 5),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '독서 기간',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Container(
          //독서기간 컨테이너
          margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
          height: 35,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1.0,
              color: appColor.shade900,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: Text(
                    '시작일',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              Container(
                child: GestureDetector(
                    onTap: () {
                      _openModalBottomSheet();
                    },
                    child: Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: Text(
                          '${controller.readingBook.value?.startDate.year}-${controller.readingBook.value?.startDate.month}-${controller.readingBook.value?.startDate.day}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _openModalBottomSheet() {
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
                child: ScrollDatePicker(
                  selectedDate:
                      controller.readingBook.value?.startDate ?? DateTime.now(),
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
                    final lastDayOfMonth = DateTime(value.year, value.month + 1, 0).day;
                    controller.readingBook.value?.startDate = value.day <= lastDayOfMonth ? value : DateTime(value.year, value.month, lastDayOfMonth);
                  },
                )),
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
        controller.readingBook.refresh(); // Rx 변수 강제 업데이트
        // 모달 창에서 "저장" 버튼을 누르면 상태 업데이트
        // 이 부분에서 필요한 상태 업데이트를 수행합니다.
      }
    });
  }
}
