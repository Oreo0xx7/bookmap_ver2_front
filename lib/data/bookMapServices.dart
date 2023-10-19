import 'dart:convert';

import 'package:get/get.dart';

import '../model/bookMapEditModel.dart';
import '../model/bookMapModel.dart';
import '../model/bookMapSaveModel.dart';
import 'package:http/http.dart' as http;
import 'package:bookmap_ver2/api_key.dart';


class BookMapServices{
  static var client = http.Client();

  static Future<BookMap?> getBookMapDetail(bookMapId) async {
    var response = await client.get(
        Uri.parse('$url/bookmap/view/$bookMapId'));
    if (response.statusCode == 200) {
      var jsonData = utf8.decode(response.bodyBytes);
      var bookMap = bookMapFromJson(jsonData);
      if (bookMap != null) {
        return bookMap;
      } else {
        return null; // 검색 결과가 없을 경우 null 반환
      }
    } else {
      return null;
    }
  }




  static Future<Iterable<BookMapModel>?> postBookMapView(sessionId) async {
    var response = await client.post(
      Uri.parse('$url/bookmap'),
      headers: <String, String>{
        'sessionId': sessionId.toString(),
      },
    );
    if (response.statusCode == 200) {
      var jsonData = utf8.decode(response.bodyBytes);
      var bookMapList = bookMapModelFromJson(jsonData);
      return bookMapList;
    }
    else {
      return null;
    }
  }

  static Future<Iterable<BookMapModel>?> postBookMapScrapView(sessionId) async {
    var response = await client.post(
      Uri.parse('$url/bookmap/scrap'),
      headers: <String, String>{
        'sessionId': sessionId.toString(),
      },
    );
    if (response.statusCode == 200) {
      var jsonData = utf8.decode(response.bodyBytes);
      var bookMapScrapList = bookMapModelFromJson(jsonData);
      return bookMapScrapList;
    }
    else {
      return null;
    }
  }



  static Future<int?> postBookMapSave(sessionId, title, content, hashTag) async {
    BookMapSaveModel bookMapSave = BookMapSaveModel(
        bookMapTitle: title ?? "",
        bookMapContent: content ?? "",
        hashTag: hashTag ?? []);
    var response = await client.post(
      Uri.parse('$url/bookmap/save'),
      headers: <String, String>{
        'sessionId': sessionId.toString(),
        'Content-Type': 'application/json',
      },
        body: bookMapSaveModelToJson(bookMapSave),
    );
    if (response.statusCode == 200) {
      var data = utf8.decode(response.bodyBytes);
      return int.parse(data);
    }
    else {
      return null;
    }
  }

  static void postBookMapScrap(sessionId, bookMapId) async {
    var response = await client.post(
      Uri.parse('$url/bookmap/scrap/save/$bookMapId'),
      headers: <String, String>{
        'sessionId': sessionId.toString(),
        'Content-Type': 'application/json',
      },
    );
  }

  static void postBookMapToMy(bookMapId, bookMap) async {
    var response = await client.post(
      Uri.parse('$url/tomy/save/$bookMapId'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: bookMapToJson(bookMap),
    );
  }

  static Future<int> postBookMapUpdate(sessionId, bookMapId, bookMap) async {
    var response = await client.post(
      Uri.parse('$url/bookmap/update/$bookMapId'),
      headers: <String, String>{
        'sessionId': sessionId.toString(),
        'Content-Type': 'application/json',
      },
      body: bookMapToJson(bookMap),
    );
    return response.statusCode;
  }


  static Future<String> postScrapId(sessionId, bookMapId) async {
    var response = await client.post(
      Uri.parse('$url/bookmap/get/scrap/$bookMapId'),
      headers: <String, String>{
        'sessionId': sessionId.toString(),
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      var data = utf8.decode(response.bodyBytes);
      return data;
    }
    else {
      return "";
    }
  }

  static void deleteBookMap(bookMapId) async {
    await client.delete(
      Uri.parse('$url/bookmap/delete/$bookMapId'),
    );
  }

  static void deleteBookMapScrap(sessionId, bookMapId) async {
    var bookMapScrapId = await postScrapId(sessionId, bookMapId);
    client.delete(
      Uri.parse('$url/bookmap/scrap/delete/$bookMapScrapId'),
    );
  }

}