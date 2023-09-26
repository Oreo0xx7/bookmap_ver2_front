class MemoModel{
  final String isbn;
  final String bookTitle;
  final String userEmail;
  final String userName;
  final String memoTitle;
  final String memo;
  final String bookImg;
  final String bookWriter;
  final int startPage;
  final int endPage;

  MemoModel({
    required this.bookImg,
    required this.bookTitle,
    required this.isbn,
    required this.memoTitle,
    required this.memo,
    required this.userEmail,
    required this.userName,
    required this.bookWriter,
    required this.startPage,
    required this.endPage
});
}