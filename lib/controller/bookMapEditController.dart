import 'package:bookmap_ver2/model/bookMapEditModel.dart';
import 'package:get/get.dart';

import '../data/bookMapServices.dart';
import 'loginController.dart';

class BookMapEditController extends GetxController {
  LoginController loginController = Get.find<LoginController>();
  var bookMap = BookMap().obs;

  @override
  void onClose(){
    fetchData(bookMap.value.bookMapId);
    super.onClose();
  }

  void fetchData(bookMapId) async {
    var bookMapData = await BookMapServices.getBookMapDetail(bookMapId);
    bookMap(bookMapData);
  }

  void updateData(newBookMap){
    bookMap(newBookMap);
  }

  void updateShare(newShare){
    bookMap.update((val) {
      val?.share = newShare;
    });
  }

  void updateBooks(int booksIndex, newBooks){
    bookMap.update((val) {
      val?.bookMapIndex?[booksIndex].map = newBooks;
    });
  }

  void updateBookMap(bookMapId){
    BookMapServices.postBookMapUpdate(loginController.sessionId, bookMapId, bookMap);
  }

  void addIndex(String type){
    if (type == "Book"){
      bookMap.update((val) {
        val?.bookMapIndex?.add(BookMapIndex(type: type,
            map: [
              MapElement(
                id: -10, isbn: '',
                image: 'https://postfiles.pstatic.net/MjAyMzA2MDlfMTUz/MDAxNjg2MzA5MTk2Njc1.e0lBE1zzXGIZIg03GQ6c-J2E6ahezLFCWsZMZWpolYAg.nomA0xkMNBmkhgZ8q84XIbwer4nE9_KxtBojTb_vYTMg.PNG.odb1127/image.png?type=w773'
            ),
            ],
        ));
      });
    } else if (type == "Memo"){
      bookMap.update((val) {
        val?.bookMapIndex?.add(BookMapIndex(type: type));
      });
    }
  }

  void addBook(booksIndex, index, book){
    bookMap.update((val) {
      val!.bookMapIndex?[booksIndex].map?.insert(index, book);
    });
  }

  void addImage() {
    bookMap.value.bookMapIndex?.forEach((index) {
      if (index.type == "Book") {
        if(index.map?.length != 0){
          var books = index.map;
          int len = books!.length;
          if((len <= 3) ? ((books[len-1].id != -10) ? true : false) : false) {
            books.add(MapElement(
                id: -10, isbn: '',
                image: 'https://postfiles.pstatic.net/MjAyMzA2MDlfMTUz/MDAxNjg2MzA5MTk2Njc1.e0lBE1zzXGIZIg03GQ6c-J2E6ahezLFCWsZMZWpolYAg.nomA0xkMNBmkhgZ8q84XIbwer4nE9_KxtBojTb_vYTMg.PNG.odb1127/image.png?type=w773'
            ));
          }
        }
        else{
          index.map?.add(MapElement(
              id: -10, isbn: '',
              image: 'https://postfiles.pstatic.net/MjAyMzA2MDlfMTUz/MDAxNjg2MzA5MTk2Njc1.e0lBE1zzXGIZIg03GQ6c-J2E6ahezLFCWsZMZWpolYAg.nomA0xkMNBmkhgZ8q84XIbwer4nE9_KxtBojTb_vYTMg.PNG.odb1127/image.png?type=w773'
          ));
        }
      }
    });
  }

  void removeImage() {
    var nullCheck = [];
    bookMap.value.bookMapIndex?.forEach((index) {
      if (index.type == "Book") {
        var books = index.map;
        if(books?[books.length - 1].id == -10) books?.removeAt(books.length - 1);
        if(index.map?.length == 0) nullCheck.add(index);
      }
    });
    if (nullCheck.length != 0) {
      print("널체크");
      bookMap.value.bookMapIndex?.removeWhere( (index) => nullCheck.contains(index));
    }
    // bookMap.update;
  }

}
