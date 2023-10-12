import 'dart:math';

import 'package:bookmap_ver2/data/profileServices.dart';
import 'package:bookmap_ver2/model/profileViewModel.dart';
import 'package:bookmap_ver2/view/startView.dart';
import 'package:get/get.dart';

import '../model/memoListModel.dart';

class ProfileController extends GetxController{
  var userData = ProfileViewModel(id: 0, nickName: '', status: '', readBooksCount: 0, image: '', profileMemoResponseDtos: [], bookmapCount: 0).obs;

  var memoListData = <MemoListModel>[].obs;

  @override
  void onInit(){
    super.onInit();
    fetchData();
  }
  void fetchData() async{
    var profileData = await ProfileServices.fetchProfile(loginController.sessionId);
    var memoDatas = await ProfileServices.fetchMemoList(loginController.sessionId);
    if(profileData != null){
      userData.value = profileData;
    }
    if(memoDatas != null){
      memoListData.value = memoDatas;
    }
  }
  void modifyData(nickName, status) async{
    ProfileServices.modifyUserData(loginController.sessionId, nickName, status);
  }
}