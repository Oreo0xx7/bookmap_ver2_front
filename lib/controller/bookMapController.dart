import 'package:bookmap_ver2/controller/loginController.dart';
import 'package:bookmap_ver2/model/bookMapModel.dart';
import 'package:get/get.dart';

class BookMapController extends GetxController{
  LoginController loginController = Get.find<LoginController>();

  var bookMaps = <BookMapModel>[].obs;
  var myBookMaps = <BookMapModel>[].obs;
  var newBookMap = <BookMapModel>[].obs;
  @override
  void onInit(){
    super.onInit();
    fetchData();
  }

  void fetchData() async{
    await Future.delayed(Duration(seconds: 3));
    var bookMapData = [
      BookMapModel(
          mapName: '우리 몸을 위한 의학 지식', img: 'https://image.yes24.com/goods/73420470/XL',
          makerName: '튼튼이', makerEmail: 'healthZzang@gmail.com', sort: 3),
      BookMapModel(
          mapName: '아름다운 국내 여행지', img: 'https://image.yes24.com/goods/119696406/XL',
          makerName: '구름', makerEmail: 'travelZzang@gmail.com', sort: 3),
      BookMapModel(
          mapName: '삶을 돌아보는 시간', img: 'https://image.yes24.com/goods/118104953/XL',
          makerName: '후라이', makerEmail: 'eggZzang@gmail.com', sort: 3)
    ];
    bookMaps.assignAll(bookMapData);
    var myBookMapData = [
      BookMapModel(mapName: '화성학 공부', img: 'https://image.yes24.com/momo/TopCate1087/MidCate003/108628791.jpg',
          makerName: '오다빈', makerEmail: 'thankfulalways1127@gmail.com', sort: 1),
      BookMapModel(mapName: '몽글몽글 힐링 타임', img: 'https://image.yes24.com/goods/122337842/XL',
          makerName: '오다빈', makerEmail: 'thankfulalways1127@gmail.com', sort: 1),
      BookMapModel(mapName: '내 꿈은 세계일주', img: 'https://image.yes24.com/goods/122189184/XL',
          makerName: '오다빈', makerEmail: 'thankfulalways1127@gmail.com', sort: 1),
      BookMapModel(
          mapName: '우리 몸을 위한 의학 지식', img: 'https://image.yes24.com/goods/73420470/XL',
          makerName: '튼튼이', makerEmail: 'healthZzang@gmail.com', sort: 2),
      BookMapModel(
          mapName: '아름다운 국내 여행지', img: 'https://image.yes24.com/goods/119696406/XL',
          makerName: '구름', makerEmail: 'travelZzang@gmail.com', sort: 2),
      BookMapModel(
          mapName: '삶을 돌아보는 시간', img: 'https://image.yes24.com/goods/118104953/XL',
          makerName: '후라이', makerEmail: 'eggZzang@gmail.com', sort: 2)
    ];
    myBookMaps.assignAll(myBookMapData);

    var newBookMapData = BookMapModel(mapName: newBookMap.value[0].mapName,
        img: 'src/sampleBook.jpg', makerName: loginController.googleAccount.value!.displayName.toString(), makerEmail: loginController.googleAccount.value!.email.toString(), sort: 1);
    newBookMap.assign(newBookMapData);
    myBookMaps.add(newBookMapData);

  }
}