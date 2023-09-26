import 'package:bookmap_ver2/controller/loginController.dart';
import 'package:bookmap_ver2/model/memoModel.dart';
import 'package:get/get.dart';

class MemoController extends GetxController{
  LoginController loginController = Get.find<LoginController>();

  var memos = <MemoModel>[].obs;

  @override
  void onInit(){
    super.onInit();
    fetchData();
  }

  void fetchData() async{
    await Future.delayed(Duration(seconds: 3));
 //기록 날짜 추가하기
    var memoData = [
      MemoModel(
          bookImg: 'https://image.yes24.com/goods/99534783/XL',
          bookTitle: '미드나잇 라이브러리', isbn: '0000', memo: '죽어있는 자신의 고양이를 보면서 질투심을 느끼다니...  놀랍기도 하지만 그만큼 주인공은 힘든 삶을 살아왔고, 마음이 너무나 지쳐 있다는 의미일 것이다.',
          userEmail: 'userEmail', userName: 'userName',
          memoTitle: '주인공 노라가 죽기를 결심하기 27시간 전의 모습', bookWriter: '매트 헤이그', startPage: 18, endPage: 27),
      MemoModel(
          bookImg: 'https://image.yes24.com/goods/101317041/XL',
          bookTitle: '소크라테스 익스프레스', isbn: '0000', memo: '열네 명의 철학자들과 잘 어울리는 음악이 소개된 유튜브 채널로 연결되는 QR코드도 있습니다. 음악과 함께하니 읽는 내내 진짜 기차 여행을 하고 있는 듯한 기분이 듭니다. 쉽게 쓰여진 철학책이라고 해서 읽었건만 그것조차 어렵게 느꼈던 분이라면 에세이 읽듯 흘러가는 <소크라테스 익스프레스> 추천합니다.',
          userEmail: 'userEmail', userName: 'userName',
          memoTitle: '에세이 읽듯 쉽게 이해되는 실용적인 철학 여행', bookWriter: '매트 헤이그', startPage: 57, endPage: 60),
      MemoModel(
          bookImg: 'https://image.yes24.com/goods/63038113/XL',
          bookTitle: '방구석 미술관', isbn: '0000', memo: '보는 대로 느끼면 되는 것이 그림이지만, 한편으로는 아는 만큼 보이는 것도 예술이 아닐까 싶습니다. 예전 아무것도 아는 것 없이 샤갈의 눈 내리는 마을이라는 제목으로 하던 전시회를 갔던 기억이 떠오릅니다. 사전 지식 없이 그저 보고 느끼는 것도 나름 괜찮았던 듯 싶습니다. 그래도 편하게 볼 수 있는 이 책을 통해 화가의 삶과 작품세계를 살짝 엿보고 미술관에 가는 것이 좋겠네요. 재미있는 글쓴이의 해설과 함께 한다면 좀 더 화가들과 가까워지고 그림에 친숙해지지 않을까 싶습니다. 그렇게 기본 지식을 쌓고 다시 보이는 대로 마음이 느끼는 대로 그림을 보면 이전과는 또다른 모습으로 그림과 그 그림을 그린 화가의 마음이 다가오겠지요. ',
          userEmail: 'userEmail', userName: 'userName',
          memoTitle: '뜨거운 마음으로 공감하는 미술이 되기를', bookWriter: '조원재', startPage: 25, endPage: 138),
    ];

    memos.assignAll(memoData);

  }
}