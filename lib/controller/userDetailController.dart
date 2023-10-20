import 'package:bookmap_ver2/data/searchServices.dart';
import 'package:bookmap_ver2/model/userProfileModel.dart';
import 'package:bookmap_ver2/view/startView.dart';
import 'package:get/get.dart';

class UserDetailController extends GetxController{

  var profileDetail = UserProfileModel(picture: "", nickName: "", userId: 0, status: "", userBookMapResponseDto: []).obs;

  @override
  void onInit() {
    super.onInit();
    //네트워크 요구
  }

  Future<void> fetchData(id) async{
    var data = await SearchServices.fetchSearchProfile(loginController.sessionId, id);
    if(data != null){
      profileDetail.value = data;
    }
  }

}