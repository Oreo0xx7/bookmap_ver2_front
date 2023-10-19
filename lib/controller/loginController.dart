

import 'package:bookmap_ver2/api_key.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/io_client.dart';
import 'package:bookmap_ver2/api_key.dart';

final String server = url;

class LoginController extends GetxController{
  String idToken ="";
   var _googleSignin = GoogleSignIn(
      serverClientId: '205578501902-2g0aj7mkvmtbpqdcjqt86nhc64euj7l0.apps.googleusercontent.com',
  );

  var googleAccount = Rx<GoogleSignInAccount?>(null);
  var googleAuthentication = Rx<GoogleSignInAuthentication?>(null);
  var googleFormerUser = Rx<GoogleSignInAccount?>(null);

  var sessionId = ''.obs;

  //final sessionProvider = SessionProvider();

  login() async{
    googleFormerUser.value = await _googleSignin.signInSilently();
    googleAccount.value = await _googleSignin.signIn();
    if (googleAccount.value != null){
      googleAuthentication.value = await googleAccount.value!.authentication;
      idToken = googleAuthentication.value?.idToken ?? "";
      sendIdTokenToServer(idToken);
      print("login()안의 $sessionId");
    }
  }

  logout() async{
    googleAccount.value = await _googleSignin.signOut();
  }

  Future<String> sendIdTokenToServer(String idToken) async{
    print(idToken.toString());
    final httpClient = IOClient();

    final response = await httpClient.post(
      Uri.parse('$server/login'),
      headers: <String, String>{
        'idToken': idToken.toString(),
      },
      body: idToken.toString(),
    );
    print(response.body);
    try {

      sessionId.value = response.body.toString();
      print("세션 Id: $sessionId");
    } catch (e) {
    print("JSON 디코딩 오류: $e");
    }
    httpClient.close();
    return response.body.toString();
  }
}

// //IdToken 전달
// Future<String> postIdToken(String idToken) async{
//   print(idToken);
//   final httpClient = IOClient();
//   final response = await httpClient.post(
//     Uri.parse('$server'),
//     headers: <String, String>{
//       'idToken': idToken,
//     },
//     body: jsonEncode(<String, String>{
//       'idToken': idToken,
//     }),
//   ).then((value){
//     print(value);
//   });
//
//   print("check!!");
//   httpClient.close();
//   return response.body;
// }