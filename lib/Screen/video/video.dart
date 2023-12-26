import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

// class Video1 extends StatelessWidget {
//   const Video1({super.key, required this.tempToken});
//
//   final String tempToken;
//
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }

class Video1 extends StatefulWidget {
  const Video1({Key? key, required this.tempToken}) : super(key: key);
  final String tempToken;

  @override
  State<Video1> createState() => _Video1State();
}

class _Video1State extends State<Video1> {
  int? _remoteUid;
  bool _localUserJoined = false;
  late RtcEngine _engine;
  late RtcEngineEventHandler eventHandler;

  @override
  void initState() {
    super.initState();
    initAgora();
    eventHandler = RtcEngineEventHandler(
      onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
        debugPrint("local user ${connection.localUid} joined");
        if (mounted) setState(() => _localUserJoined = true);
      },
      onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
        debugPrint("remote user $remoteUid joined");

        if (mounted) setState(() => _remoteUid = remoteUid);
      },
      onUserOffline:
          (RtcConnection connection, int remoteUid, UserOfflineReasonType reason) {
        debugPrint("remote user $remoteUid left channel");
        if (mounted) setState(() => _remoteUid = null);
      },
      onTokenPrivilegeWillExpire: (RtcConnection connection, String token) {
        debugPrint(
            '[onTokenPrivilegeWillExpire] connection: ${connection.toJson()}, token: $token');
      },
    );
  }

  Future<void> initAgora() async {
    // retrieve permissions
    await [Permission.microphone, Permission.camera].request();

    //create the engine
    _engine = createAgoraRtcEngine();
    await _engine.initialize(const RtcEngineContext(
      appId: 'd3e3ad9bf2a846beb551b003979a2142',
      channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
    ));

    _engine.registerEventHandler(eventHandler);

    await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    await _engine.enableVideo();
    await _engine.startPreview();

    await _engine.joinChannel(
      token: widget.tempToken,
      channelId: 'flutter',
      uid: 0,
      options: const ChannelMediaOptions(),
    );
  }

  @override
  void dispose() {
    _engine.leaveChannel();
    _engine.unregisterEventHandler(eventHandler);
    super.dispose();
  }

  // Create UI with local view and remote view
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Get.theme.primaryColor,
        title: Text('private_sessions'.tr),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Center(child: _remoteVideo()),
          Align(
            alignment: Alignment.topLeft,
            child: SizedBox(
              width: 100,
              height: 150,
              child: Center(
                child: _localUserJoined
                    ? AgoraVideoView(
                        controller: VideoViewController(
                          rtcEngine: _engine,
                          canvas: const VideoCanvas(uid: 0),
                        ),
                      )
                    : const CircularProgressIndicator.adaptive(),
              ),
            ),
          ),
          _localUserJoined
              ? Positioned(
                  bottom: 20.0,
                  child: CallScreen(engine: _engine),
                )
              : const SizedBox(),
        ],
      ),
    );
  }

  // Display remote user's video
  Widget _remoteVideo() {
    if (_remoteUid != null) {
      return AgoraVideoView(
        controller: VideoViewController.remote(
          rtcEngine: _engine,
          canvas: VideoCanvas(uid: _remoteUid),
          connection: const RtcConnection(channelId: 'flutter'),
        ),
      );
    } else {
      return const Text(
        'Please wait for remote user to join',
        textAlign: TextAlign.center,
      );
    }
  }
}

class CallScreen extends StatefulWidget {
  final RtcEngine engine;

  const CallScreen({Key? key, required this.engine}) : super(key: key);

  @override
  _CallScreenState createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  bool _isInChannel = false;
  bool _isMicrophoneMuted = false;
  bool _isVideoMuted = false;

  void _disconnect() {
    widget.engine.leaveChannel();
    setState(() {
      _isInChannel = false;
    });
    Navigator.pop(context);
  }

  void _muteLocalAudioStream() {
    widget.engine.muteLocalAudioStream(!_isMicrophoneMuted);
    setState(() {
      _isMicrophoneMuted = !_isMicrophoneMuted;
    });
  }

  void _muteLocalVideoStream() {
    widget.engine.muteLocalVideoStream(!_isVideoMuted);
    setState(() {
      _isVideoMuted = !_isVideoMuted;
    });
  }

  void _switchCamera() {
    widget.engine.switchCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white70,
            ),
            child: IconButton(
              onPressed: _muteLocalAudioStream,
              icon: Icon(
                _isMicrophoneMuted ? Icons.mic_off : Icons.mic,
                color: _isMicrophoneMuted ? Colors.red : Colors.black,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.red,
            ),
            padding: const EdgeInsets.all(5.0),
            child: IconButton(
              onPressed: _disconnect,
              icon: const Icon(
                Icons.call_end,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white70,
            ),
            child: IconButton(
              onPressed: _switchCamera,
              icon: const Icon(Icons.switch_camera),
            ),
          ),
          const SizedBox(width: 16),
          Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white70,
            ),
            child: IconButton(
              onPressed: _muteLocalVideoStream,
              icon: Icon(
                _isVideoMuted ? Icons.videocam_off : Icons.videocam,
                color: _isVideoMuted ? Colors.red : Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
