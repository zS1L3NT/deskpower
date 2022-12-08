import 'dart:async';
import 'dart:convert';

import 'package:timeago/timeago.dart' as timeago;
import 'package:deskpower/env.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  static const URL = "http://deskpower.zectan.com/flutter";

  DateTime? lastOnline;
  DateTime? lastSignal;
  bool? state;
  List<String>? error;
  bool dirty = false;

  @override
  void initState() {
    super.initState();

    refresh();
  }

  void setError(String title, String message) {
    setState(() {
      error = [title, message];
      lastOnline = null;
      lastSignal = null;
      state = null;
    });
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
          lastOnline = DateTime.parse(data["lastOnline"]);
          lastSignal = DateTime.parse(data["lastSignal"]);
          state = data["state"];
          error = null;
          dirty = false;
        });
      } else {
        setError("Status Error: ${response.statusCode}", response.body.toString());
      }
    } catch (e) {
      setError("HTTP Error", e.toString());
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
        setError("Status Error: ${response.statusCode}", response.body.toString());
      }
    } catch (e) {
      setError("HTTP Error", e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("DeskPower"),
      ),
      body: Column(
        children: [
          const SizedBox(height: 4),
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
              title: const Text("Signal State"),
              subtitle: Text(state != null
                  ? state!
                      ? "Detected"
                      : "None"
                  : "Loading..."),
            ),
          ),
          if (error != null)
            Card(
              child: ListTile(
                leading: const Icon(Icons.warning),
                title: Text(error![0]),
                subtitle: Text(error![1]),
              ),
            ),
        ],
      ),
      floatingActionButton: state == false && !dirty
          ? FloatingActionButton(
              onPressed: signal,
              child: const Icon(Icons.bolt),
            )
          : null,
    );
  }
}
