import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/watcher_model.dart';
import 'package:http/http.dart' as http;

class WatcherProvider with ChangeNotifier {
  List<WatcherModel> _showWatcherCryptos = [];
  List<WatcherModel> get showWatcherCryptos => [..._showWatcherCryptos];
  Future<void> getWactherCryptos(
      BuildContext context, String getCryptoIds) async {
    String uri = 'https://api.coincap.io/v2/assets?ids=$getCryptoIds';
    try {
      final response = await http.get(Uri.parse(uri));

      final dataBody = jsonDecode(response.body)['data'];
      print(dataBody);
      List<WatcherModel> _temp = [];
      for (var e in dataBody) {
        _temp.add(WatcherModel(
            id: '',
            cryptoId: e['id'],
            name: e['name'],
            priceUsd: e['priceUsd']));
      }

      _showWatcherCryptos = _temp;
      // print(_showWatcherCryptos);
    } catch (error) {
      print('got error while calling getWatcherCryptos : $error');
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Server error please try again later')));
    }
    notifyListeners();
  }

  void updateItem(String cryptoId, String price) {
    var item =
        _showWatcherCryptos.firstWhere((item) => item.cryptoId == cryptoId);
    if ((double.parse(item.priceUsd)) <= double.parse(price)) {
      item.isIncreasing = true;
    } else {
      item.isIncreasing = false;
    }
    item.priceUsd = price;

    notifyListeners();
  }
}
