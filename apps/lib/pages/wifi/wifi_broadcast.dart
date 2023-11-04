import 'dart:async';
import 'package:esptouch_smartconfig/esptouch_smartconfig.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:niku/namespace.dart' as n;
import 'package:tidal_tech/styles/button.dart';
import 'package:tidal_tech/theme/colors.dart';

class TaskRoute extends StatefulWidget {
  final String ssid;
  final String password;

  const TaskRoute({super.key, required this.ssid, required this.password});

  @override
  State<StatefulWidget> createState() {
    return TaskRouteState();
  }
}

class TaskRouteState extends State<TaskRoute> {
  late Stream<ESPTouchResult>? _stream;

  @override
  void initState() {
    _stream = EsptouchSmartconfig.run(
      ssid: widget.ssid,
      bssid: "",
      password: widget.password,
      deviceCount: "1",
      isBroad: true,
    );
    super.initState();
  }

  @override
  dispose() {
    super.dispose();
  }

  Widget waitingState(BuildContext context) {
    return const Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CupertinoActivityIndicator(),
          SizedBox(height: 16),
          Text(
            'Waiting for results',
            style: TextStyle(fontSize: 24),
          ),
        ],
      ),
    );
  }

  Widget error(BuildContext context, String s) {
    return Center(
      child: Text(
        s,
        style: const TextStyle(color: ThemeColors.danger),
      ),
    );
  }

  Widget noneState(BuildContext context) {
    return Center(
        child: Text(
      'No devices connect to ${widget.ssid ?? '-'}',
      style: const TextStyle(fontSize: 24),
    ));
  }

  Widget resultList(BuildContext context, ConnectionState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: _results.length,
            itemBuilder: (_, index) {
              final result = _results.toList(growable: false)[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: n.Column([
                  n.Icon(Icons.check_circle_outline)
                    ..color = ThemeColors.zinc.shade300
                    ..size = 64 * 2.5,
                  n.Box()..h = 16,
                  n.Text("IP: ${result.ip}")
                    ..color = ThemeColors.foreground
                    ..fontSize = 16,
                  n.Text("Device connect to WiFi.")
                    ..color = ThemeColors.foreground
                    ..fontSize = 20,
                  n.Box()..h = 24,
                  n.Button("Done".n)
                    ..apply = XButtonStyle.confirm()
                    ..fullWidth
                    ..onPressed = () {
                      context.go("/lighting");
                    },
                ])
                  ..px = 16
                  ..mt = 24
                  ..gap = 4,
              );
            },
          ),
        ),
        if (state == ConnectionState.active) const CupertinoActivityIndicator(),
      ],
    );
  }

  final Set<ESPTouchResult> _results = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: n.Icon(Icons.arrow_back_ios_rounded)
            ..color = ThemeColors.foreground
            ..size = 18.0,
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            }
          },
        ),
        backgroundColor: Colors.transparent,
        title: n.Text('Connecting to ${widget.ssid}')
          ..bold
          ..color = ThemeColors.foreground
          ..fontSize = 18.0,
        elevation: 0,
      ),
      body: StreamBuilder<ESPTouchResult>(
        stream: _stream,
        builder: (context, AsyncSnapshot<ESPTouchResult> snapshot) {
          if (snapshot.hasError) {
            return error(context, 'Error in StreamBuilder');
          }
          switch (snapshot.connectionState) {
            case ConnectionState.active:
              _results.add(snapshot.data!);
              return resultList(context, ConnectionState.active);
            case ConnectionState.none:
              return noneState(context);
            case ConnectionState.done:
              if (snapshot.hasData) {
                _results.add(snapshot.data!);
                return resultList(context, ConnectionState.done);
              } else {
                return noneState(context);
              }
            case ConnectionState.waiting:
              return waitingState(context);
          }
        },
      ),
    );
  }
}
