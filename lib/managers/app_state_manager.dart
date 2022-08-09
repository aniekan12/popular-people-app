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

  PopularPeopleModel? _popularPeopleModel;
  PopularPeopleModel? get popularPeopleModel => _popularPeopleModel;
  set popularPeopleModel(PopularPeopleModel? popularPeopleModel) {
    _popularPeopleModel = popularPeopleModel;
    notifyListeners();
  }

  List<PopularPeopleModel> _popularPeople = [];
  List<PopularPeopleModel> get popularPeople => _popularPeople;
  set popularPeople(List<PopularPeopleModel> popularPeople) {
    _popularPeople = popularPeople;
    notifyListeners();
  }

  List<PopularPeopleModel> _currentPopularPeople = [];
  List<PopularPeopleModel> get currentPopularPeople => _currentPopularPeople;
  set currentPopularPeople(List<PopularPeopleModel> popularpeople) {
    _currentPopularPeople = popularpeople;
    notifyListeners();
  }

  Future<bool> fetchPopularPeople({int page = 1}) async {
    String param = '?api_key=$apiKey&language=en-US&page=$page';

    String url = Endpoints.fetchPopularPeople + param;
    Map resp = await ApiHelpers.makeGetRequest(url, headers: {});
    if (resp['status']) {
      checkPageNumber(page, resp);
    } else {
      _transactionError = resp['message'] ?? 'Error fetching popular people';
    }
    return resp['status'];
  }

  void checkPageNumber(int page, Map<dynamic, dynamic> resp) {
    if (page == 1) {
      _totalNumberOfPeople = 0;
    }
    if (resp['data']['results'].isNotEmpty) {
      List<PopularPeopleModel> ourPopularPeople = setPopularPeopleList(resp);
      if (page > 1) {
        _popularPeople.addAll(ourPopularPeople);
      } else {
        _popularPeople = ourPopularPeople;
      }
      notifyListeners();
    } else {
      if (_totalNumberOfPeople == 0) {
        setEmptyLists();
      }
    }
  }

  void setEmptyLists() {
    _popularPeople = [];
    _currentPopularPeople = [];
  }

  List<PopularPeopleModel> setPopularPeopleList(Map<dynamic, dynamic> resp) {
    List<PopularPeopleModel> ourPopularPeople = resp['data']['results']
        .map<PopularPeopleModel>((e) => PopularPeopleModel.fromJson(e))
        .toList();
    _totalNumberOfPeople = resp['data']['total_results'];
    _currentPopularPeople = ourPopularPeople;
    return ourPopularPeople;
  }

  @override
  void disposeValues() {
    _isInitialized = false;
    _popularPeople = [];
    _currentPopularPeople = [];
    _popularPeopleModel = null;

    notifyListeners();
    SystemNavigator.pop();
  }

  void closeApp() {
    _isInitialized = false;
    notifyListeners();
  }
}
