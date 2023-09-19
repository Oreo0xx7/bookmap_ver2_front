import 'package:get/get.dart';
String dateStr = '2023-09-11T14:30:00.000Z';
DateTime parsedDate = DateTime.parse(dateStr);

const int sampleInt = 2023;

class LibraryModel{
  final String bookName;
  final String writer;
  final String img;
  final String isbn;
  int sort; // 0: 읽은 책, 1: 읽고 있는 책, 2: 읽고 싶은 책
  int star; // 평점
  DateTime start, end;
  int totalPage;

  LibraryModel({
    required this.bookName,
    required this.writer,
    required this.img, // 없는 경우 기본 값 제공
    required this.isbn,
    required this.sort,
    this.star = 5,
    this.totalPage = 0,
    required String start, //'2023-09-11'
    required String end,
  }): start = DateTime.parse(start),
  end = DateTime.parse(end);
}