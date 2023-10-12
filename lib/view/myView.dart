import 'package:bookmap_ver2/asset.dart';
import 'package:bookmap_ver2/controller/memoController.dart';
import 'package:bookmap_ver2/controller/profileController.dart';
import 'package:bookmap_ver2/view/editProfileView.dart';
import 'package:bookmap_ver2/view/exportDataView.dart';
import 'package:bookmap_ver2/view/myViewMemoPreview.dart';
import 'package:bookmap_ver2/view/serviceInfoView.dart';
import 'package:bookmap_ver2/view/startView.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'BookDetailView.dart';
import 'calendarView.dart';
import 'developerInfoView.dart';
import 'memoVew.dart';
import 'noticeView.dart';

class My extends StatelessWidget{
  MemoController memoController = Get.put(MemoController());
  final profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    profileController.fetchData();
    return NotificationListener(
      // scroll 시 생기는 glow 없애기 위함
      onNotification: (OverscrollIndicatorNotification overscroll) {
        overscroll.disallowIndicator();
        return true;
      },
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            userBasicInfo(), //a. 사용자 정보

            //b. 사용자 수치 데이터 - 북맵, 완독, 팔로워, 팔로잉
            Padding(
              padding: const EdgeInsets.only(top: 16.0, bottom: 16.0, left: 16.0, right: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${profileController.userData.value.nickName}',
                    style: TextStyle(color: Colors.black, fontFamily: 'Pretendard', fontWeight: FontWeight.bold, fontSize: 20),),
                  Padding(padding: EdgeInsets.all(5)),
                  Text(profileController.userData.value.status != '' ? profileController.userData.value.status : '상태메시지를 입력해주세요.',
                    style: TextStyle(color: Colors.black38, fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w500, fontSize: 16,),
                  )
                ],
              ),
            ),
            const Divider(thickness: 1,),

            //d. 독서 기록 (달력, 메모) -> 가능하면 아이콘 추가해보기
            Padding(padding: const EdgeInsets.only(top: 12, left: 16, right: 16, bottom: 5),
            child: Text("독서 기록", style: TextStyle(fontFamily: 'Pretendard',
                fontWeight: FontWeight.bold, fontSize: 16,
            color: appColor.shade800),),
            ),
            myButtons("독서 달력", 0),
            myButtons('독서 메모', 1),
            memoPreview(),

            //e. 설정(프로필 편집, 독서기록 내보내기, 로그아웃)
            Padding(padding: const EdgeInsets.only(top: 11, left: 16, right: 16, bottom: 5),
              child: Text("설정", style: TextStyle(fontFamily: 'Pretendard',
                  fontWeight: FontWeight.bold, fontSize: 16,
                  color: appColor.shade800),),
            ),
            myButtons("프로필 편집", 2),
            myButtons('독서 기록 내보내기', 3),
            TextButton(onPressed: (){
              loginController.logout();
            },
                style: TextButton.styleFrom(
                    foregroundColor: appColor.shade600,
                    alignment: Alignment.centerLeft,
                    minimumSize: Size.fromHeight(50),
                    padding: EdgeInsets.only(left: 16)
                ),
                child: const Text("로그아웃",
                    style: TextStyle(color: Colors.black, fontFamily: 'Pretendard',
                        fontWeight: FontWeight.normal, fontSize: 18))
            ),
            const Divider(thickness: 1,),

            //f. 도움말(문의, 공지사항, 개발자 소개, 서비스 이용약관)
            Padding(padding: const EdgeInsets.only(top: 10, left: 16, right: 16, bottom: 5),
              child: Text("도움말", style: TextStyle(fontFamily: 'Pretendard',
                  fontWeight: FontWeight.bold, fontSize: 16,
                  color: appColor.shade800),),
            ),
            myButtons('공지사항', 4),
            myButtons('개발자 소개', 5),
            myButtons('서비스 이용 약관', 6),
          ],
        ),
      ),
    );
  }

  Container memoPreview() {
    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 10),
      color: appColor.shade300,
      child: Obx(() =>
          ListView.builder(
            shrinkWrap: true,
              itemCount: profileController.userData.value.profileMemoResponseDtos.length,
            itemBuilder: (context, index){
              return GestureDetector(
                onTap: (){
                  Get.to(
                          () => ChangeNotifierProvider(
                          create: (_) => BookProvider(),
                          child: BookDetailView()),
                      arguments: profileController.userData.value.profileMemoResponseDtos[index].isbn);
                },
                  child: MyViewMemoPreview(profileController.userData.value.profileMemoResponseDtos[index]));
            },
          )
      )
      // Column(

              // children: [
        //       Card(
        //         shape: RoundedRectangleBorder(
        //             borderRadius: BorderRadius.circular(16)
        //         ),
        //         elevation: 8,
        //       surfaceTintColor: appColor,
        //       margin: const EdgeInsets.only(left: 12, right: 12),
        //       child: Padding(
        //         padding: const EdgeInsets.all(16),
        //         child: Column(
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //           children: [
        //             Row(
        //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //               children: [
        //                 Expanded(
        //                     flex: 3,
        //                     child: Image.network(memoController.memos[0].bookImg, )),
        //                 const Spacer(
        //                   flex: 1,
        //                 ),
        //                 Expanded(
        //                   flex: 11,
        //                   child: Column(
        //                     crossAxisAlignment: CrossAxisAlignment.start,
        //                     children: [
        //                       Text(memoController.memos[0].bookTitle, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'Pretendard'),),
        //                       Text(memoController.memos[0].bookWriter, style: const TextStyle(fontSize: 13, fontFamily: 'Pretendard'),),
        //                       const Padding(padding: EdgeInsets.only(bottom: 10)),
        //                       Text('${memoController.memos[0].startPage}~${memoController.memos[0].endPage}쪽을 읽고', style: TextStyle(fontSize: 13, fontFamily: 'Pretendard'),)
        //                     ],
        //                   ),
        //                 ),
        //               ],
        //             ),
        //             const Padding(padding: EdgeInsets.only(bottom: 20)),
        //             Text(memoController.memos[0].memoTitle, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'Pretendard'),),
        //             Text(memoController.memos[0].memo.replaceRange(30, memoController.memos[0].memo.length, "..."), style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, fontFamily: 'Pretendard'),),
        //             //메모가 30자 미만인 경우의 처리가 필요함
        //           ],
        //         ),
        //       ),
        //     ),
        // Card(
        //   shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.circular(16)
        //   ),
        //   elevation: 8,
        //   surfaceTintColor: appColor,
        //   margin: const EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 10),
        //   child: Padding(
        //     padding: const EdgeInsets.all(16),
        //     child: Column(
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //       children: [
        //         Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //           children: [
        //             Expanded(
        //                 flex: 3,
        //                 child: Image.network(memoController.memos[1].bookImg, )),
        //             const Spacer(
        //               flex: 1,
        //             ),
        //             Expanded(
        //               flex: 11,
        //               child: Column(
        //                 crossAxisAlignment: CrossAxisAlignment.start,
        //                 children: [
        //                   Text(memoController.memos[1].bookTitle, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'Pretendard'),),
        //                   Text(memoController.memos[1].bookWriter, style: const TextStyle(fontSize: 13, fontFamily: 'Pretendard'),),
        //                   const Padding(padding: EdgeInsets.only(bottom: 10)),
        //                   Text('${memoController.memos[1].startPage}~${memoController.memos[1].endPage}쪽을 읽고', style: TextStyle(fontSize: 13, fontFamily: 'Pretendard'),)
        //                 ],
        //               ),
        //             ),
        //           ],
        //         ),
        //         Padding(padding: EdgeInsets.only(bottom: 20)),
        //         Text('${memoController.memos[1].memoTitle}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'Pretendard'),),
        //         Text('${memoController.memos[1].memo.replaceRange(30, memoController.memos[1].memo.length, "...")}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, fontFamily: 'Pretendard'),),
        //       ],
        //     ),
        //   ),
        // )
        //       ],
        //     ),
    );
  }
  Padding userBasicInfo(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          //Row 내부 1. 프로필 이미지
          Expanded(
            flex: 2,
            child: CircleAvatar(
              radius: 30,
              backgroundColor: appColor,
              backgroundImage: NetworkImage(
                profileController.userData.value.image
              ),
            ),
          ),
          //Row 내부 2. 사용자 이름과 id
          Expanded(
            flex: 7,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                circleInfo('${profileController.userData.value.bookmapCount}', '북맵', appColor),
                circleInfo('${profileController.userData.value.readBooksCount}', '완독', appColor),
                //circleInfo('361', '팔로워', appColor.shade200),
                // circleInfo('7', '팔로잉', appColor.shade200),
              ],
            ),
          )
        ],
      ),
    );
  }
}



Container circleInfo(String a, String b, Color c){
  return Container(
    width: 60.0,
    height: 60.0,
    // decoration: BoxDecoration(
    //   border: Border.all(color: c, width: 1.5),
    //   shape: BoxShape.circle,
    // ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(a, style: TextStyle(fontFamily: 'Pretendard', fontSize: 18, fontWeight: FontWeight.bold),),
        Text(b, style: TextStyle(fontFamily: 'Pretendard', fontSize: 16, fontWeight: FontWeight.w200),)
      ],
    ),
  );
}

TextButton myButtons(String title, int a){
  //각 페이지를 배열로 저장하여 a인덱스인 것 반환하기!
  List<Widget> pages = [CalendarView(), MemoView(), EditProfileView(), ExportDataView(), NoticeView(), DeveloperInfoView(), ServiceInfoView()];
  return TextButton(onPressed: (){
    Get.to(pages[a]);
  },
      child: Text(title,
          style: TextStyle(color: Colors.black, fontFamily: 'Pretendard',
              fontWeight: FontWeight.normal, fontSize: 18)),
      style: TextButton.styleFrom(
          foregroundColor: appColor.shade600,
          alignment: Alignment.centerLeft,
          minimumSize: Size.fromHeight(50),
          padding: EdgeInsets.only(left: 16)
      )
  );
}