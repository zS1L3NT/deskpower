import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  String? state;
  bool dirty = false;

  @override
  void initState() {
    super.initState();

    refresh();
  }

  void refresh() async {
    try {
      final response = await get(Uri.parse("http://desktop-power.herokuapp.com/"));

      if (response.statusCode == 200 && response.body != state) {
        if (dirty) {
          setState(() {
            dirty = false;
          });
        } else {
          setState(() {
            state = response.body;
          });
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    Future.delayed(const Duration(seconds: 1), refresh);
  }

  void update(String state) async {
    setState(() {
      dirty = true;
      this.state = state;
    });

    try {
      final response = await put(
        Uri.parse("http://desktop-power.herokuapp.com/"),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "state": state,
        }),
      );

      if (response.statusCode != 200) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Error"),
              content: Text(response.body.toString()),
            );
          },
        );
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Error"),
            content: Text(e.toString()),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                if (state != "tap") {
                  update("tap");
                }
              },
              child: Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(80),
                  boxShadow: [
                    if (state != "tap")
                      BoxShadow(
                        color: Colors.grey.shade300,
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                  ],
                ),
                child: Center(
                  child: Text(
                    "Tap",
                    style: TextStyle(
                      color: state == "tap" ? Colors.grey.shade300 : Colors.grey.shade800,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            GestureDetector(
              onTap: () {
                if (state != "hold") {
                  update("hold");
                }
              },
              child: Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(80),
                  boxShadow: [
                    if (state != "hold")
                      BoxShadow(
                        color: Colors.grey.shade300,
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                  ],
                ),
                child: Center(
                  child: Text(
                    "Hold",
                    style: TextStyle(
                      color: state == "hold" ? Colors.grey.shade300 : Colors.grey.shade800,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
