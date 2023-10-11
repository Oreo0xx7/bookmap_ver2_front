import 'package:bookmap_ver2/data/bookPostServices.dart';
import 'package:bookmap_ver2/data/searchServices.dart';
import 'package:bookmap_ver2/model/bookDetailReadPostModel.dart';
import 'package:bookmap_ver2/model/bookDetailReadingPostModel.dart';
import 'package:get/get.dart';

import '../model/bookDetailGetModel.dart';


class BookDetailPopupController extends GetxController{
  var tabs = <bool>[false, false, false].obs;
  var status = ''.obs;
  var isbn = ''.obs;

  var addMemo = BookMemoResponseDto(id: 0, content: '', saved: DateTime.now(), page: 0, title: '').obs;


  var readBook = Rxn<BookDetailReadPostModel>(BookDetailReadPostModel(
    bookState: '읽은',
    startDate: DateTime.now(),
    endDate: DateTime.now(),
    grade: 0.0,
    totalPage: 0,
  ));

  var readingBook = Rxn<BookDetailReadingPostModel>(BookDetailReadingPostModel(
    bookState: '읽는중인',
    startDate: DateTime.now(),
    readingPage: 0,
    totalPage: 0,
  ));




  void toggleTabs(int index){
    for (int i = 0; i <3 ; i++) {tabs[i] = false;}
    tabs[index] = !tabs[index];
  }
  @override
  void onInit() {
    super.onInit();

  }

  void initializeState(String isbn) async {
    final data = await SearchServices.fetchBookDetailGet(isbn);
    print("상태:   " + data!.bookState);
    if( data?.bookState == '읽는중인'){
      //status = '읽는중인' as RxString;
      tabs[1] = true;
      readingBook.value?.startDate = data.startDate!;
      readingBook.value?.readingPage = data.readingPage!;
      readingBook.value?.totalPage = data.totalPage!;
    }else if(data?.bookState == '읽은'){
      //status = '읽은' as RxString;
      tabs[0] = true;
      readBook.value?.totalPage = data.totalPage!;
      readBook.value?.startDate = data.startDate!;
      readBook.value?.grade = data.grade!;
      readBook.value?.endDate = data.endDate!;
    }else{
      //status = '읽고싶은' as RxString;
      tabs[2] = true;
    }
  }

  void fetchData(book, isbn){
    BookPostServices.postBook(book.value, isbn);
  }

  void fetchWantData(isbn){
    BookPostServices.postWantBook(isbn);
  }
  void updateTotalPage(String value){
    final int parsedValue = int.tryParse(value) ?? 0;

    readBook.value?.totalPage = parsedValue;
  }
  void fetchChangedData(book, isbn){
    BookPostServices.postChangeState(book.value, isbn);
  }

  void deleteBook(isbn){
    BookPostServices.deleteStoredBook(isbn);
  }

  void fetchMemoData(title, content, page, isbn){
    BookPostServices.postBookMemoData(title, content, page, isbn);
  }

  void deleteMemo(memoId){
    BookPostServices.deleteMemo(memoId);
  }

  void modify(title, content, page, id){
    BookPostServices.modifyBookMemoData(title, content, page, id);
  }


}