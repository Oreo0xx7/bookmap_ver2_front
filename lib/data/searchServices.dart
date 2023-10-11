import 'dart:convert';
import 'package:bookmap_ver2/api_key.dart';
import 'package:bookmap_ver2/model/bookDetailGetModel.dart';
import 'package:bookmap_ver2/model/searchUserModel.dart';
import 'package:http/http.dart' as http;

import '../model/bookDetailModel.dart';
import '../model/mainSearchBookMapModel.dart';
import '../model/mainSearchBookModel.dart';
import '../model/mainViewModel.dart';

class SearchServices {
  static var client = http.Client();

  static Future<List<Document>?> fetchBooks(searchText) async {
    print(searchText);
    var response = await client.get(
        Uri.parse(
            'https://dapi.kakao.com/v3/search/book?target=title&query=$searchText'),
        headers: {"Authorization": "KakaoAK 15143c9a4aee2d6700abc8ef957d0dc6"});
    if (response.statusCode == 200) {
      var jsonData = response.body;
      var documents = bookFromJson(jsonData).documents;

      if (documents.isNotEmpty) {
        return documents;
      } else {
        return null; // 검색 결과가 없을 경우 null 반환
      }
    } else {
      return null;
    }
  }

  static Future<List<MainSearchBookMapModel>?> fetchBookmaps(searchText) async {
    var response = await client.get(
      Uri.parse('$url/bookmap/search/$searchText'),
    );
    if (response.statusCode == 200) {
      var jsonData = utf8.decode(response.bodyBytes); // 바이트 데이터를 디코딩
      var documents = searchBookMapFromJson(jsonData);
      if (documents.isNotEmpty) {
        return documents;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<BookDetailModel?> fetchBookDetail(searchText) async {
    var response =
        await client.get(Uri.parse('$url/bookdetail/4?isbn=$searchText'));
    if (response.statusCode == 200) {
      var jsonData = utf8.decode(response.bodyBytes); // 바이트 데이터를 디코딩
      var document = bookDetailModelFromJson(jsonData);
      return document;
    } else {
      return null;
    }
  }

  static Future<BookDetailGetModel?> fetchBookDetailGet(searchText) async {
    var response =
        await client.get(Uri.parse('$url/bookdetail/4?isbn=$searchText'));
    if (response.statusCode == 200) {
      var jsonData = utf8.decode(response.bodyBytes); // 바이트 데이터를 디코딩
      var document = bookDetailGetModelFromJson(jsonData);
      return document;
    } else {
      return null;
    }
  }

  static Future<List<SearchUserModel>?> fetchUsers(searchText) async {
    var response =
        await client.get(Uri.parse('$url/search/user/4?keyword=$searchText'));
    if (response.statusCode == 200) {
      var jsonData = utf8.decode(response.bodyBytes); // 바이트 데이터를 디코딩
      var document = searchUserModelFromJson(jsonData);
      return document;
    } else {
      return null;
    }
  }

  static Future<MainViewModel?> fetchMainData(sessionId) async {

    var data = {'sessionId': sessionId.toString()};

    var response = await client.post(Uri.parse('$url/main'),
      body: jsonEncode(data)
    );
    if (response.statusCode == 200) {
      var jsonData = utf8.decode(response.bodyBytes); // 바이트 데이터를 디코딩
      var document = mainViewModelFromJson(jsonData);
      return document;
    } else {
      return null;
    }
  }
}
