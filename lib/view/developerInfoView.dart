import 'package:bookmap_ver2/controller/loginController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../asset.dart';

class DeveloperInfoView extends StatelessWidget {
  final LoginController loginController = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0.0, // 그림자 없애기
          backgroundColor: Colors.white,
          title: Text("개발자 소개",
              textAlign: TextAlign.start,
              style: TextStyle(
                  color: appColor.shade800,
                  fontSize: 22,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.bold)),
          actions: [IconButton(
              onPressed: (){loginController.logout();},
              icon: Icon(Icons.output_sharp, color: appColor.shade800,))],
        ),
        body: Center(
          child: Text("Fentarim", style: TextStyle(
              color: appColor.shade700,
              fontSize: 20,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.bold)),
        )
    );
  }
}
