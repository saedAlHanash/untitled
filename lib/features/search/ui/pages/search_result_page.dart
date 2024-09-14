import 'package:fitness_storm/core/extensions/extensions.dart';
import 'package:fitness_storm/core/widgets/app_bar/app_bar_widget.dart';
import 'package:fitness_storm/core/widgets/refresh_widget/refresh_widget.dart';
import 'package:fitness_storm/core/widgets/spinner_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../Screen/Trainee Screens/HomeScreen/HomeSreenWidget/yourTainerWidget/your_trainer_widget.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../generated/l10n.dart';
import '../../../trainer/ui/widget/trainer_widget.dart';
import '../../bloc/temp_cubit/search_cubit.dart';

class SearchResultPage extends StatelessWidget {
  const SearchResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(titleText: S.of(context).searchResult),
      body: BlocBuilder<SearchCubit, SearchInitial>(
        builder: (context, state) {
          return Column(
            children: [
              10.0.verticalSpace,
              Row(
                children: [
                  15.0.horizontalSpace,
                  Expanded(
                    child: SpinnerWidget(
                      onChanged: (spinnerItem) {
                        context.read<SearchCubit>()
                          ..setTrainingType = spinnerItem.item
                          ..getSearch();
                      },
                      hintText: S.of(context).trainingType,
                      searchable: false,
                      items: TrainingTypeEnum.values.getSpinnerItems(
                        selected: state.mRequest.trainingType?.index,
                      ),
                    ),
                  ),
                  15.0.horizontalSpace,
                  Expanded(
                    child: SpinnerWidget(
                      onChanged: (spinnerItem) {
                        context.read<SearchCubit>()
                          ..setTrainingLeve = spinnerItem.item
                          ..getSearch();
                      },
                      hintText: S.of(context).trainingLeve,
                      searchable: false,
                      items: TrainingLevelEnum.values.getSpinnerItems(
                        selected: state.mRequest.fitnessLevel?.index,
                      ),
                    ),
                  ),
                  15.0.horizontalSpace,
                ],
              ),
              Expanded(
                child: RefreshWidget(
                  isLoading: state.loading,
                  onRefresh: () {
                    context.read<SearchCubit>().getSearch();
                  },
                  child: ListView.builder(
                    itemCount: state.result.length,
                    itemBuilder: (context, i) {
                      final trainer = state.result[i];
                      return GestureDetector(
                        onTap: () => startTrainerPage(context, state.result[i].id),
                        child: TrainerWidget(
                          trainer: trainer,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
