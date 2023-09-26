import 'package:bookmap_ver2/controller/loginController.dart';
import 'package:bookmap_ver2/controller/memoController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../asset.dart';

class MemoView extends StatelessWidget{
  LoginController loginController = Get.find<LoginController>();
  MemoController memoController = Get.find<MemoController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColor.shade300,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.0, // 그림자 없애기
        backgroundColor: Colors.white,
        title: Text("독서 메모",
            textAlign: TextAlign.start,
            style: TextStyle(
                color: appColor.shade800,
                fontSize: 22,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.bold)),
        actions: [IconButton(
            onPressed: (){loginController.logout();},
            icon: Icon(Icons.output_sharp, color: appColor.shade800,))],
      ),
      body: NotificationListener(
        onNotification: (OverscrollIndicatorNotification overscroll) {
          overscroll.disallowIndicator();
          return true;
        },
        child: ListView.builder(
          itemCount: memoController.memos.length,
          itemBuilder: (context, index){
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
                            flex: 3,
                            child: Image.network(memoController.memos[index].bookImg, )),
                        const Spacer(
                          flex: 1,
                        ),
                        Expanded(
                          flex: 11,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${memoController.memos[index].bookTitle}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'Pretendard'),),
                              Text('${memoController.memos[index].bookWriter}', style: TextStyle(fontSize: 13, fontFamily: 'Pretendard'),),
                              Padding(padding: EdgeInsets.only(bottom: 10)),
                              Text('${memoController.memos[index].startPage}~${memoController.memos[index].endPage}쪽을 읽고', style: TextStyle(fontSize: 13, fontFamily: 'Pretendard'),)
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
                                Get.bottomSheet(EditMemo(index),);
                              },
                            ))
                      ],
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 20)),
                    Text('${memoController.memos[index].memoTitle}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'Pretendard'),),
                    Text('${memoController.memos[index].memo}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, fontFamily: 'Pretendard'),),
                  ],
                ),
              ),
            );
          },
        ),
      ),

    );
  }

  Container EditMemo(int index) {
    return Container(
      padding: EdgeInsets.all(16),
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  flex: 3,
                  child: Image.network(memoController.memos[index].bookImg)),
              const Spacer(
                flex: 1,
              ),
              Expanded(
                flex: 11,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${memoController.memos[index].bookTitle}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'Pretendard'),),
                    Text('${memoController.memos[index].bookWriter}', style: TextStyle(fontSize: 13, fontFamily: 'Pretendard'),),
                    Padding(padding: EdgeInsets.only(bottom: 10)),
                    Text('${memoController.memos[index].startPage}~${memoController.memos[index].endPage}쪽을 읽고', style: TextStyle(fontSize: 13, fontFamily: 'Pretendard'),)
                  ],
                ),
              ),
              Expanded(
                  flex:2,
                  child: IconButton(
                    splashColor: appColor,
                    splashRadius: 15,
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      Get.bottomSheet(Column(
                      ));
                      },
                  ))
            ],
          ),
          Padding(padding: EdgeInsets.only(bottom: 20)),
          Text('${memoController.memos[index].memoTitle}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'Pretendard'),),
          Padding(padding: EdgeInsets.only(bottom: 10)),
          Text('${memoController.memos[index].memo}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, fontFamily: 'Pretendard'),),
        ],
      ),
    );
  }

}