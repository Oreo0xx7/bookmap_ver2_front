import 'package:bookmap_ver2/controller/loginController.dart';
import 'package:bookmap_ver2/model/bookMapModel.dart';
import 'package:get/get.dart';

import '../data/bookMapServices.dart';

class BookMapController extends GetxController{
  LoginController loginController = Get.find<LoginController>();

  // var allBookMaps = <BookMapModel>[].obs;
  var scrapBookMaps = <BookMapModel>[].obs;
  var myBookMaps = <BookMapModel>[].obs;
  var newBookMap = BookMapModel().obs;

  @override
  void onInit(){
    super.onInit();
    fetchData();
  }

  Future<void> fetchData() async{
    var myData = await BookMapServices.postBookMapView(loginController.sessionId);
    if (myData != null) {
      myBookMaps.assignAll(myData);
      myBookMaps.refresh();
    }
    var scrapData = await BookMapServices.postBookMapScrapView(loginController.sessionId);
    if (scrapData != null) {
      scrapBookMaps.assignAll(scrapData);
      scrapBookMaps.refresh();
    }
    // if (myData != null || scrapData != null){
    //   List.from(myData!).addAll(scrapData!);
    //   allBookMaps.assignAll(myData);
    // }
  }

  Future<void> saveNew() async {
    var bookMap = newBookMap.value;
    var checkSaved = await BookMapServices.postBookMapSave(loginController.sessionId,
        bookMap.bookMapTitle, bookMap.bookMapContent, bookMap.hashTag);
    if (checkSaved != null){
      bookMap.bookMapId = checkSaved;
      myBookMaps.add(bookMap);
      newBookMap(BookMapModel());
    }
  }
}

List<String> makeHash(List<String>? tags) {
  List<String> newHash = [];
  tags?.forEach((tag) {
    tag = tag.replaceAll(RegExp(r'''^!#%&@`:;-.<>,~\\(\\)\\{\\}\\^\\[\\][*][+][$][|][']["]'''), "");
    tag = tag.trim();
    if (tag.isNotEmpty){
      newHash.add("#" + tag);
    }
  });
  return newHash;
}