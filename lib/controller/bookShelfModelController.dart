import 'package:bookmap_ver2/data/searchServices.dart';
import 'package:bookmap_ver2/model/bookShelfAllModel.dart';
import 'package:bookmap_ver2/view/startView.dart';
import 'package:get/get.dart';

class BookShelfModelController extends GetxController {
  var shelfBooks = <BookShelfAllModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
    //네트워크 요구
  }

  void fetchData() async {
    var data =
        await SearchServices.fetchShelf(loginController.sessionId.toString());
    if (data != null) {
      shelfBooks.value = data;
    }
  }
}
