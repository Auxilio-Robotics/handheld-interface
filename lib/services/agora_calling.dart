import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:frontend/services/constants.dart';
import 'package:http/http.dart' as http;

class VideoCall extends StatefulWidget {
  final String channelName;
  VideoCall(this.channelName);
  @override
  _VideoCallState createState() => _VideoCallState();
}

class _VideoCallState extends State<VideoCall> {
  static final _users = <int>[];
  final _infoStrings = <String>[];
  int uid = 0;
  String token = '';
  bool isLoading = true;
  late RtcEngine _engine;
  bool muted = false;

  @override
  void dispose() {
    // clear users
    _users.clear();
    // destroy sdk
    _engine.leaveChannel();
    _engine.destroy();
    super.dispose();
  }

  int generateRandomUid() {
    var random = new Random();
    return random.nextInt(1000000);
  }

  @override
  void initState() {
    super.initState();
    // initialize agora sdk
    getToken();
  }

  Future<void> getToken() async {
    setState(() {
      isLoading = true;
    });
    uid = generateRandomUid();
    final url =
        'https://agora-token-service-production-bad8.up.railway.app/rtc/robotdisplay/1/uid/1/?expiry=10800';
    final response = await http.get(Uri.parse(url));
    print("\n\n\n\n\n\n\n\n\n");
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.statusCode == 200) {
      setState(() {
        token = json.decode(response.body)['rtcToken'];
      });
    } else {
      AlertDialog(
        title: new Text("Failed to receive token from the server."),
        content: new Text("Please retry after sometime."),
      );
    }
    initialize();
    setState(() {
      isLoading = false;
    });
  }

  Future<void> initialize() async {
    print("\n\n\n\n Values >>>> ");
    print(uid.toString());
    print(widget.channelName);
    print(token);

    if (APP_ID.isEmpty) {
      setState(() {
        _infoStrings.add(
          'APP_ID missing, please provide your APP_ID in settings.dart',
        );
        _infoStrings.add('Agora Engine is not starting');
      });
      return;
    }

    await _initAgoraRtcEngine();
    _addAgoraEventHandlers();

    // await _engine.enableWebSdkInteroperability(true);
    await _engine.setParameters(
        '''{\"che.video.lowBitRateStreamParameter\":{\"width\":320,\"height\":180,\"frameRate\":15,\"bitRate\":140}}''');

    await _engine.joinChannel(token, widget.channelName, null, uid);
  }

  /// Add agora sdk instance and initialize
  Future<void> _initAgoraRtcEngine() async {
    _engine = await RtcEngine.create(APP_ID);
    await _engine.enableVideo();
  }

  void toggleMute() {
    setState(() {
      muted = !muted;
    });
    _engine.muteLocalAudioStream(muted);
  }

  void toggleCamera() {
    _engine.switchCamera();
  }

  void disconnectCall() {
    Navigator.pop(context);
  }

  /// agora event handlers
  void _addAgoraEventHandlers() {
    _engine.setEventHandler(RtcEngineEventHandler(
      error: (code) {
        setState(() {
          final info = 'onError: $code';
          _infoStrings.add(info);
        });
      },
      joinChannelSuccess: (channel, uid, elapsed) {
        setState(() {
          final info = 'onJoinChannel: $channel, uid: $uid';
          _infoStrings.add(info);
        });
      },
      leaveChannel: (stats) {
        setState(() {
          _infoStrings.add('onLeaveChannel');
          _users.clear();
        });
      },
      userJoined: (uid, elapsed) {
        setState(() {
          final info = 'userJoined: $uid';
          _infoStrings.add(info);
          _users.add(uid);
        });
      },
      userOffline: (uid, reason) {
        setState(() {
          final info = 'userOffline: $uid , reason: $reason';
          _infoStrings.add(info);
          _users.remove(uid);
        });
      },
      firstRemoteVideoFrame: (uid, width, height, elapsed) {
        setState(() {
          final info = 'firstRemoteVideoFrame: $uid';
          _infoStrings.add(info);
        });
      },
    ));
  }

  /// Helper function to get list of native views
  List<Widget> _getRenderViews() {
    final List<StatefulWidget> list = [];
    list.add(RtcLocalView.SurfaceView());
    _users.forEach((int uid) => list.add(RtcRemoteView.SurfaceView(uid: uid)));
    return list;
  }

  /// Remote video view wrapper
  Widget _videoView(view) {
    return Container(height: 651.4, child: view);
  }

  /// Local video view row wrapper
  Widget _localVideoView(view) {
    return Container(
      height: 150,
      width: 120,
      child: view,
    );
  }

  /// Video layout wrapper
  Widget _viewRows() {
    final views = _getRenderViews();
    switch (views.length) {
      case 1:
        return Container(
            child: Column(
          children: <Widget>[_videoView(views[0])],
        ));
      case 2:
        return Container(
            child: Stack(
          children: <Widget>[
            _videoView(views[1]),
            Align(
                alignment: Alignment(0.95, -0.95),
                child: _localVideoView(views[0])),
          ],
        ));
      default:
    }
    return Container();
  }

  /// Info panel to show logs
  Widget _panel() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 48),
      alignment: Alignment.bottomCenter,
      child: FractionallySizedBox(
        heightFactor: 0.5,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 48),
          child: ListView.builder(
            reverse: true,
            itemCount: _infoStrings.length,
            itemBuilder: (BuildContext context, int index) {
              if (_infoStrings.isEmpty) {
                return null;
              }
              return Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 3,
                  horizontal: 10,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 2,
                          horizontal: 5,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.yellowAccent,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          _infoStrings[index],
                          style: TextStyle(color: Colors.blueGrey),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: isLoading
          ? CircularProgressIndicator()
          : Stack(
              children: <Widget>[
                Positioned(
                  bottom: 10,
                  left: 60,
                  child: Container(
                    height: 50,
                    width: 300,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        CircleAvatar(
                          backgroundColor: Colors.blue,
                          child: IconButton(
                            icon: muted
                                ? Icon(
                                    Icons.mic_off,
                                    color: Colors.white,
                                  )
                                : Icon(Icons.mic, color: Colors.white),
                            onPressed: toggleMute,
                          ),
                        ),
                        CircleAvatar(
                            backgroundColor: Colors.red,
                            child: IconButton(
                              icon: Icon(
                                Icons.call_end,
                                color: Colors.white,
                              ),
                              onPressed: disconnectCall,
                            )),
                        CircleAvatar(
                            backgroundColor: Colors.blue,
                            radius: 20,
                            child: IconButton(
                              icon: Icon(
                                Icons.switch_camera,
                                color: Colors.white,
                              ),
                              onPressed: toggleCamera,
                            )),
                      ],
                    ),
                  ),
                ),
                _viewRows(),
                _panel(),
              ],
            ),
    );
  }
}