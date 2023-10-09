import 'package:bookmap_ver2/model/bookMapEditModel.dart';
import 'package:get/get.dart';

class BookMapEditController extends GetxController {
  var bookMap = BookMap().obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  @override
  void onClose(){
    resetData();
    super.onClose();
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

  void addImage() {
    bookMap.value.bookMapIndex?.forEach((index) {
      if (index.type == "Book") {
        var books = index.map;
        if((books!.length <= 3) ? ((books[books.length - 1].id != -10) ? true : false) : false)
          books.add(MapElement(
              id: -10, isbn: '',
              image: 'https://postfiles.pstatic.net/MjAyMzA2MDlfMTUz/MDAxNjg2MzA5MTk2Njc1.e0lBE1zzXGIZIg03GQ6c-J2E6ahezLFCWsZMZWpolYAg.nomA0xkMNBmkhgZ8q84XIbwer4nE9_KxtBojTb_vYTMg.PNG.odb1127/image.png?type=w773'
          ));
      }
    });
  }

  void removeImage() {
    bookMap.value.bookMapIndex?.forEach((index) {
      if (index.type == "Book") {
        var books = index.map;
        if(books?[books.length - 1].id == -10)
          books?.removeAt(books.length - 1);
      }
    });
  }

  void resetData() async {
    await Future.delayed(Duration(seconds: 1));
    var bookMapData =
    BookMap(
        bookMapId: 3,
        bookMapTitle: "테스트입니다",
        bookMapContent: "북맵 관련 설명",
        bookMapImage:
        "https://search1.kakaocdn.net/thumb/R120x174.q85/?fname=http%3A%2F%2Ft1.daumcdn.net%2Flbook%2Fimage%2F1467038%3Ftimestamp%3D20230128141840",
        hashTag: ["해시", "태그"],
        share: true,
        bookMapIndex: [
          BookMapIndex(
            type: "Book",
            map: [
              MapElement(
                  id: 2,
                  isbn: "9791190090261",
                  image:
                  "https://search1.kakaocdn.net/thumb/R120x174.q85/?fname=http%3A%2F%2Ft1.daumcdn.net%2Flbook%2Fimage%2F5446629%3Ftimestamp%3D20230601182053"),
              MapElement(
                  id: 1,
                  isbn: "8996991341",
                  image:
                  "https://search1.kakaocdn.net/thumb/R120x174.q85/?fname=http%3A%2F%2Ft1.daumcdn.net%2Flbook%2Fimage%2F1467038%3Ftimestamp%3D20230128141840"),
            ],
            memo: null,
          ),
          BookMapIndex(type: "Memo", map: null, memo: "메모 확인용"),
          BookMapIndex(
              type: "Book",
              map: [
                MapElement(
                    id: 3,
                    isbn: "9791168473690",
                    image:
                    "https://search1.kakaocdn.net/thumb/R120x174.q85/?fname=http%3A%2F%2Ft1.daumcdn.net%2Flbook%2Fimage%2F6266671%3Ftimestamp%3D20230604141647"),
                MapElement(
                    id: 4,
                    isbn: "9788901272580",
                    image:
                    "https://search1.kakaocdn.net/thumb/R120x174.q85/?fname=http%3A%2F%2Ft1.daumcdn.net%2Flbook%2Fimage%2F6356276%3Ftimestamp%3D20230526190904"),
              ],
              memo: null),
        ]);
    bookMap(bookMapData);
  }

  void fetchData() async {
    await Future.delayed(Duration(seconds: 2));
    var bookMapData =
    BookMap(
        bookMapId: 3,
        bookMapTitle: "테스트입니다",
        bookMapContent: "북맵 관련 설명",
        bookMapImage:
        "https://search1.kakaocdn.net/thumb/R120x174.q85/?fname=http%3A%2F%2Ft1.daumcdn.net%2Flbook%2Fimage%2F1467038%3Ftimestamp%3D20230128141840",
        hashTag: ["해시", "태그"],
        share: true,
        bookMapIndex: [
          BookMapIndex(
            type: "Book",
            map: [
              MapElement(
                  id: 2,
                  isbn: "9791190090261",
                  image:
                  "https://search1.kakaocdn.net/thumb/R120x174.q85/?fname=http%3A%2F%2Ft1.daumcdn.net%2Flbook%2Fimage%2F5446629%3Ftimestamp%3D20230601182053"),
              MapElement(
                  id: 1,
                  isbn: "8996991341",
                  image:
                  "https://search1.kakaocdn.net/thumb/R120x174.q85/?fname=http%3A%2F%2Ft1.daumcdn.net%2Flbook%2Fimage%2F1467038%3Ftimestamp%3D20230128141840"),
            ],
            memo: null,
          ),
          BookMapIndex(type: "Memo", map: null, memo: "메모 확인용"),
          BookMapIndex(
              type: "Book",
              map: [
                MapElement(
                    id: 3,
                    isbn: "9791168473690",
                    image:
                    "https://search1.kakaocdn.net/thumb/R120x174.q85/?fname=http%3A%2F%2Ft1.daumcdn.net%2Flbook%2Fimage%2F6266671%3Ftimestamp%3D20230604141647"),
                MapElement(
                    id: 4,
                    isbn: "9788901272580",
                    image:
                    "https://search1.kakaocdn.net/thumb/R120x174.q85/?fname=http%3A%2F%2Ft1.daumcdn.net%2Flbook%2Fimage%2F6356276%3Ftimestamp%3D20230526190904"),
              ],
              memo: null),
        ]);
    bookMap(bookMapData);
  }
}
