import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../fire_chat/messages_bloc/messages_cubit.dart';
import '../fire_chat/open_room_cubit/open_room_cubit.dart';
import '../fire_chat/rooms_bloc/rooms_cubit.dart';
import '../util/shared_preferences.dart';
import 'package:intl/date_symbol_data_local.dart';
final sl = GetIt.instance;

Future<void> init() async {
  await initializeDateFormatting();
  //region Core
  sl.registerLazySingleton(() => GlobalKey<NavigatorState>());
  sl.registerLazySingleton(() => MessagesCubit());
  sl.registerLazySingleton(() => RoomsCubit());
  sl.registerLazySingleton(() => OpenRoomCubit());
  //endregion

  await SharedPreferences.getInstance().then((value) {
    AppSharedPreference.init(value);
  });

  await Hive.initFlutter();
}
