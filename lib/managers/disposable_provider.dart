import 'package:flutter/foundation.dart';

abstract class DisposableProvider extends ChangeNotifier {
  void disposeValues();
}
