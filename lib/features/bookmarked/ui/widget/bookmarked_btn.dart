import 'package:fitness_storm/core/extensions/extensions.dart';
import 'package:fitness_storm/core/models/plan_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';

import '../../../../core/util/my_style.dart';
import '../../../../generated/assets.dart';
import '../../../plans/bloc/add_favorite/add_favorite_cubit.dart';
import '../../bloc/bookmarked_cubit/bookmarked_cubit.dart';

class BookMarkedBtn extends StatefulWidget {
  const BookMarkedBtn({super.key, required this.plan});

  final PlanModel plan;

  @override
  State<BookMarkedBtn> createState() => _BookMarkedBtnState();
}

class _BookMarkedBtnState extends State<BookMarkedBtn> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.0.r,
      width: 50.0.r,
      child: BlocConsumer<AddFavoriteCubit, AddFavoriteInitial>(
        listenWhen: (p, c) =>
            (c.plan.id == widget.plan.id) && (c.statuses.done),
        listener: (context, state) {
          context.read<BookmarkedCubit>().getBookmarked(newData: true);
          setState(() => widget.plan.isBookmark = !widget.plan.isBookmark);
        },
        buildWhen: (p, c) => c.plan.id == widget.plan.id,
        builder: (context, state) {
          if (state.statuses.loading) {
            return MyStyle.loadingWidget();
          }
          return IconButton(
            onPressed: () {
              context
                  .read<AddFavoriteCubit>()
                  .changeFavorite(plan: widget.plan);
            },
            icon: ImageMultiType(
              url: state.plan.isBookmark
                  ? Assets.imagesActiveFav
                  : Assets.imagesBookmark,
              height: 30.0.r,
              width: 30.0.r,
            ),
          );
        },
      ),
    );
  }
}
