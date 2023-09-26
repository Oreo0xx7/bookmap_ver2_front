import 'package:bookmap_ver2/controller/loginController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../asset.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileView extends StatelessWidget {
  final LoginController loginController = Get.find<LoginController>();
  TextEditingController textEditingController = TextEditingController();
  final ImagePicker picker = ImagePicker();
  var userInfoKey = GlobalKey<FormState>();
  late var name = Rx<String>("");
  late var status = Rx<String>("");
  late var imgLink = Rx<String>("");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.0, // 그림자 없애기
        backgroundColor: Colors.white,
        title: Text("프로필 편집",
            textAlign: TextAlign.start,
            style: TextStyle(
                color: appColor.shade800,
                fontSize: 22,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.bold)),
        actions: [IconButton(
            onPressed: (){loginController.logout();},
            icon: Icon(Icons.output_sharp, color: appColor.shade800,))],
      ),
      body: Form(
        key: userInfoKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  renderTextFormField(
                    label: '닉네임',
                    onSaved: (val){
                      name = val;
                    },
                    onChanged: (val){},
                    validator: (val){
                      if(val.length < 1){
                        return '이름을 작성해주세요.';
                      }
                      return null;
                    },

                  ),
                  renderTextFormField(label: '상태메시지', onSaved: (val){
                    status = val;
                  }, validator: (val){return null;}, onChanged: (val){}),
                  //이미지 추가하는 것 해보기
                  Text("프로필 이미지", style: TextStyle(fontFamily: 'Pretendard',
                      fontSize: 20, fontWeight: FontWeight.w500, color: appColor.shade800)),
                  Text("지금 머리가 안돌아가유,,", style: TextStyle(fontFamily: 'Pretendard',
                      fontSize: 14, fontWeight: FontWeight.w500, color: appColor.shade800)),
                  const Padding(padding: EdgeInsets.only(bottom: 60)),
                  Center(
                    child: renderButton(),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  renderTextFormField({
    required String label,
    required FormFieldSetter onSaved,
    required FormFieldSetter onChanged,
    required FormFieldValidator validator,
  }){
    return Column(
      children: [
        Row(children: [
          Text(label, style: TextStyle(fontFamily: 'Pretendard',
              fontSize: 20, fontWeight: FontWeight.w500, color: appColor.shade800),)
        ],),
        Padding(padding: EdgeInsets.only(top:10)),
        TextFormField(
            keyboardType: TextInputType.text,
            onChanged: onChanged,
            onSaved: onSaved,
            validator: validator,
            cursorColor: appColor.shade900,
            decoration: const InputDecoration(
                errorStyle: TextStyle(fontFamily: 'Pretendard', fontSize: 16),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                    borderSide: BorderSide(color: appColor)
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                    borderSide: BorderSide(color: appColor)
                ),
                focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                    borderSide: BorderSide(color: appColor)
                ),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                    borderSide: BorderSide(color: appColor)
                )
            ),
            style: TextStyle(fontFamily: 'Pretendard', fontSize: 20, fontWeight: FontWeight.w700, color: appColor.shade900)
        ),
        const Padding(padding: EdgeInsets.only(bottom: 20))
      ],
    );
  }

  renderButton(){
    return TextButton(
        onPressed: ( ) async{
          if(userInfoKey.currentState!.validate()){
            Get.snackbar('저장완료', '프로필 정보가 수정되었어요!', backgroundColor: appColor.shade300,
                duration: const Duration(seconds: 1));
            userInfoKey.currentState!.save();
            Get.back(); //왜 동작이 안될까..??
            //프로필 정보 저장 관련
            }
        },
        style: ButtonStyle(
            fixedSize: MaterialStateProperty.all(Size(100, 60)),
            backgroundColor: MaterialStateProperty.all(appColor)),
        child: Text("저장",
            style: TextStyle(fontFamily: 'Pretendard', fontSize: 20, fontWeight: FontWeight.w700, color: appColor.shade900)));
  }

}
