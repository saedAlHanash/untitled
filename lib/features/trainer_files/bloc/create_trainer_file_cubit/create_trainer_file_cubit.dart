import 'dart:async';
import 'dart:typed_data';

import 'package:fitness_storm/core/api_manager/api_url.dart';
import 'package:fitness_storm/core/app/app_widget.dart';
import 'package:fitness_storm/core/extensions/extensions.dart';
import 'package:fitness_storm/features/trainer_files/bloc/trainer_files_cubit/trainer_files_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:m_cubit/abstraction.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/request/create_trainer_file_request.dart';
import '../../data/response/trainer_file_response.dart';

part 'create_trainer_file_state.dart';

class CreateTrainerFileCubit extends Cubit<CreateTrainerFileInitial> {
  CreateTrainerFileCubit() : super(CreateTrainerFileInitial.initial());
  TextEditingController textController = TextEditingController();

  Future<void> createTrainerFile() async {
    emit(state.copyWith(statuses: CubitStatuses.loading));

    final pair = await _createTrainerFileApi();

    if (pair.first == null) {
      emit(state.copyWith(error: pair.second, statuses: CubitStatuses.error));
      showErrorFromApi(state);
    } else {
      ctx!.read<TrainerFilesCubit>().getTrainerFiles(newData: true);
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<TrainerFile?, String?>> _createTrainerFileApi() async {
    late final Response response;

    response = await APIService().uploadMultiPart(
      files: [state.mRequest.file],
      url: PostUrl.createTrainerFile,
      fields: state.mRequest.toJson(),
    );

    if (response.statusCode.success) {
      return Pair(TrainerFile.fromJson(response.jsonBodyPure), null);
    } else {
      return response.getPairError;
    }
  }

  void reInit() {
    textController.text = '';
    emit(CreateTrainerFileInitial.initial());
  }

  void setFile(Uint8List? bytes) {
    state.mRequest.file = UploadFile(nameField: 'file', fileBytes: bytes);
  }

  void onCreate() {
    if (state.mRequest.file?.fileBytes == null) return;
    state.mRequest.content = textController.text;

    createTrainerFile();
  }
}
