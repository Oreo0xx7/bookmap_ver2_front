import 'package:http/http.dart' as http;
import 'package:bookmap_ver2/api_key.dart';
import '../model/mainSearchBookModel.dart';

class BookGetService{
  static var client = http.Client();

  static Future<List<Document>?> getAllBook() async {
    var response = await client.post(
      Uri.parse('$url/bookshelf/allbooks/4'));
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
}