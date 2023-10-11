import 'package:bookmap_ver2/data/searchServices.dart';
import 'package:bookmap_ver2/model/mainViewModel.dart';
import 'package:bookmap_ver2/view/startView.dart';
import 'package:get/get.dart';


class MainController extends GetxController{
  // var mainData = Rxn<MainViewModel>();
  var mainData = MainViewModel(bookImageDto: [], bookMapResponseDtos: [], bookTopResponseDtos: []).obs;


  @override
  void onInit() {
    super.onInit();
    fetchData();
    //네트워크 요구
  }

  Future<void> fetchData() async{
    print("mainView's sessionId: ${loginController.sessionId}");
    var data = await SearchServices.fetchMainData(loginController.sessionId);
    print("길이: ${data?.bookImageDto.length}");
    if(data != null){
      mainData.value = data;
    }
  }

}