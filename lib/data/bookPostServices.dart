import 'dart:convert';
import 'package:bookmap_ver2/api_key.dart';
import 'package:bookmap_ver2/model/bookDetailReadPostModel.dart';
import 'package:bookmap_ver2/model/bookDetailReadingPostModel.dart';
import 'package:http/http.dart' as http;


class BookPostServices {
  static var client = http.Client();

  static void postBook(bookInfo, isbn, sessionId) async {
    await client.post(
      Uri.parse('$url/book/save?isbn=$isbn'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'sessionId' : sessionId.toString()
      },
      body: bookInfo is BookDetailReadPostModel
          ? bookDetailReadPostModelToJson(bookInfo)
          : bookDetailReadingPostModelToJson(bookInfo),
    );
  }

  static void postWantBook(isbn, sessionId) async {
    var data = {'bookState': '읽고싶은'};
    var response = await client.post(
      Uri.parse('$url/book/save?isbn=$isbn'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'sessionId' : sessionId.toString()
      },
      body: jsonEncode(data),
    );
  }

  static void postChangeState(bookInfo, isbn, sessionId) async {
    var data = {'bookState': '읽고싶은'};
    var response =
        await client.post(Uri.parse('$url/book/changeall?isbn=$isbn'),
            headers: <String, String>{
              'Content-Type': 'application/json',
              'sessionId' : sessionId.toString()

            },
            body: bookInfo is BookDetailReadPostModel
                ? bookDetailReadPostModelToJson(bookInfo)
                : bookInfo is BookDetailReadingPostModel
                    ? bookDetailReadingPostModelToJson(bookInfo)
                    : jsonEncode(data));
  }
  
  static void deleteStoredBook(isbn, sessionId) async {
    await client.delete(Uri.parse('$url/book/delete?isbn=$isbn'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'sessionId' : sessionId.toString()
      },
    );
  }

  static void postBookMemoData(title, content, page, isbn, sessionId) async {
    var data = {'content': content,  'title': title, 'page': page};
    await client.post(Uri.parse('$url/bookmemo/save?isbn=$isbn'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'sessionId' : sessionId.toString()
        },
        body: jsonEncode(data));
  }

  static void modifyBookMemoData(title, content, page, id) async{
    var data = {'content': content,  'title': title, 'page': page};
    await client.post(Uri.parse('$url/bookmemo/update/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data));
  }

  static void deleteMemo(memoId) async{
    await client.delete(
      Uri.parse('$url/bookmemo/delete/$memoId'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );
  }
}
