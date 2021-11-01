import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
//
import 'package:flutter_application_2/models/watcher_model.dart';

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
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Server error please try again later'),
        backgroundColor: Colors.grey,
      ));
    }
    notifyListeners();
  }

  void updateItem(String cryptoId, String price) {
    var item =
        _showWatcherCryptos.firstWhere((item) => item.cryptoId == cryptoId);
    double _oldPrice = double.parse(item.priceUsd);
    double _newPrice = double.parse(price);
    if (_oldPrice == _newPrice) {
      item.priceVariation = 0;
    } else if (_oldPrice < _newPrice) {
      item.priceVariation = 1;
    } else {
      item.priceVariation = 2;
    }
    item.priceUsd = price;

    notifyListeners();
  }
}
