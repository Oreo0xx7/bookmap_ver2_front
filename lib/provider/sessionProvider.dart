import 'package:flutter/foundation.dart';

class SessionProvider with ChangeNotifier {
  String? _sessionId;

  String? get sessionId => _sessionId;

  void setSessionId(String sessionId) {
    _sessionId = sessionId;
    notifyListeners(); // 상태가 변경될 때 리스너들에게 알림
    print("_sessionId: ${_sessionId}");
  }

  // 세션 ID를 읽어올 메서드
  String? getSessionId() {
    return _sessionId;
  }
}
