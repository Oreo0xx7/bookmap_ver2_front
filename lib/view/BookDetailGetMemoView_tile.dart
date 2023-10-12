
import 'package:bookmap_ver2/model/bookDetailGetModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../asset.dart';
import '../controller/bookDetailPopupController.dart';
import 'mainView.dart';

class BookDetailGetMemoViewTile extends StatelessWidget {

  final BookMemoResponseDto bookMemoResponseDto;

  BookDetailGetMemoViewTile(this.bookMemoResponseDto);

  final controller = Get.put(BookDetailPopupController());


  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16)
      ),
      surfaceTintColor: appColor,
      margin: EdgeInsets.all(12),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 11,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(padding: EdgeInsets.only(bottom: 10)),
                      Text('${bookMemoResponseDto.page}쪽을 읽고', style: TextStyle(fontSize: 13, fontFamily: 'Pretendard'),)
                    ],
                  ),
                ),
                Expanded(
                    flex:1,
                    child: IconButton(
                      splashColor: appColor,
                      splashRadius: 15,
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        //Get.bottomSheet();
                        modifyMemo(context);
                      },
                    )),
                Padding(padding: EdgeInsets.only(left: 20)),
                Expanded(
                    flex:1,
                    child: IconButton(
                      splashColor: appColor,
                      splashRadius: 15,
                      icon: Icon(Icons.delete_forever),
                      onPressed: () {
                        // Get.bottomSheet(EditMemo(index),);
                        print("bookMemoResponseDto.id : ${bookMemoResponseDto.id}");
                        controller.deleteMemo(bookMemoResponseDto.id);
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/', (_) => false);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  MainView()),
                        );

                      },
                    )),
              ],
            ),
            Padding(padding: EdgeInsets.only(bottom: 20)),
            Text('${bookMemoResponseDto.title}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'Pretendard'),),
            Text('${bookMemoResponseDto.content}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, fontFamily: 'Pretendard'),),
          ],
        ),
      ),
    );

  }

  modifyMemo(BuildContext context) {

    TextEditingController titleController = TextEditingController();
    TextEditingController contentController = TextEditingController();
    TextEditingController pageController = TextEditingController(text: "");


// 기존 데이터를 설정
    titleController.text = bookMemoResponseDto.title;
    contentController.text = bookMemoResponseDto.content;
    pageController.text = bookMemoResponseDto.page.toString();

    var memoTitle = bookMemoResponseDto.title;
    var memoContent = bookMemoResponseDto.content;
    var memoPage = bookMemoResponseDto.page;

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

                        controller.modify(
                            memoTitle ?? '',
                            memoContent ?? '',
                            memoPage ?? 0,
                            bookMemoResponseDto.id);

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
                      child: Text("수정"))
                ],
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
                      decoration: InputDecoration(hintText: '메모 제목'),
                      controller: titleController,
                      onChanged: (value) {
                        memoTitle = value;
                        //print("memo title is ${bookMemoResponseDto.title}");
                      },
                    ),
                    TextField(
                      maxLines: null, // 여러 줄 입력을 가능하게 합니다.
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(hintText: '메모'),
                      controller: contentController,
                      onChanged: (value) {
                        memoContent = value;
                      },
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
                              controller: pageController,
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
}
