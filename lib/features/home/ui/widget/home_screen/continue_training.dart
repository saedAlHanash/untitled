import 'package:fitness_storm/core/extensions/extensions.dart';
import 'package:fitness_storm/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';

import '../../../../../../../generated/l10n.dart';
import '../../../../plans/bloc/active_plans_cubit/active_plans_cubit.dart';
import '../../widget/list_header.dart';

class ContinueTrainingWidget extends StatelessWidget {

  const ContinueTrainingWidget();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ActivePlansCubit, ActivePlansInitial>(
      builder: (context, state) {
        final plans = state.result;
        if (plans.isEmpty) return 0.0.verticalSpace;
        return Column(
          children: [
            ListHeader(headerTitle: S.of(context).continueTraining),
            SizedBox(
              width: 1.0.sw,
              height: 0.2.sh,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: plans.length,
                itemBuilder: (_, i) {
                  final item = plans[i];
                  return InkWell(
                    onTap: () {
                      startPlanPage(item.id.toString());
                    },
                    child: SizedBox(
                      width: 1.0.sw,
                      height: 0.2.sh,
                      child: Stack(
                        children: [
                          ImageMultiType(
                            url: item.image,
                            fit: BoxFit.cover,
                            width: 1.0.sw,
                          ),
                          Positioned(
                            top: 10.0.h,
                            left: 10.0.w,
                            child: item.progressWidget,
                          ),
                          Positioned(
                            top: 45.0.h,
                            left: 10.0.w,
                            child: item.dayWidget,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}