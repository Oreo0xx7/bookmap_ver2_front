import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ProfileDetailView extends StatelessWidget {

  var id = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("${id}"),
      ),
    );
  }
}
