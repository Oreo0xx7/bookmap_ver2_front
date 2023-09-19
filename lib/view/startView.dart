import 'package:bookmap_ver2/asset.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../controller/loginController.dart';
import 'loginView.dart'; // 로그인 화면
import 'mainView.dart'; // 로그인 후 실행 화면

final loginController = Get.put(LoginController());
//Get.put: Controller의 instance를 외부에서 사용될 수 있도록 메모리에 저장하는 것

// 로그인 및 메인 화면
void main() => runApp(MyApp());
final GoogleSignIn googleSignIn = GoogleSignIn();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login',
      home: Login(),
    );
  }
}

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String _msg = "";
  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: ()async{
        setState(() {
          _msg = "d";
        });

        final set = await showDialog<bool>
          (context: context, builder: (BuildContext context){
          return AlertDialog(
              title: const Text("앱 종료"),
              content: const Text("종료하시겠습니까?"),
              actions: <Widget>[
                TextButton(onPressed: (){
                  Navigator.of(context).pop(false);
                },
                  child:Text("취소", style: TextStyle(color: appColor.shade900),),
                ),
                TextButton(onPressed: (){
                  Navigator.of(context).pop(true);
                }, child:Text("종료", style: TextStyle(color: appColor.shade700)))
              ]);
        }
        );
        print(set);
        return set == true;
      },
      child: Scaffold(
          body: Obx((){
            if(loginController.googleAccount.value == null) {
              // 로그아웃 상태
              return buildLoginButton();
            } else{
              // 로그인 상태
              return buildFutureBuilder();
            }
          })
      ),
    );
  }
}

Builder buildFutureBuilder() {
  return Builder(builder: (BuildContext context) {
    if (loginController.googleAccount.value == null){
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Center(child: CircularProgressIndicator(color: Colors.green,)),
        ],
      );
    }
    else{
      return buildMainView();
    }
  },);
}

MainView buildMainView() {
  if(loginController.googleFormerUser.value == true){
    print("기존 회원");
  }
  else{
    print("새로운 회원");
  }
  return MainView();
}