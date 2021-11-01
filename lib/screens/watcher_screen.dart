import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_2/providers/home_provider.dart';
import 'package:flutter_application_2/providers/watcher_provider.dart';
import 'package:flutter_application_2/screens/splash_screen.dart';
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
    var _homeProv = Provider.of<HomeProvider>(context, listen: false);
    var _watcherCryptoIds = _homeProv.getWatcherCryptoIds;

    if (_homeProv.watcherCryptos.isNotEmpty) {
      try {
        Provider.of<WatcherProvider>(context, listen: false)
            .getWactherCryptos(context, _watcherCryptoIds)
            .then((data) {
          setState(() {
            showLoader = false;
          });
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("An error occured while getting Crypto list")));
      }
    }
    channel = IOWebSocketChannel.connect(
        'wss://ws.coincap.io/prices?assets=$_watcherCryptoIds');

    channel.stream.listen((data) {
      Map<String, dynamic> decoded = jsonDecode(data);

      decoded.forEach((key, value) {
        if (_homeProv.watcherCryptos.isNotEmpty) {
          if (mounted) {
            Provider.of<WatcherProvider>(context, listen: false)
                .updateItem(key, value);
          }
        }
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
    var _homeProv = Provider.of<HomeProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Watch List'),
      ),
      body: _homeProv.watcherCryptos.isEmpty
          ? const Center(child: Text('Add cryptos to start tracking!'))
          : SizedBox(
              height: double.infinity,
              child: !showLoader
                  ? Consumer<WatcherProvider>(
                      builder: (context, watcherProv, _) => ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return WatcherItemCardWidget(
                            crypto: watcherProv.showWatcherCryptos[index],
                          );
                        },
                        itemCount: watcherProv.showWatcherCryptos.length,
                      ),
                    )
                  : const SplashScreen()),
    );
  }
}
