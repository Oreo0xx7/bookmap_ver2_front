import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'login_controller.dart';

void main() => runApp(MyApp());
final GoogleSignIn googleSignIn = GoogleSignIn();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
  final controller = Get.put(LoginController());
  //Get.put: Controller의 instance를 외부에서 사용될 수 있도록 메모리에 저장하는 것
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Obx((){
            if(controller.googleAccount.value == null) {
              // 로그아웃 상태
              return buildLoginButton();
            } else {
              // 로그인 상태
              return buildProfileView();
            }
          }),
        ],
      ),
    );
  }

  Column buildLoginButton() {
    return Column(
      children: [
        const Padding(padding: EdgeInsets.only(top: 150)),
        const Center(
            child: Image(image: AssetImage('src/logo.png'), width: 280)),
        const Padding(padding: EdgeInsets.all(80)),
        ElevatedButton(
          onPressed: () {
            controller.login();
          },
          style: ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsets>(
                  const EdgeInsets.all(0)),
              backgroundColor:
              MaterialStateProperty.all<Color>(Colors.white)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Padding(padding: EdgeInsets.all(8)),
              Image.asset(
                'src/btn_google_light.png',
                height: 20,
                width: 20,
                fit: BoxFit.cover,
              ),
              const Padding(padding: EdgeInsets.all(24)),
              const Text('Google 계정으로 로그인',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 14,
                      color: Colors.black54)),
              const Padding(padding: EdgeInsets.all(8)),
            ],
          ),
        ),
      ],
    );
  }
  Column buildProfileView() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Padding(padding: EdgeInsets.only(top: 150)),
        Center(
          child: CircleAvatar(
            backgroundImage: Image.network(controller.googleAccount.value?.photoUrl ?? '').image,
            radius: 100,
          ),
        ),
        const Padding(padding: EdgeInsets.only(top: 20)),
        Text(controller.googleAccount.value?.displayName ?? '',
          style: Get.textTheme.headlineMedium,),
        Text(controller.googleAccount.value?.email ?? '',
          style: Get.textTheme.headlineMedium,),
        const Padding(padding: EdgeInsets.all(20)),
        Text(controller.googleAuthentication.value?.accessToken ?? ''),
        const Padding(padding: EdgeInsets.all(60)),
        ActionChip(
            avatar: const Icon(Icons.logout),
            label: const Text("Logout"),
            onPressed: (){
              controller.logout();
            })
      ],
    );
  }

}
