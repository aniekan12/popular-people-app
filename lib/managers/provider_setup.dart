import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
  ...uiConsumableProviders,
  ...independentServices,
  ...dependentServices
];

List<SingleChildWidget> independentServices = [];
List<SingleChildWidget> dependentServices = [];
List<SingleChildWidget> uiConsumableProviders = [];
