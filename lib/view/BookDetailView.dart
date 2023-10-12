import 'dart:convert';

import 'package:bookmap_ver2/model/bookDetailGetModel.dart';
import 'package:bookmap_ver2/model/bookDetailModel.dart';
import 'package:bookmap_ver2/view/BookDetailGetModel_tile.dart';
import 'package:bookmap_ver2/view/BookDetailView_tile.dart';
import 'package:bookmap_ver2/view/startView.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../api_key.dart';


class BookDetailView extends StatelessWidget {

  // final controller = Get.put(BookDetailController());

  @override
  Widget build(BuildContext context) {

    final bookProvider = Provider.of<BookProvider>(context);

    return DefaultTabController(
      length: 2,  // Added
      initialIndex: 0, //Added
      child: Center(
        child: FutureBuilder(
          future: bookProvider.fetchBook(),
          builder: (context, snapshot){
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (bookProvider.book == null) {
              return Text('No data available.');
            } else{
              final book = bookProvider.book!;
              print(book);
              if( book is BookDetailModel){
                print("저장안된 책");
                return BookDetailViewTile(book);
              }else {
                print("저장된 화면");
                return BookDetailGetViewTile(book);
              }

            }
          },
      )
      ),
    );
  }
}

class BookProvider extends ChangeNotifier{


  var value = Get.arguments;

  static var client = http.Client();

  dynamic _book; // 단일 객체

  dynamic get book => _book;


  Future<void> fetchBook() async{
    print("체크 value: " + value);
    var response = await client.get(
        Uri.parse('$url/book/detail?isbn=$value'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'sessionId' : loginController.sessionId.toString()
      },
    );
    if (response.statusCode == 200) {
      var jsonData = utf8.decode(response.bodyBytes); // 바이트 데이터를 디코딩
      try {
        _book = bookDetailGetModelFromJson(jsonData); // BookDetailGetModel로 디코딩 시도

      } catch (e) {
        _book = bookDetailModelFromJson(jsonData); // BookDetailModel로 디코딩 시도
      }
      print(_book);
    } else {
      throw Exception('Failed to load data');
    }
  }
  notifyListners() {
    // TODO: implement notifyListners
    throw UnimplementedError();
  }

  void memo(){
    notifyListeners();
  }
}