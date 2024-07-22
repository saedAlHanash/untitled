// import 'package:agora_uikit/agora_uikit.dart';
// import 'package:flutter/material.dart';
//
// class VideoCallWidget extends StatefulWidget {
//   const VideoCallWidget(
//       {super.key, required this.channel, required this.token});
//
//   final String channel;
//   final String token;
//
//   @override
//   State<VideoCallWidget> createState() => _VideoCallWidgetState();
// }
//
// class _VideoCallWidgetState extends State<VideoCallWidget> {
//   AgoraClient? client;
//
//   @override
//   void initState() {
//     super.initState();
//     client = AgoraClient(
//       agoraConnectionData: AgoraConnectionData(
//         appId: "d3e3ad9bf2a846beb551b003979a2142",
//         channelName: widget.channel,
//         tempToken: widget.token,
//       ),
//       enabledPermission: [
//         Permission.camera,
//         Permission.microphone,
//       ],
//     )..initialize();
//   }
//
//   @override
//   void dispose() {
//     client?.engine.leaveChannel();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         AgoraVideoViewer(client: client!),
//         AgoraVideoButtons(client: client!),
//       ],
//     );
//   }
// }
