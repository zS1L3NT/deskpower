import 'dart:async';
import 'dart:convert';

import 'package:timeago/timeago.dart' as timeago;
import 'package:desktop_power/env.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  static const URL = "http://desktop-power.loca.lt/flutter";

  DateTime? lastOnline;
  DateTime? lastSignal;
  bool? state;
  bool dirty = false;

  @override
  void initState() {
    super.initState();

    refresh();
  }

  void refresh() async {
    try {
      final response = await get(
        Uri.parse("$URL/status"),
        headers: {
          "Authorization": "Bearer $ACCESS_KEY",
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          dirty = false;
          lastOnline = DateTime.parse(data["lastOnline"]);
          lastSignal = DateTime.parse(data["lastSignal"]);
          state = data["state"];
        });
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    Future.delayed(const Duration(seconds: 1), refresh);
  }

  void signal() async {
    setState(() {
      dirty = true;
      state = true;
    });

    try {
      final response = await post(
        Uri.parse("$URL/signal"),
        headers: {
          "Authorization": "Bearer $ACCESS_KEY",
        },
      );

      if (response.statusCode != 200) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Status Error: ${response.statusCode}"),
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
            title: const Text("HTTP Error"),
            content: Text(e.toString()),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Desktop Power"),
      ),
      body: Column(
        children: [
          Card(
            child: ListTile(
              leading: lastOnline != null
                  ? const Icon(Icons.timer)
                  : const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.grey,
                      ),
                    ),
              title: const Text("Last Seen Online"),
              subtitle: Text(lastOnline != null ? timeago.format(lastOnline!) : "Loading..."),
            ),
          ),
          Card(
            child: ListTile(
              leading: lastSignal != null
                  ? const Icon(Icons.timer)
                  : const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.grey,
                      ),
                    ),
              title: const Text("Last Response Signal"),
              subtitle: Text(lastSignal != null ? timeago.format(lastSignal!) : "Loading..."),
            ),
          ),
          Card(
            child: ListTile(
              leading: lastSignal != null
                  ? const Icon(Icons.check)
                  : const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.grey,
                      ),
                    ),
              title: const Text("Current State"),
              subtitle: Text(state?.toString() ?? "Loading..."),
            ),
          ),
          ElevatedButton(
            onPressed: state == false && !dirty ? signal : null,
            child: const Text("Send Signal"),
          ),
        ],
      ),
    );
  }
}
