import 'package:flutter/services.dart';
import 'package:popular_people_app/helpers/endpoints/endpoints.dart';
import 'package:popular_people_app/helpers/http/api_helper.dart';
import 'package:popular_people_app/managers/disposable_provider.dart';
import 'package:popular_people_app/models/popular_people_model.dart';
import 'package:popular_people_app/vault/vault.dart';

class AppStateManager extends DisposableProvider {
  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;
  set isInitialized(bool v) {
    _isInitialized = v;
    notifyListeners();
  }

  String _transactionError = '';
  String get transactionError => _transactionError;
  set transactionError(String transactionError) {
    _transactionError = transactionError;
    notifyListeners();
  }

  int _totalNumberOfPeople = 0;
  int get totalNumberOfPeople => _totalNumberOfPeople;
  set totalNumberOfPeople(int numberOfPeople) {
    _totalNumberOfPeople = numberOfPeople;
    notifyListeners();
  }

  List<PopularPeopleModel> _popularPeople = [];
  List<PopularPeopleModel> get popularPeople => _popularPeople;
  set popularPeople(List<PopularPeopleModel> popularpeople) {
    _popularPeople = popularpeople;
    notifyListeners();
  }

  List<PopularPeopleModel> _currentPopularPeople = [];
  List<PopularPeopleModel> get currentPopularPeople => _currentPopularPeople;
  set currentPopularPeople(List<PopularPeopleModel> popularpeople) {
    _currentPopularPeople = popularpeople;
    notifyListeners();
  }

  Future<bool> fetchPopularPeople({int page = 1}) async {
    String param =
        '/3/person/popular?api_key=$apiKey&language=en-US&page=$page';

    String url = Endpoints.fetchPopularPeople + param;
    Map resp = await ApiHelpers.makeGetRequest(url, headers: {});
    if (resp['page'].isNotEmpty) {
      if (page == 1) {
        _totalNumberOfPeople = 0;
      }
      if (resp['results'].isNotEmpty) {
        List<PopularPeopleModel> ourPopularPeople = resp['results']
            .map<PopularPeopleModel>((e) => PopularPeopleModel.fromJson(e))
            .toList();
        _totalNumberOfPeople = resp['results']['total_results'];
        _currentPopularPeople = ourPopularPeople;
        if (page > 1) {
          _popularPeople.addAll(ourPopularPeople);
        } else {
          _popularPeople = ourPopularPeople;
        }
        notifyListeners();
      } else {
        if (_totalNumberOfPeople == 0) {
          _popularPeople = [];
          _currentPopularPeople = [];
        }
      }
    } else {
      _transactionError =
          resp['status_message'] ?? 'Error fetching popular people';
    }
    return resp['status_message'];
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
