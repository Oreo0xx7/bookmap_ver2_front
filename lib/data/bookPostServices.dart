import 'dart:convert';
import 'package:bookmap_ver2/api_key.dart';
import 'package:bookmap_ver2/model/bookDetailReadPostModel.dart';
import 'package:bookmap_ver2/model/bookDetailReadingPostModel.dart';
import 'package:http/http.dart' as http;


class BookPostServices {
  static var client = http.Client();

  static void postBook(bookInfo, isbn) async {
    await client.post(
      Uri.parse('$url/book/save/4?isbn=$isbn'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: bookInfo is BookDetailReadPostModel
          ? bookDetailReadPostModelToJson(bookInfo)
          : bookDetailReadingPostModelToJson(bookInfo),
    );
  }

  static void postWantBook(isbn) async {
    var data = {'bookState': '읽고싶은'};
    var response = await client.post(
      Uri.parse('$url/book/save/4?isbn=$isbn'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );
  }

  static void postChangeState(bookInfo, isbn) async {
    var data = {'bookState': '읽고싶은'};
    var response =
        await client.post(Uri.parse('$url/book/changeall/4?isbn=$isbn'),
            headers: <String, String>{
              'Content-Type': 'application/json',
            },
            body: bookInfo is BookDetailReadPostModel
                ? bookDetailReadPostModelToJson(bookInfo)
                : bookInfo is BookDetailReadingPostModel
                    ? bookDetailReadingPostModelToJson(bookInfo)
                    : jsonEncode(data));
  }
  
  static void deleteStoredBook(isbn) async {
    await client.delete(Uri.parse('$url/book/delete/4?isbn=$isbn'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );
  }
}
