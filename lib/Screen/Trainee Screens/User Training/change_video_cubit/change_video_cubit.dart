import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/abstraction.dart';

part 'change_video_state.dart';

class ChangeVideoCubit extends Cubit<ChangeVideoInitial> {
  ChangeVideoCubit() : super(ChangeVideoInitial.initial());

  Future<void> changeVideo() async {
    emit(state.copyWith(statuses: CubitStatuses.loading));
    Future.delayed(
      const Duration(seconds: 1),
      () {
        emit(state.copyWith(statuses: CubitStatuses.done));
      },
    );
  }
}
