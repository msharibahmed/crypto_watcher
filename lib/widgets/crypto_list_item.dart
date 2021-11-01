import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_2/models/watcher_model.dart';
import 'package:flutter_application_2/providers/home_provider.dart';
import 'package:provider/provider.dart';

class CryptoItem extends StatelessWidget {
  final WatcherModel model;
  const CryptoItem({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isPresent =
        Provider.of<HomeProvider>(context).isPresent(model.cryptoId);
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                    onPressed: () async {
                      if (isPresent) {
                        await Provider.of<HomeProvider>(context, listen: false)
                            .deleteFromWatcher(context, model.cryptoId);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text('Please add it to watcher first!')));
                      }
                    },
                    icon: const Icon(
                      Icons.remove_circle,
                      color: Colors.red,
                    )),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(model.name),
                    const SizedBox(
                      height: 5,
                    ),
                    Text('Price: \$ ${model.priceUsd}')
                  ],
                ),
                const Spacer(),
                IconButton(
                    onPressed: () async {
                      if (!isPresent) {
                        await Provider.of<HomeProvider>(context, listen: false)
                            .addToWatcher(context, model);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text('Already present in watchlist!')));
                      }
                    },
                    icon: const Icon(Icons.add_circle, color: Colors.green)),
              ],
            ),
            const Divider(
              color: Colors.black,
              height: 1,
            )
          ],
        ));
  }
}
