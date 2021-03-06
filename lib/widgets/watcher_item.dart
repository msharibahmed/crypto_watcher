import 'package:flutter/material.dart';
//
import 'package:flutter_application_2/models/watcher_model.dart';

class WatcherItemCardWidget extends StatelessWidget {
  final WatcherModel crypto;
  WatcherItemCardWidget({Key? key, required this.crypto}) : super(key: key);
  final List<Color> increasingGrad = [
    Colors.green[400] ?? const Color(0xFF42A5F5),
    Colors.green[300] ?? const Color(0xFF42A5F5),
    Colors.green[200] ?? const Color(0xFF42A5F5),
  ];
  final List<Color> decreasingGrad = [
    Colors.red[400] ?? const Color(0xFF42A5F5),
    Colors.red[300] ?? const Color(0xFF42A5F5),
    Colors.red[200] ?? const Color(0xFF42A5F5),
  ];
  final List<Color> neutralGrad = [
    Colors.blue[400] ?? const Color(0xFF42A5F5),
    Colors.blue[300] ?? const Color(0xFF42A5F5),
    Colors.blue[200] ?? const Color(0xFF42A5F5),
  ];
  List<Color> gradColor(int variation) {
    if (variation == 0) {
      return neutralGrad;
    } else if (variation == 1) {
      return increasingGrad;
    }
    return decreasingGrad;
  }

  Widget priceVarIcon(int variation) {
    if (variation == 0) {
      return Padding(
        padding: const EdgeInsets.only(bottom:10.0),
        child: Icon(
          Icons.minimize,
          color: Colors.blue[600],
          size: 20,
        ),
      );
    } else if (variation == 1) {
      return Icon(
        Icons.arrow_upward,
        color: Colors.green[600],
        size: 20,
      );
    }
    return Icon(
      Icons.arrow_downward,
      color: Colors.red[600],
      size: 20,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 1000),
      curve: Curves.fastLinearToSlowEaseIn,
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: gradColor(crypto.priceVariation)),
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      height: 150,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  crypto.name,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: crypto.name.length > 12 ? 18 : 23),
                ),
                const SizedBox(
                  height: 2,
                ),
                Text(
                  crypto.cryptoId,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: <Widget>[
              priceVarIcon(crypto.priceVariation),
              Text(
                '\$${double.parse(crypto.priceUsd).toStringAsFixed(5)}',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
