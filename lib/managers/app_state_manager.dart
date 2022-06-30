import 'package:flutter/services.dart';
import 'package:popular_people_app/managers/disposable_provider.dart';

class AppStateManager extends DisposableProvider {
  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;
  set isInitialized(bool v) {
    _isInitialized = v;
    notifyListeners();
  }

  @override
  void disposeValues() {
    _isInitialized = false;
    notifyListeners();
    SystemNavigator.pop();
  }

  void closeApp() {
    _isInitialized = false;
    notifyListeners();
  }
}
