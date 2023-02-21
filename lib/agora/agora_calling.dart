import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:frontend/agora/actionswidget.dart';
import 'package:frontend/agora/logsink.dart';
import 'agora_config.dart' as config;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// MultiChannel Example
class JoinChannelVideo extends StatefulWidget {
  /// Construct the [JoinChannelVideo]
  const JoinChannelVideo({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<JoinChannelVideo> {
  late final RtcEngine _engine;
  bool _isReadyPreview = false;

  bool isJoined = false, switchCamera = true, switchRender = true;
  Set<int> remoteUid = {};
  late TextEditingController _controller;
  bool _isUseFlutterTexture = false;
  bool _isUseAndroidSurfaceView = false;
  ChannelProfileType _channelProfileType =
      ChannelProfileType.channelProfileLiveBroadcasting;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: config.channelId);

    _initEngine();
    // 
  }

  @override
  void dispose() {
    super.dispose();
    _dispose();
  }

  Future<void> _dispose() async {
    await _engine.leaveChannel();
    await _engine.release();
  }

  Future<void> _initEngine() async {
    _engine = createAgoraRtcEngine();
    await _engine.initialize(RtcEngineContext(
      appId: config.appId,
    ));

    _engine.registerEventHandler(RtcEngineEventHandler(
      onError: (ErrorCodeType err, String msg) {
        logSink.log('[onError] err: $err, msg: $msg');
      },
      onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
        logSink.log(
            '[onJoinChannelSuccess] connection: ${connection.toJson()} elapsed: $elapsed');
        setState(() {
          isJoined = true;
        });
      },
      onUserJoined: (RtcConnection connection, int rUid, int elapsed) {
        logSink.log(
            '[onUserJoined] connection: ${connection.toJson()} remoteUid: $rUid elapsed: $elapsed');
        setState(() {
          remoteUid.add(rUid);
        });
      },
      onUserOffline:
          (RtcConnection connection, int rUid, UserOfflineReasonType reason) {
        logSink.log(
            '[onUserOffline] connection: ${connection.toJson()}  rUid: $rUid reason: $reason');
        setState(() {
          remoteUid.removeWhere((element) => element == rUid);
        });
      },
      onLeaveChannel: (RtcConnection connection, RtcStats stats) {
        logSink.log(
            '[onLeaveChannel] connection: ${connection.toJson()} stats: ${stats.toJson()}');
        setState(() {
          isJoined = false;
          remoteUid.clear();
        });
      },
    ));

    await _engine.enableVideo();

    await _engine.setVideoEncoderConfiguration(
      const VideoEncoderConfiguration(
        dimensions: VideoDimensions(width: 640, height: 360),
        frameRate: 15,
        bitrate: 0,
      ),
    );

    await _engine.startPreview();

    setState(() {
      _isReadyPreview = true;
    });
    await _engine.joinChannel(
      token: config.token,
      channelId: config.channelId,
      uid: config.uid,
      options: ChannelMediaOptions(
        channelProfile: _channelProfileType,
        clientRoleType: ClientRoleType.clientRoleBroadcaster,
      ),
    );
  }

  Future<void> _leaveChannel() async {
    await _engine.leaveChannel();
  }

  Future<void> _switchCamera() async {
    await _engine.switchCamera();
    setState(() {
      switchCamera = !switchCamera;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(!_isReadyPreview) {
      return Container();
    }
    return Stack(
      children: [
        Container(
          color: Colors.grey,
          width: MediaQuery.of(context).size.width,
          child: AgoraVideoView(
            controller: VideoViewController.remote(
              rtcEngine: _engine,
              canvas: VideoCanvas(uid: 2),
              connection: RtcConnection(channelId: 'robotdisplay'),
              useFlutterTexture: _isUseFlutterTexture,
              useAndroidSurfaceView: _isUseAndroidSurfaceView,
            ),
          ),
        ),
      
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10))
          ),
          child: Positioned(
            top:0,
            right:0 ,
            child: Container(
              width: 200,
              height: 150,
              child: AgoraVideoView(
                controller: VideoViewController(
                  rtcEngine: _engine,
                  canvas: const VideoCanvas(uid: 0),
                  useFlutterTexture: _isUseFlutterTexture,
                  useAndroidSurfaceView: _isUseAndroidSurfaceView,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
