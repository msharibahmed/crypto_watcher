import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/watcher_model.dart';

class WatcherItemCardWidget extends StatefulWidget {
  final WatcherModel currencyDetails;
  const WatcherItemCardWidget({Key? key, required this.currencyDetails})
      : super(key: key);

  @override
  _WatcherItemCardWidgetState createState() => _WatcherItemCardWidgetState();
}

class _WatcherItemCardWidgetState extends State<WatcherItemCardWidget> {
  bool change = false;
  bool increased = false;
  LinearGradient gradient = const LinearGradient(colors: [
    Color.fromRGBO(54, 60, 112, 0.9),
    Color.fromRGBO(54, 60, 112, 0.9),
    Color.fromRGBO(65, 72, 130, 0.9),
    Color.fromRGBO(65, 72, 130, 0.9),
    Color.fromRGBO(77, 85, 153, 0.9),
  ]);
  late Timer timer;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeInOut,
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        // gradient: gradient,
        color: widget.currencyDetails.isIncreasing
            ? Colors.green[200]
            : Colors.red[200],
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      height: 150,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  // Row(
                  //   children: <Widget>[
                  //     Image.asset(
                  //       'images/${currencyInfo.id}.png',
                  //       width: 40,
                  //     )
                  //   ],
                  // ),

                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        // Text(
                        //   widget.currencyDetails.symbol,
                        //   textAlign: TextAlign.start,
                        //   style: TextStyle(
                        //       color: Colors.white,
                        //       fontSize: 15,
                        //       fontFamily: 'Quicksand',
                        //       decoration: TextDecoration.none),
                        // ),
                        Text(
                          widget.currencyDetails.name,
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Quicksand',
                              fontSize: widget.currencyDetails.name.length > 12
                                  ? 15
                                  : 20,
                              decoration: TextDecoration.none),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text(
                        '\$${double.parse(widget.currencyDetails.priceUsd).toStringAsFixed(5)}',
                        style: const TextStyle(
                            color: Colors.white,
                            fontFamily: 'Quicksand',
                            fontSize: 15,
                            decoration: TextDecoration.none),
                      ),
                      // Row(
                      //   children: <Widget>[
                      //     currencyInfo.percentage != ''
                      //         ? Text(
                      //             '${currencyInfo.percentage}%',
                      //             style: TextStyle(
                      //                 color: Colors.white,
                      //                 fontFamily: 'Quicksand',
                      //                 fontSize: 15,
                      //                 decoration: TextDecoration.none),
                      //           )
                      //         : Text(''),
                      //     currencyInfo.percentage != ''
                      //         ? widget.c.increased
                      //             ?const Icon(
                      //                 Icons.arrow_upward,
                      //                 color: Colors.green,
                      //                 size: 20,
                      //               )
                      //             : const Icon(
                      //                 Icons.arrow_downward,
                      //                 color: Colors.red,
                      //                 size: 20,
                      //               )
                      //         : Text('')
                      //   ],
                      // )
                    ],
                  )
                ],
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: const <Widget>[
                    // Text(
                    //   this.currencyInfo.rank,
                    //   style: TextStyle(
                    //       color: Color.fromRGBO(77, 109, 153, 0.9),
                    //       fontFamily: 'Quicksand',
                    //       fontSize: 25,
                    //       decoration: TextDecoration.none),
                    // ),
                    Icon(
                      Icons.keyboard_arrow_up,
                      color: Color.fromRGBO(77, 109, 153, 0.9),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
