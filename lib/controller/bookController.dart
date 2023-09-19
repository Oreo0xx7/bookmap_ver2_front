import 'package:get/get.dart';
import '../model/libraryModel.dart';

class BookController extends GetxController {
  //static BookController get to => Get.find();
  var books = <LibraryModel>[].obs;
  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  void fetchData() async{
    await Future.delayed(Duration(seconds: 2));
    var booksData = [
      LibraryModel(
        bookName: '나미야 잡화점의 기적',
        writer: '히가시노 게이고',
        img: 'https://image.yes24.com/goods/8157957/XL',
        isbn: '9791167901484',
        sort: 1,
        start: '2023-08-21',
        end: '2023-09-11',
      ),
      LibraryModel(
          bookName: '바다가 들리는 편의점',
          writer: '마치다 소노코',
          img: 'https://image.yes24.com/goods/118040295/XL',
          isbn: '9791192579504',
          sort: 1, // 읽는 중인
          start: '2023-09-01',
          end: '2023-09-11',
      ),
      LibraryModel(
          bookName: '매일 이곳이 좋아집니다',
          writer: '마스다 미리',
          img: 'https://image.yes24.com/goods/121192160/XL',
          isbn: '9791169518352',
          sort: 0, //읽고 싶은
          start: '2023-09-01',
          end: '2023-09-11',
      ),
      LibraryModel(
          bookName: '푸바오, 매일매일 행복해',
          writer: '에버랜드 동물원',
          img: 'https://image.yes24.com/goods/122337842/XL',
          isbn: '9791171251704',
          sort: 2, // 읽은
          start: '2023-09-01',
          end: '2023-09-11',
      ),
      LibraryModel(
          bookName: '하루 10분, 철학이 필요한 시간',
          writer: '위저쥔',
          img: 'https://image.yes24.com/goods/122284247/XL',
          isbn: '9791141113711',
          sort: 0, // 읽고 싶은
          start: '2023-09-01',
          end: '2023-09-11',
      )
    ];
    
    books.assignAll(booksData); //assignAll은 RxList내부에 있는 메소드 -> 값 업데이트를 위함
  }
}