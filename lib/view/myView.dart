import 'package:bookmap_ver2/asset.dart';
import 'package:bookmap_ver2/view/startView.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class My extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
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
              padding: const EdgeInsets.only(left: 16, right: 16, top: 10.0, bottom: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  circleInfo('7', '북맵', appColor),
                  circleInfo('54', '완독', appColor),
                  circleInfo('361', '팔로워', appColor.shade200),
                  circleInfo('7', '팔로잉', appColor.shade200),
                ],
              ),
            ),
            const Divider(thickness: 1,),

            //d. 독서 기록 (달력, 메모) -> 가능하면 아이콘 추가해보기
            Padding(padding: EdgeInsets.only(top: 12, left: 16, right: 16, bottom: 5),
            child: Text("독서 기록", style: TextStyle(fontFamily: 'Pretendard',
                fontWeight: FontWeight.bold, fontSize: 16,
            color: appColor.shade800),),
            ),
            myButtons("독서 달력", 0),
            myButtons('독서 메모', 1),
            const Divider(thickness: 1,),

            //e. 설정(프로필 편집, 독서기록 내보내기, 로그아웃)
            Padding(padding: EdgeInsets.only(top: 10, left: 16, right: 16, bottom: 5),
              child: Text("설정", style: TextStyle(fontFamily: 'Pretendard',
                  fontWeight: FontWeight.bold, fontSize: 16,
                  color: appColor.shade800),),
            ),
            myButtons("프로필 편집", 2),
            myButtons('독서 기록 내보내기', 3),
            TextButton(onPressed: (){
              loginController.logout();
            },
                child: Text("로그아웃",
                    style: TextStyle(color: Colors.black, fontFamily: 'Pretendard',
                        fontWeight: FontWeight.normal, fontSize: 18)),
                style: TextButton.styleFrom(
                    foregroundColor: appColor.shade600,
                    alignment: Alignment.centerLeft,
                    minimumSize: Size.fromHeight(50),
                    padding: EdgeInsets.only(left: 16)
                )
            ),
            const Divider(thickness: 1,),

            //f. 도움말(문의, 공지사항, 개발자 소개, 서비스 이용약관)
            Padding(padding: EdgeInsets.only(top: 10, left: 16, right: 16, bottom: 5),
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
                '${loginController.googleAccount.value?.photoUrl}',
            ),
          ),
        ),
        //Row 내부 2. 사용자 이름과 id
        Expanded(
          flex: 7,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${loginController.googleAccount.value?.displayName}',
                style: TextStyle(color: Colors.black, fontFamily: 'Pretendard', fontWeight: FontWeight.bold, fontSize: 20),),
              Text('상태메시지 테스트 입니다.',
                style: TextStyle(color: Colors.black38, fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w500, fontSize: 16,),
              )
            ],
          ),
        )
      ],
    ),
  );
}

Container circleInfo(String a, String b, Color c){
  return Container(
    width: 60.0,
    height: 60.0,
    decoration: BoxDecoration(
      border: Border.all(color: c, width: 1.5),
      shape: BoxShape.circle,
    ),
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
  return TextButton(onPressed: (){
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