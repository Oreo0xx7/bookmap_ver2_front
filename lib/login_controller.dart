import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController extends GetxController{
  var _googleSignin = GoogleSignIn();
  var googleAccount = Rx<GoogleSignInAccount?>(null);
  var googleAuthentication = Rx<GoogleSignInAuthentication?>(null);
  var googleFormerUser = Rx<GoogleSignInAccount?>(null);
  login() async{
    googleFormerUser.value = await _googleSignin.signInSilently();
    googleAccount.value = await _googleSignin.signIn();
    googleAuthentication.value = await googleAccount.value!.authentication;
  }

  logout() async{
    googleAccount.value = await _googleSignin.signOut();
  }
}