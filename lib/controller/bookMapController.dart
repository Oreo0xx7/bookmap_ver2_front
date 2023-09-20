import 'package:bookmap_ver2/model/bookMapModel.dart';
import 'package:get/get.dart';

class BookMapController extends GetxController{
  var bookMaps = <BookMapModel>[].obs;

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
          makerName: '튼튼이', makerEmail: 'healthZzang@gmail.com'),
      BookMapModel(
          mapName: '아름다운 국내 여행지', img: 'https://image.yes24.com/goods/119696406/XL',
          makerName: '구름', makerEmail: 'travelZzang@gmail.com'),
      BookMapModel(
          mapName: '삶을 돌아보는 시간', img: 'https://image.yes24.com/goods/118104953/XL',
          makerName: '후라이', makerEmail: 'eggZzang@gmail.com')
    ];
    bookMaps.assignAll(bookMapData);
  }
}