import 'dart:convert';

import 'package:bookmap_ver2/controller/bookMapDetailController.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:http/io_client.dart';
import '../api_key.dart';
import 'package:get/get.dart';
import '../asset.dart';
import '../controller/bookMapEditController.dart';
import 'package:bookmap_ver2/model/bookMapEditModel.dart';
import 'bookMapEditSearchView.dart';

class BookMapEditView extends StatelessWidget {
  BookMapEditView({Key? key}) : super(key: key);
  // final controller = Get.find<BookMapEditController>();
  final editController = Get.put(BookMapEditController(), tag: Get.parameters['id']);
  // final editController = Get.put(BookMapEditController());
  // final viewController = Get.find<BookMapDetailController>();
  final viewController = Get.put(BookMapDetailController(), tag: Get.parameters['id']);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) => AlertDialog(
            content: Text("저장되지 않은 변경 사항이 있습니다."),
            actions: <Widget>[
              TextButton(
                child: Text("취소"),
                onPressed: () => Navigator.pop(context, false),
              ),
              TextButton(
                child: Text("종료"),
                onPressed: () {
                  editController.resetData();
                  Navigator.pop(context, true);
                },
              ),
            ],
          ),
        );
      },
      child: Scaffold(
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
            actions: [TextButton(
              child: Text("저장"),
              onPressed: () {
                editController.removeImage();
                viewController.updateData(editController.bookMap.value);
                Get.back();
                // _postMapDetail(controller.bookMap.value.bookMapId, controller.bookMap.value);
              },
            ),],
        ),
        body: GestureDetector(
          onTap: (){
            FocusScope.of(context).unfocus();
          },
          child: Column(
            children: [
              Expanded(
                child: Obx(() {
                  final bookMap = editController.bookMap.value;
                  return Container(
                    margin: EdgeInsets.all(1),
                    child: Padding(
                      padding: EdgeInsets.all(6),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Switch(
                                  value: bookMap.share,
                                  onChanged: (value){
                                    editController.updateShare(value);
                                  },
                                ),
                                Text("공개 여부"),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: TextField(
                                style: TextStyle(fontSize: 14),
                                controller: TextEditingController(text: bookMap.bookMapTitle),
                                decoration: myDecoration("북맵 제목"),
                                onChanged: (value) {
                                  bookMap.bookMapTitle = value;
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: TextField(
                                style: TextStyle(fontSize: 14),
                                controller: TextEditingController(text: bookMap.bookMapContent),
                                decoration: myDecoration("북맵 설명"),
                                onChanged: (value) {
                                  bookMap.bookMapContent = value;
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: TextField(
                                style: TextStyle(fontSize: 14),
                                controller: TextEditingController(text: bookMap.hashTag?.join(" ")),
                                decoration: myDecoration("해시태그"),
                                onChanged: (value) {
                                  bookMap.hashTag = value.trim().split(' ');
                                },
                              ),
                            ),
                            myIndex(bookMap.bookMapIndex),
                            ElevatedButton(
                                onPressed: (){

                                },
                                child: Text("+")
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [

                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget myBook(List<dynamic> books, int booksIndex){
    editController.addImage();
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(2.0),
          height: 100,
          width: 300,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: books.length,
              itemBuilder: (context, index){
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () async {
                      (books[index].id == -10)
                          ? books.add(await Get.to(() => BookMapEditSearchView())) //나중에 데이터 값 맞추기
                          : editController.bookMap.value.bookMapIndex?[booksIndex].map?.removeAt(index);
                      editController.updateBooks(booksIndex, editController.bookMap.value.bookMapIndex?[booksIndex].map);
                    },
                    child: Image.network(
                      books[index].image,
                      // height: 130,
                    ),
                  ),
                );
              }),
        )
      ],
    );
  }

  Widget myMemo(String memo){
    return Container(
      padding: const EdgeInsets.all(6.0),
      child: TextField(
        style: TextStyle(fontSize: 14),
        controller: TextEditingController(text: memo),
        decoration: myDecoration("메모 입력"),
      ),
    );
  }

  Widget myIndex(List<dynamic>? bookMapIndex) {
    return Container(
      padding: const EdgeInsets.all(2.0),
      margin: const EdgeInsets.all(2.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 500,
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: bookMapIndex?.length,
                itemBuilder: (context, index){
                  bookMapIndex ?? Container();
                  if("Book".compareTo(bookMapIndex?[index].type) == 0){
                    return myBook(bookMapIndex?[index].map, index);
                  }else if("Memo".compareTo(bookMapIndex?[index].type) == 0){
                    return myMemo(bookMapIndex?[index].memo);
                  }
                  else{
                    return Container();
                  }
                }
            ),
          ),

        ],
      ),
    );
  }


}


// void _postMapDetail(bookMapId, myBookMapDetail) async {
//   final response = await http.post(
//     Uri.parse('$bookmapKey/bookmap/update/$bookMapId'),
//     headers: <String, String>{
//       'Content-Type': 'application/json',
//     },
//     body: jsonEncode(myBookMapDetail),
//   );
// }




InputDecoration myDecoration(String label){
  return InputDecoration(
    border: OutlineInputBorder(),
    contentPadding: EdgeInsets.all(8.0),
    labelText: label,
  );
}




