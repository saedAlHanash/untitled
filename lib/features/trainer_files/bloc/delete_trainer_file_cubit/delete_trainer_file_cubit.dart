import 'dart:async';

import 'package:fitness_storm/core/api_manager/api_url.dart';
import 'package:fitness_storm/core/extensions/extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/app/app_widget.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/abstraction.dart';
import '../../../../core/util/pair_class.dart';
import '../trainer_files_cubit/trainer_files_cubit.dart';

part 'delete_trainer_file_state.dart';

class DeleteTrainerFileCubit extends Cubit<DeleteTrainerFileInitial> {
  DeleteTrainerFileCubit() : super(DeleteTrainerFileInitial.initial());

  Future<void> deleteTrainerFile({required String id}) async {
    emit(state.copyWith(statuses: CubitStatuses.loading, request: id));

    final pair = await _deleteTrainerFileApi();

    if (pair.first == null) {
      emit(state.copyWith(error: pair.second, statuses: CubitStatuses.error));
      showErrorFromApi(state);
    } else {
      ctx!.read<TrainerFilesCubit>().getTrainerFiles(newData: true);
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<bool?, String?>> _deleteTrainerFileApi() async {
    final response = await APIService().callApi(
      type: ApiType.delete,
      url: DeleteUrl.deleteTrainerFile,
      path: state.request,
    );

    if (response.statusCode.success) {
      return Pair(true, null);
    } else {
      return response.getPairError;
    }
  }
}
