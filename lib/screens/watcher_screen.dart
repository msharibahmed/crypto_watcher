import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/watcher_model.dart';
import 'package:flutter_application_2/providers/home_provider.dart';
import 'package:flutter_application_2/providers/watcher_provider.dart';
import 'package:flutter_application_2/widgets/watcher_item.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/io.dart';

class WatcherScreen extends StatefulWidget {
  static const String routeName = '/watcher';

  const WatcherScreen({Key? key}) : super(key: key);

  @override
  _WatcherScreenState createState() => _WatcherScreenState();
}

class _WatcherScreenState extends State<WatcherScreen> {
  late IOWebSocketChannel channel;
  bool showLoader = true;

  @override
  void initState() {
    super.initState();

    var _watcherCryptoIds =
        Provider.of<HomeProvider>(context, listen: false).getWatcherCryptoIds;
    try {
      Provider.of<WatcherProvider>(context, listen: false)
          .getWactherCryptos(context,_watcherCryptoIds)
          .then((data) {
        setState(() {
          showLoader = false;
        });
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("An error occured while getting Crypto list")));
    }
    channel = IOWebSocketChannel.connect(
        'wss://ws.coincap.io/prices?assets=$_watcherCryptoIds');

    channel.stream.listen((data) {
      Map<String, dynamic> decoded = jsonDecode(data);

      decoded.forEach((key, value) {
        Provider.of<WatcherProvider>(context, listen: false)
            .updateItem(key, value);
      });
    });
  }

  @override
  void dispose() {
    channel.sink.close();
  
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SizedBox(
        height: double.infinity,
        child: !showLoader
            ? ListView.builder(
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return WatcherItemCardWidget(
                    currencyDetails: Provider.of<WatcherProvider>(context)
                        .showWatcherCryptos[index],
                  );
                },
                itemCount: Provider.of<WatcherProvider>(context)
                    .showWatcherCryptos
                    .length,
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
