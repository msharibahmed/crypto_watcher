import 'package:flutter/material.dart';
//
import 'package:flutter_application_2/firebase_auth.dart';
import 'package:flutter_application_2/providers/home_provider.dart';
import 'package:flutter_application_2/widgets/crypto_list_item.dart';
import 'package:provider/provider.dart';

import 'watcher_screen.dart';
//

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _check = true;
  bool _isLoading = true;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_check) {
      Provider.of<HomeProvider>(context).getWatcherData(context).then((value) =>
          Provider.of<HomeProvider>(context, listen: false)
              .getData(context)
              .then((value) {
            setState(() {
              _isLoading = false;
            });
          }));
    }
    _check = false;
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              leading: IconButton(
                  onPressed: () async {
                    Authentication.signOut(context: context);
                  },
                  icon: const Icon(
                    Icons.logout_rounded,
                    color: Colors.black,
                  )),
              centerTitle: true,
              title: const Text('CRYPTO WATCHER'),
              actions: [
                IconButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, WatcherScreen.routeName),
                    icon: Stack(
                      children: [
                        const Icon(
                          Icons.remove_red_eye_outlined,
                          color: Colors.black,
                        ),
                        Align(
                            alignment: Alignment.topRight,
                            child: Text(
                              Provider.of<HomeProvider>(context)
                                  .watcherCryptos
                                  .length
                                  .toString(),
                              style: TextStyle(
                                  color: Colors.orange[300],
                                  fontWeight: FontWeight.bold),
                            ))
                      ],
                    ))
              ],
            ),
            body: Form(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 60.0, vertical: 20),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                    TextFormField(
                        decoration: const InputDecoration(
                            icon: Icon(Icons.keyboard),
                            hintText: 'Enter crypto name...'),
                        onChanged: (input) {
                          Provider.of<HomeProvider>(context, listen: false)
                              .showCryptosBySearch(input);
                          // print(input);
                        }),
                    Expanded(
                        child: ListView.builder(
                      itemBuilder: (context, index) => CryptoItem(
                          model: Provider.of<HomeProvider>(context)
                              .searchCryptos[index]),
                      itemCount: Provider.of<HomeProvider>(context)
                          .searchCryptos
                          .length,
                    ))
                  ],
                ),
              ),
            ));
  }
}
