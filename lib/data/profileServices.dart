import 'dart:convert';

import 'package:bookmap_ver2/model/bookDetailGetModel.dart';
import 'package:bookmap_ver2/model/memoListModel.dart';

import '../api_key.dart';
import '../model/profileViewModel.dart';
import 'package:http/http.dart' as http;

class ProfileServices{
  static var client = http.Client();

  static Future<ProfileViewModel?> fetchProfile(sessionId) async{
    var response =
    await client.get(Uri.parse('$url/profile'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'sessionId' : sessionId.toString()
      },);
    if (response.statusCode == 200) {
      var jsonData = utf8.decode(response.bodyBytes); // 바이트 데이터를 디코딩
      var document = profileViewModelFromJson(jsonData);
      return document;
    } else {
      return null;
    }
  }

  static Future<List<MemoListModel>?> fetchMemoList(sessionId) async{
    var response =
    await client.get(Uri.parse('$url/bookmemo/all'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'sessionId' : sessionId.toString()
      },);
    if (response.statusCode == 200) {
      var jsonData = utf8.decode(response.bodyBytes); // 바이트 데이터를 디코딩
      var document = memoListModelFromJson(jsonData);
      return document;
    } else {
      return null;
    }
  }

  static void modifyUserData(sessionId, nickName, status) async{
    var data = {'nickName': nickName,  'status': status};
    await client.post(Uri.parse('$url/profile/update'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'sessionId' : sessionId.toString()
        },
        body: jsonEncode(data));
  }
}