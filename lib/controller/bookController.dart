import 'package:get/get.dart';
import '../model/libraryModel.dart';

class BookController extends GetxController {
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
        writer: 'writer1',
        img: 'src/sampleBook.jpg',
        isbn: 'sampleISBN',
        sort: 1,
        start: '2023-09-01',
        end: '2023-09-11',
        like: false
      ),
      LibraryModel(
          bookName: 'Book2',
          writer: 'writer2',
          img: 'src/sampleBook.jpg',
          isbn: 'sampleISBN',
          sort: 1,
          start: '2023-09-01',
          end: '2023-09-11',
        like: false
      ),
      LibraryModel(
          bookName: 'Book3',
          writer: 'writer3',
          img: 'src/sampleBook.jpg',
          isbn: 'sampleISBN',
          sort: 1,
          start: '2023-09-01',
          end: '2023-09-11',
        like: false
      ),
      LibraryModel(
          bookName: 'Book4',
          writer: 'writer4',
          img: 'src/sampleBook.jpg',
          isbn: 'sampleISBN',
          sort: 1,
          start: '2023-09-01',
          end: '2023-09-11',
        like: false
      ),
      LibraryModel(
          bookName: 'Book5',
          writer: 'writer5',
          img: 'src/sampleBook.jpg',
          isbn: 'sampleISBN',
          sort: 1,
          start: '2023-09-01',
          end: '2023-09-11',
        like: false
      )
    ];
    
    books.assignAll(booksData); //assignAll은 RxList내부에 있는 메소드 -> 값 업데이트를 위함
  }
}