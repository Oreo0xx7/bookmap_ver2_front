import 'dart:ui';

import 'package:bookmap_ver2/controller/bookMapController.dart';
import 'package:bookmap_ver2/controller/loginController.dart';
import 'package:bookmap_ver2/model/bookMapModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../asset.dart';

class MakeBookMapView extends StatelessWidget {
  final LoginController loginController = Get.find<LoginController>();
  TextEditingController textEditingController = TextEditingController();
  BookMapController bookMapController = Get.find<BookMapController>();
  var bookMapKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.0, // 그림자 없애기
        backgroundColor: Colors.white,
        title: Text("북맵 만들기",
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
        key: bookMapKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  renderTextFormField(
                      label: '북맵 이름',
                      onSaved: (val){
                        bookMapController.newBookMap.value!.mapName = val;
                        bookMapController.newBookMap.value!.makerName = loginController.googleAccount.value!.displayName!;
                        bookMapController.newBookMap.value!.makerEmail = loginController.googleAccount.value!.email;
                        },
                      onChanged: (val){},
                      validator: (val){
                        if(val.length < 1){
                          return '북맵 이름을 작성해주세요.';
                        }
                        return null;
                      },

                      ),
                  renderTextFormField(label: '북맵 소개글', onSaved: (val){
                    bookMapController.newBookMap.value!.description = val;
                  }, validator: (val){return null;}, onChanged: (val){}),
                  renderTextFormField(label: '키워드', onSaved: (val){
                    bookMapController.newBookMap.value!.keyword = val;
                  }, validator: (val){return null;}, onChanged: (val){}),
                  const Padding(padding: EdgeInsets.only(bottom: 30)),
                  renderButton()
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
      if(bookMapKey.currentState!.validate()){
        Get.snackbar('저장완료', '북맵이 만들어졌어요!', backgroundColor: appColor.shade300,
          duration: const Duration(seconds: 1));
        bookMapKey.currentState!.save();
        bookMapController.myBookMaps.add(bookMapController.newBookMap.value.toString() as BookMapModel);
      }
    },
        style: ButtonStyle(
            fixedSize: MaterialStateProperty.all(Size(100, 60)),
            backgroundColor: MaterialStateProperty.all(appColor)),
        child: Text("저장",
            style: TextStyle(fontFamily: 'Pretendard', fontSize: 20, fontWeight: FontWeight.w700, color: appColor.shade900)));
  }

}
