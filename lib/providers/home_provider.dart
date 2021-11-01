import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/watcher_model.dart';
import 'package:http/http.dart' as http;

class HomeProvider with ChangeNotifier {
  List<WatcherModel> _allCryptos = [];
  List<WatcherModel> get allCryptos {
    return [..._allCryptos];
  }

  List<WatcherModel> _searchCryptos = [];

  List<WatcherModel> get searchCryptos {
    return [..._searchCryptos];
  }

  void showCryptosBySearch(String input) {
    if (input.trim() == '') {
      _searchCryptos.clear();
    } else {
      _searchCryptos = allCryptos.where((element) {
        var b = element.name.toLowerCase().startsWith(input.toLowerCase());
        return b;
      }).toList();
    }
    notifyListeners();
  }

  Map<String, String> _watcherCryptos = {};
  Map<String, String> get watcherCryptos {
    return {..._watcherCryptos};
  }

  final _authToken = FirebaseAuth.instance.currentUser!.uid;

  Future<void> getData(BuildContext context) async {
    try {
      var url = Uri.parse('https://api.coincap.io/v2/assets');
      final response = await http.get(url);
      final databody = jsonDecode(response.body)['data'];
      List<WatcherModel> _temp = [];
      for (var e in databody) {
        _temp.add(WatcherModel(
            id: '',
            cryptoId: e['id'],
            name: e['name'],
            priceUsd: e['priceUsd']));
      }
      _allCryptos = _temp;
    } catch (error) {
      print('caught error in getData call : $error');

      showSnackBar(
          context: context, text: 'Server error, please try again later!');
    }
  }

  Future<void> addToWatcher(BuildContext context, WatcherModel model) async {
    try {
      var url = Uri.parse(
          'https://crypto-tracker-c8728-default-rtdb.firebaseio.com/$_authToken.json');
      final response =
          await http.post(url, body: jsonEncode({'id': model.cryptoId}));
      final databody = jsonDecode(response.body);
      print(databody);
      _watcherCryptos.addAll({databody['name']: model.cryptoId});
      showSnackBar(
          context: context, text: 'Crypto successfully added to watchlist!');
    } catch (error) {
      print('caught error in addToWatcher call : $error');

      showSnackBar(
          context: context, text: 'Server error, please try again later!');
    }
    notifyListeners();
  }

  Future<void> deleteFromWatcher(BuildContext context, String cryptoId) async {
    var _id = _getIdByCryptoId(cryptoId);
    try {
      var url = Uri.parse(
          'https://crypto-tracker-c8728-default-rtdb.firebaseio.com/$_authToken/$_id.json');
      final response = await http.delete(url);
      final databody = jsonDecode(response.body);
      print(databody);
      _watcherCryptos.remove(_id);

      showSnackBar(
          context: context,
          text: 'Crypto successfully removed from watchlist!');
    } catch (error) {
      print('caught error in deleteFromWatcher call : $error');

      showSnackBar(
          context: context, text: 'Server error, please try again later!');
    }
    notifyListeners();
  }

  Future<void> getWatcherData(BuildContext context) async {
    try {
      var url = Uri.parse(
          'https://crypto-tracker-c8728-default-rtdb.firebaseio.com/$_authToken.json');
      final response = await http.get(url);
      Map<dynamic, dynamic> databody = jsonDecode(response.body) ?? {};
      print(databody);
      Map<String, String> _temp = {};
      databody.forEach((key, value) {
        _temp.addAll({key: databody[key]['id']});
      });

      _watcherCryptos = _temp;
    } catch (error) {
      print('caught error in getWatcherData call : $error');
      showSnackBar(
          context: context, text: 'Server error, please try again later!');
    }
  }

  bool isPresent(String cryptoId) => _watcherCryptos.containsValue(cryptoId);
  String _getIdByCryptoId(String cryptoId) => _watcherCryptos.keys
      .firstWhere((key) => _watcherCryptos[key] == cryptoId);
  void showSnackBar({required BuildContext context, required String text}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text),
      backgroundColor: Colors.grey,
    ));
  }

  String get getWatcherCryptoIds => [..._watcherCryptos.values].join(',');
}
