import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController extends GetxController{
  var _googleSignin = GoogleSignIn();
  var googleAccount = Rx<GoogleSignInAccount?>(null);
  var googleAuthentication = Rx<GoogleSignInAuthentication?>(null);
  login() async{
    googleAccount.value = await _googleSignin.signIn();
    googleAuthentication.value = await googleAccount.value!.authentication;
  }

  logout() async{
    googleAccount.value = await _googleSignin.signOut();
  }
}