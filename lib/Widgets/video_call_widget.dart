// import 'package:agora_rtc_engine/agora_rtc_engine.dart';
// import 'package:agora_uikit/agora_uikit.dart';
// import 'package:fitness_storm/Utils/storage_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get_storage/get_storage.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// const String appId = "0da7f54533204c4f895ee8ad7d544f29";
//
//
//
// class VideoCallWidget extends StatefulWidget {
//   const VideoCallWidget({Key? key}) : super(key: key);
//
//   @override
//   _VideoCallWidgetState createState() => _VideoCallWidgetState();
// }
//
// class _VideoCallWidgetState extends State<VideoCallWidget> {
//
//   // Future<void> getToken() async {
//   //   final response = await http.get(
//   //     Uri.parse(baseUrl + '/rtc/' + widget.channelName + '/publisher/uid/' + uid.toString()
//   //       // To add expiry time uncomment the below given line with the time in seconds
//   //       // + '?expiry=45'
//   //     ),
//   //   );
//   //
//   //   if (response.statusCode == 200) {
//   //     setState(() {
//   //       token = response.body;
//   //       token = jsonDecode(token)['rtcToken'];
//   //     });
//   //   } else {
//   //    //   print('Failed to fetch the token');
//   //   }
//   // }
//   Future<void> setupVoiceSDKEngine() async {
//     // retrieve or request microphone permission
//     await [Permission.microphone].request();
//
//     //create an instance of the Agora engine
//     agoraEngine = createAgoraRtcEngine();
//     await agoraEngine.initialize(const RtcEngineContext(
//         appId: appId
//     ));
//
//     // Register the event handler
//     agoraEngine.registerEventHandler(
//       RtcEngineEventHandler(
//         onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
//           showMessage("Local user uid:${connection.localUid} joined the channel");
//           setState(() {
//             _isJoined = true;
//           });
//         },
//         onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
//           showMessage("Remote user uid:$remoteUid joined the channel");
//           setState(() {
//             _remoteUid = remoteUid;
//           });
//         },
//         onUserOffline: (RtcConnection connection, int remoteUid,
//             UserOfflineReasonType reason) {
//           showMessage("Remote user uid:$remoteUid left the channel");
//           setState(() {
//             _remoteUid = null;
//           });
//         },
//       ),
//     );
//   }
//   void  join() async {
//
//     // Set channel options including the client role and channel profile
//     ChannelMediaOptions options = const ChannelMediaOptions(
//       clientRoleType: ClientRoleType.clientRoleBroadcaster,
//       channelProfile: ChannelProfileType.channelProfileCommunication,
//     );
//
//     await agoraEngine.joinChannel(
//       token: token,
//       channelId: channelName,
//       options: options,
//       uid: uid,
//     );
//   }
//   void leave() {
//     setState(() {
//       _isJoined = false;
//       _remoteUid = null;
//     });
//     agoraEngine.leaveChannel();
//   }
//   // Clean up the resources when you leave
//   @override
//   void dispose() async {
//     await agoraEngine.leaveChannel();
//     super.dispose();
//   }
//   @override
//   void initState() {
//     super.initState();
//     // Set up an instance of Agora engine
//     setupVoiceSDKEngine();
//   }
//    
//   String channelName =  StorageController().token;
//   String token = "test";
//
//   int uid = 0; // uid of the local user
//
//   int? _remoteUid; // uid of the remote user
//   bool _isJoined = false; // Indicates if the local user has joined the channel
//   late RtcEngine agoraEngine; // Agora engine instance
//
//   final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey
//   = GlobalKey<ScaffoldMessengerState>(); // Global key to access the scaffold
//
//   showMessage(String message) {
//     scaffoldMessengerKey.currentState?.showSnackBar(SnackBar(
//       content: Text(message),
//     ));
//   }
//
// // Build UI
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       scaffoldMessengerKey: scaffoldMessengerKey,
//       home: Scaffold(
//           appBar: AppBar(
//             title: const Text('Get started with Voice Calling'),
//           ),
//           body: ListView(
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
//             children: [
//               // Status text
//               Container(
//                   height: 40,
//                   child:Center(
//                       child:_status()
//                   )
//               ),
//               // Button Row
//               Row(
//                 children: <Widget>[
//                   Expanded(
//                     child: ElevatedButton(
//                       child: const Text("Join"),
//                       onPressed: () => {join()},
//                     ),
//                   ),
//                   const SizedBox(width: 10),
//                   Expanded(
//                     child: ElevatedButton(
//                       child: const Text("Leave"),
//                       onPressed: () => {leave()},
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           )),
//     );
//   }
//
//   Widget _status(){
//     String statusText;
//
//     if (!_isJoined)
//       statusText = 'Join a channel';
//     else if (_remoteUid == null)
//       statusText = 'Waiting for a remote user to join...';
//     else
//       statusText = 'Connected to remote user, uid:$_remoteUid';
//
//     return Text(
//       statusText,
//     );
//   }
// }
