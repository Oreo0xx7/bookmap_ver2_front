import 'package:bookmap_ver2/data/searchServices.dart';
import 'package:bookmap_ver2/model/mainViewModel.dart';
import 'package:get/get.dart';

class MainController extends GetxController{
  var mainData = Rxn<MainViewModel>();

  @override
  void onInit() {
    super.onInit();
    fetchData();
    //네트워크 요구
  }

  void fetchData() async{
    var data = await SearchServices.fetchMainData();
    print("길이: ${data?.bookImageDto.length}");
    mainData.value = data;
  }

}