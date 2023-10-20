import 'package:bookmap_ver2/model/bookMapEditModel.dart';
import 'package:get/get.dart';
import 'package:bookmap_ver2/data/bookMapServices.dart';

import 'loginController.dart';

class BookMapDetailController extends GetxController {
  LoginController loginController = Get.find<LoginController>();
  var bookMap = BookMap().obs;
  var scrap;

  void updateData(newBookMap) {
    bookMap(newBookMap);
  }

  @override
  void onClose() {
    bookMap(BookMap());
  }

  Future<void> fetchData(bookMapId) async {
    var bookMapData = await BookMapServices.getBookMapDetail(bookMapId);
    scrap = await BookMapServices.getCheckScrap(loginController.sessionId, bookMapId);
    bookMap(bookMapData);
  }

  Future<void> scrapBookMap(bookMapId) async{
    var data = BookMapServices.postBookMapScrap(loginController.sessionId, bookMapId);
  }

  void deleteBookMap(bookMapId) {
    BookMapServices.deleteBookMap(bookMapId);
  }

  Future<void> deleteScrap(bookMapId) async{
    var data = BookMapServices.deleteBookMapScrap(loginController.sessionId, bookMapId);
  }
}
