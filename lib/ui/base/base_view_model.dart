import 'package:flutter/material.dart';

class BaseViewModel extends ChangeNotifier {
  //get `BuildContext`
  BuildContext? _appContext = GlobalKey<ScaffoldState>().currentContext;
  BuildContext? get appContext => _appContext;

  set appContext(BuildContext? ctx) {
    _appContext = ctx;
    notifyListeners();
  }

  bool _isLoading = false;
  bool disposed = false;

  bool get isLoading => _isLoading;
  set isLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  void setLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  @override
  void dispose() {
    disposed = true;
    super.dispose();
  }

  @override
  void notifyListeners() {
    if (!disposed) {
      super.notifyListeners();
    }
  }
}
