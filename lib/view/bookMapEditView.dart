import 'dart:convert';

import 'package:bookmap_ver2/controller/bookMapDetailController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
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

  void openDialog(){
    Get.dialog(
      AlertDialog(
        actions: [
          Center(
            child: TextButton(
              child: const Text('도서', style: TextStyle(fontSize: 14, color: Colors.black),),
              onPressed: () {
                editController.addIndex("Book");
                // editController.addImage();
                Get.back();
              },
            ),
          ),
          Center(
            child: TextButton(
              child: const Text('메모', style: TextStyle(fontSize: 14, color: Colors.black),),
              onPressed: () {
                editController.addIndex("Memo");
                Get.back();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget myBook(List<dynamic>? books, int booksIndex){
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(2.0),
            height: 100,
            width: double.infinity,
            child: ListView.builder(
              
                scrollDirection: Axis.horizontal,
                itemCount: books?.length,
                itemBuilder: (context, index){
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () async {
                        if(books != null) {
                          (books?[index].id == -10)
                              ? editController.addBook(booksIndex, index, await Get.to(() => BookMapEditSearchView()))
                              : editController.bookMap.value.bookMapIndex?[booksIndex].map?.removeAt(index);
                          editController.updateBooks(booksIndex, editController.bookMap.value.bookMapIndex?[booksIndex].map);
                        }
                        else {
                          editController.addBook(booksIndex, index, MapElement(id: -10, isbn: '',
                              image: 'https://postfiles.pstatic.net/MjAyMzA2MDlfMTUz/MDAxNjg2MzA5MTk2Njc1.e0lBE1zzXGIZIg03GQ6c-J2E6ahezLFCWsZMZWpolYAg.nomA0xkMNBmkhgZ8q84XIbwer4nE9_KxtBojTb_vYTMg.PNG.odb1127/image.png?type=w773'
                          ));
                        }
                      },
                      child: Image.network(
                        books?[index].image,
                        // height: 130,
                      ),
                    ),
                  );
                }),
          ),
        )
      ],
    );
  }

  Widget myMemo(String memo){
    memo ??= "";
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
    editController.addImage();
    return Container(
      padding: const EdgeInsets.all(2.0),
      margin: const EdgeInsets.all(2.0),
      child: Column(
        // mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: bookMapIndex?.length,
                itemBuilder: (context, index){
                  if(bookMapIndex != null) {
                    if ("Book".compareTo(bookMapIndex[index].type) == 0) {
                      if(bookMapIndex[index].map == null) {
                        bookMapIndex[index].map.insert(0, MapElement(
                            id: -10, isbn: '',
                            image: 'https://postfiles.pstatic.net/MjAyMzA2MDlfMTUz/MDAxNjg2MzA5MTk2Njc1.e0lBE1zzXGIZIg03GQ6c-J2E6ahezLFCWsZMZWpolYAg.nomA0xkMNBmkhgZ8q84XIbwer4nE9_KxtBojTb_vYTMg.PNG.odb1127/image.png?type=w773'
                        ));
                      }
                      return myBook(bookMapIndex[index].map, index);
                    } else if ("Memo".compareTo(bookMapIndex[index].type) == 0) {
                      var memo = bookMapIndex[index].memo ??= "";
                      return myMemo(memo);
                    } else {
                      return Container();
                    }
                  }
                }
            ),
          ),
          ElevatedButton(
            onPressed: (){
              openDialog();
            },
            child: Text(
              "+",
              style: TextStyle(
                  color: Colors.white,
                fontSize: 20,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white24,
              padding: EdgeInsets.fromLTRB(4, 10, 4, 10),
              alignment: Alignment.center,
              minimumSize: Size(double.infinity, 0),
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




