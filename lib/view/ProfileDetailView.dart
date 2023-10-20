import 'package:bookmap_ver2/controller/userDetailController.dart';
import 'package:bookmap_ver2/view/profileDetailBookMapView.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../asset.dart';
import 'bookMapDetailInSearchView.dart';

class ProfileDetailView extends StatelessWidget {
  var id = Get.arguments;
  final userDetailController = Get.put(UserDetailController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 1,
        backgroundColor: Colors.white,
        title: Obx(() => Text(
              '${userDetailController.profileDetail.value.nickName}님의 프로필',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontFamily: 'Pretendard', color: Colors.black, fontSize: 15),
            )),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
          children: [
        Padding(
            padding: const EdgeInsets.all(12.0),
            child:userBasicInfo()),
        Obx(() => ListView.builder(

          shrinkWrap: true,
          itemCount: userDetailController.profileDetail.value.userBookMapResponseDto.length,
          itemBuilder: (context, index){
            return GestureDetector(
                onTap: () {
                  Get.to(() => BookMapDetailInSearchView(), arguments: userDetailController.profileDetail.value.userBookMapResponseDto[index].bookMapId);
                },
                child: ProfileDetailBookMapDetailView(userDetailController.profileDetail.value.userBookMapResponseDto[index]));
          },
        ))
      ]),
    );
  }

  Container userBasicInfo() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //Row 내부 1. 프로필 이미지
          Obx(
            () => CircleAvatar(
              radius: 30,
              backgroundColor: appColor,
              backgroundImage: NetworkImage(
                  userDetailController.profileDetail.value.picture),
            ),
          ),
          //Row 내부 2. 사용자 이름과 id
          Padding(
            padding: const EdgeInsets.only(
                top: 16.0, bottom: 16.0, left: 16.0, right: 16.0),
            child: Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '${userDetailController.profileDetail.value.nickName}',
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  Padding(padding: EdgeInsets.all(5)),
                  Text(
                    userDetailController.profileDetail.value.status != ''
                        ? userDetailController.profileDetail.value.status
                        : '',
                    style: TextStyle(
                      color: Colors.black38,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
