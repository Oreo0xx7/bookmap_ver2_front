import 'package:bookmap_ver2/data/searchServices.dart';
import 'package:bookmap_ver2/model/mainSearchBookMapModel.dart';
import 'package:bookmap_ver2/model/searchUserModel.dart';
import 'package:get/get.dart';

import '../model/mainSearchBookModel.dart';

class MainSearchController extends GetxController{
  var bookList = <Document>[].obs;
  var bookMapList  = <MainSearchBookMapModel>[].obs;
  var userList = <SearchUserModel>[].obs;
  var searchText = ''.obs;
  var tabs = <bool>[true, false, false].obs;
  var tabStatus = true.obs;

  void toggleTabs(int index) {
    //tabStatus.value = !tabStatus.value;
    for (int i = 0; i <3 ; i++) {tabs[i] = false;}
    tabs[index] = !tabs[index];
    print("현재 탭 상황" + tabs[0].toString() + tabs[1].toString() + tabs[2].toString());

    fetchData();
    // if (tabStatus.value == true) {
    //   fetchData();
    // } else {
    //   //네트워크
    // }
  }

  @override
  void onInit() {
    super.onInit();
    fetchData();
    print("현재 탭 상황" + tabs[0].toString() + tabs[1].toString() + tabs[2].toString());
    //네트워크 요구
  }

  void fetchData() async {
    var books = await SearchServices.fetchBooks(searchText);
    var searchBookmaps = await SearchServices.fetchBookmaps(searchText);
    var users = await SearchServices.fetchUsers(searchText);
    if (books != null) {
      bookList.value = books;
      print(books);
    }
    if( searchBookmaps != null){
      bookMapList.value = searchBookmaps;
      print(searchBookmaps);
    }else{
      bookMapList.value = [];
    }
    if(users != null){
      userList.value = users;
    }
  }

  void onSearchTextChanged(String text) {
    searchText.value = text;
  }
}