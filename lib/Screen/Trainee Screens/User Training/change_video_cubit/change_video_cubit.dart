import 'dart:async';

import 'package:fitness_storm/core/api_manager/api_url.dart';
import 'package:fitness_storm/core/extensions/extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/abstraction.dart';
import '../../../../core/util/pair_class.dart';

part 'change_video_state.dart';

class ChangeVideoCubit extends Cubit<ChangeVideoInitial> {
  ChangeVideoCubit() : super(ChangeVideoInitial.initial());

  Future<void> changeVideo() async {
    emit(state.copyWith(statuses: CubitStatuses.loading));
    Future.delayed(
      Duration(seconds: 1),
      () {
        emit(state.copyWith(statuses: CubitStatuses.done));
      },
    );
  }
}
