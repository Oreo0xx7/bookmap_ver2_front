// 2. 로그인 화면 (로그아웃 상태)
import 'package:bookmap_ver2/view/startView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Scaffold buildLoginButton() {
  return Scaffold(
    backgroundColor: Colors.white,
    body: Column(
      children: [
        const Padding(padding: EdgeInsets.only(top: 200)),
        const Center(
            child: Image(image: AssetImage('src/logo.png'), width: 280)),
        const Padding(padding: EdgeInsets.all(80)),
        ElevatedButton(
          onPressed: () {
            loginController.login();
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

                height: 18,
                width: 18,
                fit: BoxFit.none, //로고 주변 그림자를 없애기 위함
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
    ),
  );
}