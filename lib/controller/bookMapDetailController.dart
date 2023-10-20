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

  void fetchData(bookMapId) async {
    var bookMapData = await BookMapServices.getBookMapDetail(bookMapId);
    scrap = await BookMapServices.getCheckScrap(loginController.sessionId, bookMapId);
    bookMap(bookMapData);
  }

  void scrapBookMap(bookMapId) {
    BookMapServices.postBookMapScrap(loginController.sessionId, bookMapId);
  }

  void deleteBookMap(bookMapId) {
    BookMapServices.deleteBookMap(bookMapId);
  }

  void deleteScrap(bookMapId){
    BookMapServices.deleteBookMapScrap(loginController.sessionId, bookMapId);
  }
}
