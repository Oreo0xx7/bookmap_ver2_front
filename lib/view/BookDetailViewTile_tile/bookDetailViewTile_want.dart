import 'package:flutter/material.dart';

class BookDetailViewTileWant extends StatelessWidget {
  const BookDetailViewTileWant({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 70),
      child: Text(
        '읽고 싶은 책으로 저장할까요?',
        style: TextStyle(color: Colors.black, fontSize: 16,),
      ),
    );
  }
}
