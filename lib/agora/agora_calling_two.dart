import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:frontend/agora/actionswidget.dart';
import 'package:frontend/agora/logsink.dart';
import 'agora_config.dart' as config;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:agora_uikit/agora_uikit.dart';
/// MultiChannel Example
class JoinChannelVideo extends StatefulWidget {
  /// Construct the [JoinChannelVideo]
  const JoinChannelVideo({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<JoinChannelVideo> {
  // Instantiate the client
  final AgoraClient client = AgoraClient(
    agoraConnectionData: AgoraConnectionData(
      appId: config.appId,
      tokenUrl: "https://agora-token-service-production-bad8.up.railway.app",
      channelName: config.channelId,
      uid : config.uid,
    ),
  );

  // Initialize the Agora Engine
  @override
  void initState() {
    super.initState();
    initAgora();
  }

  void initAgora() async {
    await client.initialize();
  }

  // Build your layout
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Container(
            height : MediaQuery.of(context).size.height,
            width : MediaQuery.of(context).size.width,
            child: AgoraVideoViewer(
              layoutType: Layout.oneToOne,
              // floatingLayoutContainerHeight: 150,
              // floatingLayoutContainerWidth:  50,
              client: client
            ),
          ),
        ),
      ),
    );
  }
}
