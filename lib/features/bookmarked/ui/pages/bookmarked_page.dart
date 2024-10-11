import 'package:fitness_storm/core/extensions/extensions.dart';
import 'package:fitness_storm/core/widgets/app_bar/app_bar_widget.dart';
import 'package:fitness_storm/features/plans/ui/widget/item_plan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/util/my_style.dart';
import '../../../../generated/l10n.dart';
import '../../bloc/bookmarked_cubit/bookmarked_cubit.dart';

class BookmarkedPage extends StatelessWidget {
  const BookmarkedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(titleText: S.of(context).bookmarkedPlans),
      body: BlocBuilder<BookmarkedCubit, BookmarkedInitial>(
        builder: (context, state) {
          if (state.statuses.loading) {
            return MyStyle.loadingWidget();
          }
          final plans = state.result;
          return ListView.builder(
            shrinkWrap: true,
            itemCount: plans.length,
            itemBuilder: (context, i) {
              return ItemPlan(plan: plans[i]);
            },
          );
        },
      ),
    );
  }
}
