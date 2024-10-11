import 'package:fitness_storm/core/app/app_provider.dart';
import 'package:fitness_storm/core/extensions/extensions.dart';
import 'package:fitness_storm/core/models/plan_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';

import '../../../../core/util/my_style.dart';
import '../../../../generated/assets.dart';
import '../../../bookmarked/bloc/add_favorite/add_favorite_cubit.dart';
import '../../bloc/bookmarked_cubit/bookmarked_cubit.dart';

class BookMarkedBtn extends StatefulWidget {
  const BookMarkedBtn({super.key, required this.plan});

  final Plan plan;

  @override
  State<BookMarkedBtn> createState() => _BookMarkedBtnState();
}

class _BookMarkedBtnState extends State<BookMarkedBtn> {
  @override
  Widget build(BuildContext context) {
    if (AppProvider.isGuest) return 0.0.verticalSpace;
    return SizedBox(
      height: 40.0.r,
      width: 40.0.r,
      child: BlocConsumer<AddFavoriteCubit, AddFavoriteInitial>(
        listenWhen: (p, c) => (c.plan.id == widget.plan.id) && (c.statuses.done),
        listener: (context, state) {
          if (state.plan.isBookmark) {
            context.read<BookmarkedCubit>().addBookmark(state.plan);
          } else {
            context.read<BookmarkedCubit>().deleteBookmarkFromCache(
                  state.plan.id.toString(),
                );
          }
          setState(() => widget.plan.isBookmark = !widget.plan.isBookmark);
        },
        buildWhen: (p, c) => c.plan.id == widget.plan.id,
        builder: (context, state) {
          if (state.statuses.loading) {
            return MyStyle.loadingWidget();
          }
          return IconButton(
            onPressed: () {
              context.read<AddFavoriteCubit>().changeFavorite(plan: widget.plan);
            },
            icon: ImageMultiType(
              url: state.plan.isBookmark ? Assets.imagesActiveFav : Assets.imagesBookmark,
              color: state.plan.isBookmark ? null : Colors.grey[300],
              height: 30.0.r,
              width: 30.0.r,
            ),
          );
        },
      ),
    );
  }
}
