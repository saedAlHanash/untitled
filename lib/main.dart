import 'package:chat_web_app/chat_service/chat_service_core.dart';
import 'package:chat_web_app/fire_chat/util.dart';

import 'package:chat_web_app/util/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_strategy/url_strategy.dart';
import 'fire_chat/open_room_cubit/open_room_cubit.dart';
import 'fire_chat/rooms_bloc/rooms_cubit.dart';
import 'injection/injection_container.dart' as di;

import 'app_widget.dart';
import 'fire_chat/messages_bloc/messages_cubit.dart';
import 'firebase_options.dart';
import 'injection/injection_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await di.init();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
ChatServiceCore.initFirebaseChat();
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
    cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
    ignoreUndefinedProperties: true,
  );

  setPathUrlStrategy();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (_) => sl<RoomsCubit>()..getChatRooms(false)),
      BlocProvider(create: (_) => sl<MessagesCubit>()),
      BlocProvider(create: (_) => sl<OpenRoomCubit>()),
    ],
    child: const MyApp(),
  ));
}
